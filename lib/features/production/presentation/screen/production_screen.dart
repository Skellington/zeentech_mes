import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/local_database.dart' as db;
import '../../../../core/providers.dart';

import '../../../../core/ui/glass_container.dart';
import '../../production.dart';

class ProductionScreen extends ConsumerStatefulWidget {
  const ProductionScreen({super.key});

  @override
  ConsumerState<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends ConsumerState<ProductionScreen> {
  Station? _selectedStation;
  bool _isExport = false;
  final _barcodeController = TextEditingController();
  final _volumeController = TextEditingController();
  final _quantityController = TextEditingController();
  final FocusNode _barcodeFocus = FocusNode();

  // State for Rapid Feedback
  Color? _flashColor;
  Timer? _flashTimer;

  final _volumeFocus = FocusNode();
  final _quantityFocus = FocusNode();

  // Part Type State
  int? _selectedPartTypeId;
  Timer? _idleTimer;
  bool _isSubmitting = false; // LOCKER

  void _selectPartType(int? id) {
    setState(() {
      _selectedPartTypeId = id;
    });
    _resetIdleTimer();
  }

  void _resetIdleTimer() {
    _idleTimer?.cancel();
    if (_selectedPartTypeId != null) {
      _idleTimer = Timer(const Duration(seconds: 60), () {
        if (mounted) {
          setState(() {
            _selectedPartTypeId = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Seleção de peça resetada por inatividade.")),
          );
        }
      });
    }
  }

  void _triggerFlash(Color color) {
    setState(() => _flashColor = color);
    _flashTimer?.cancel();
    _flashTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _flashColor = null);
    });
  }

  @override
  void initState() {
    super.initState();
    // Request focus on barcode field automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isExport) _barcodeFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _volumeController.dispose();
    _quantityController.dispose();
    _barcodeFocus.dispose();
    _volumeFocus.dispose();
    _quantityFocus.dispose();
    _flashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic Colors based on Mode
    final modeColor = _isExport ? Colors.orangeAccent : Colors.greenAccent;
    final modeLabel = _isExport ? "MODO EXPORTAÇÃO" : "MODO NACIONAL (RÁPIDO)";

    return Stack(
      children: [
        Column(
          children: [
            // 1. Top Bar
            GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              opacity: 0.1,
              child: Row(
                children: [
                  Icon(Icons.location_on, color: modeColor),
                  const Gap(12),
                  // Station Dropdown
                  _StationDropdown(
                    selectedStation: _selectedStation,
                    onStationChanged: (station) {
                      setState(() {
                        _selectedStation = station;
                      });
                      if (!_isExport && station != null) {
                        _barcodeFocus.requestFocus();
                      }
                    },
                  ),
                  const Gap(16),
                  if (_selectedStation != null) ...[
                    if (_selectedStation!.assignedPackerId1 != null)
                      _PackerInfoChip(
                          packerId: _selectedStation!.assignedPackerId1!),
                    const Gap(8),
                    if (_selectedStation!.assignedPackerId2 != null)
                      _PackerInfoChip(
                          packerId: _selectedStation!.assignedPackerId2!),
                  ]
                ],
              ),
            ),

            // Mode Indicator Bar
            Container(
              height: 4,
              width: double.infinity,
              color: modeColor,
            ),

            const Gap(16),

            // 2. Metrics Grid (Responsive)
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 1200;

                  if (isWide) {
                    // WIDE MODE (Original Row Layout)
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Left Panel: Production Input
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 24, bottom: 24),
                            child: Column(
                              children: [
                                // Scrollable Area (Header + Inputs)
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // Header
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(modeLabel,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: modeColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1.2)),
                                            ),
                                            Row(
                                              children: [
                                                Text("Nacional",
                                                    style: TextStyle(
                                                        color: !_isExport
                                                            ? Colors.greenAccent
                                                            : Colors.white38)),
                                                Switch(
                                                  activeThumbColor:
                                                      Colors.orangeAccent,
                                                  inactiveThumbColor:
                                                      Colors.greenAccent,
                                                  value: _isExport,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _isExport = val;
                                                      // FOCUS LOGIC
                                                      if (_isExport) {
                                                        _volumeFocus
                                                            .requestFocus();
                                                      } else {
                                                        _barcodeFocus
                                                            .requestFocus();
                                                      }
                                                    });
                                                  },
                                                ),
                                                Text("Exportação",
                                                    style: TextStyle(
                                                        color: _isExport
                                                            ? Colors
                                                                .orangeAccent
                                                            : Colors.white38)),
                                              ],
                                            )
                                          ],
                                        ),

                                        const Gap(16),

                                        // Part Type Selector
                                        // Part Type Selector (Always Visible)
                                        const Text("Selecione o Tipo de Peça:",
                                            style: TextStyle(
                                                color: Colors.white70)),
                                        const Gap(8),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            final partTypesAsync = ref.watch(
                                                partTypeControllerProvider);
                                            return partTypesAsync.when(
                                              data: (types) {
                                                if (types.isEmpty) {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                                return Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: types.map((type) {
                                                    final isSelected =
                                                        _selectedPartTypeId ==
                                                            type.id;
                                                    return FilterChip(
                                                      label: Text(type.name),
                                                      selected: isSelected,
                                                      onSelected: (val) {
                                                        _selectPartType(val
                                                            ? type.id
                                                            : null);
                                                      },
                                                      selectedColor:
                                                          Colors.blueAccent,
                                                      checkmarkColor:
                                                          Colors.white,
                                                      labelStyle: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : Colors.white70,
                                                        fontWeight: isSelected
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                    );
                                                  }).toList(),
                                                );
                                              },
                                              loading: () =>
                                                  const CircularProgressIndicator(),
                                              error: (e, s) => Text("Erro: $e",
                                                  style: const TextStyle(
                                                      color: Colors.red)),
                                            );
                                          },
                                        ),
                                        const Gap(16),

                                        // Main Input Area
                                        GlassContainer(
                                          padding: const EdgeInsets.all(
                                              32), // More padding
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          opacity: 0.1,
                                          child: _isExport
                                              ? _buildExportForm(context)
                                              : _buildNationalScanner(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const Gap(16),

                                // Stopwatch (Pinned Bottom)
                                GlassContainer(
                                  padding: const EdgeInsets.all(16),
                                  borderRadius: BorderRadius.circular(16),
                                  opacity: 0.1,
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      final stopwatchState =
                                          ref.watch(stopwatchProvider);
                                      final notifier =
                                          ref.read(stopwatchProvider.notifier);
                                      final stationId = _selectedStation?.id;

                                      final currentDowntime = stationId != null
                                          ? stopwatchState
                                              .activeStops[stationId]
                                          : null;

                                      final isRunning =
                                          currentDowntime?.isRunning ?? false;
                                      final elapsed =
                                          currentDowntime?.elapsed ??
                                              Duration.zero;

                                      return Row(
                                        children: [
                                          const Icon(Icons.timer,
                                              color: Colors.white54),
                                          const Gap(16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Controle de Parada",
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: 12)),
                                                Text(_formatDuration(elapsed),
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontFamily: 'monospace',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                if (currentDowntime
                                                        ?.currentReason !=
                                                    null)
                                                  Text(
                                                    currentDowntime!
                                                        .currentReason!,
                                                    style: const TextStyle(
                                                        color: Colors.white30,
                                                        fontSize: 10),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: isRunning
                                                    ? Colors.green
                                                    : Colors.redAccent,
                                                foregroundColor: Colors.white),
                                            onPressed: () =>
                                                _handleStopwatchToggle(context,
                                                    notifier, isRunning),
                                            child: Text(isRunning
                                                ? "RETOMAR PRODUÇÃO"
                                                : "PARAR LINHA"),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(16),

                        // Right Panel: Recent History (Rapid View)
                        Expanded(
                          flex: 2, // Wider for readability
                          child: HistoryPanel(stationId: _selectedStation?.id),
                        ),
                      ],
                    );
                  } else {
                    // NARROW MODE (Column Layout)
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                // Header
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(modeLabel,
                                          style: TextStyle(
                                              fontSize: 20, // Smaller font
                                              color: modeColor,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2)),
                                    ),
                                    Column(
                                      // Stack switch for space
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Nacional",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: !_isExport
                                                        ? Colors.greenAccent
                                                        : Colors.white38)),
                                            Switch(
                                              activeThumbColor:
                                                  Colors.orangeAccent,
                                              inactiveThumbColor:
                                                  Colors.greenAccent,
                                              value: _isExport,
                                              onChanged: (val) {
                                                setState(() {
                                                  _isExport = val;
                                                  if (_isExport) {
                                                    _volumeFocus.requestFocus();
                                                  } else {
                                                    _barcodeFocus
                                                        .requestFocus();
                                                  }
                                                });
                                              },
                                            ),
                                            Text("Exportação",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: _isExport
                                                        ? Colors.orangeAccent
                                                        : Colors.white38)),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                const Gap(16),

                                // Part Type Selector
                                // Part Type Selector (Always Visible)
                                const Text("Selecione o Tipo de Peça:",
                                    style: TextStyle(color: Colors.white70)),
                                const Gap(8),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final partTypesAsync =
                                        ref.watch(partTypeControllerProvider);
                                    return partTypesAsync.when(
                                      data: (types) {
                                        if (types.isEmpty) {
                                          return const SizedBox.shrink();
                                        }
                                        return Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: types.map((type) {
                                            final isSelected =
                                                _selectedPartTypeId == type.id;
                                            return FilterChip(
                                              label: Text(type.name),
                                              selected: isSelected,
                                              onSelected: (val) {
                                                _selectPartType(
                                                    val ? type.id : null);
                                              },
                                              selectedColor: Colors.blueAccent,
                                              checkmarkColor: Colors.white,
                                              labelStyle: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.white70,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                      loading: () =>
                                          const CircularProgressIndicator(),
                                      error: (e, s) => Text("Erro: $e",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                    );
                                  },
                                ),
                                const Gap(16),

                                // Main Input Area
                                GlassContainer(
                                  padding: const EdgeInsets.all(24),
                                  borderRadius: BorderRadius.circular(16),
                                  opacity: 0.1,
                                  child: _isExport
                                      ? _buildExportForm(context)
                                      : _buildNationalScanner(context),
                                ),

                                const Gap(16),

                                // Stopwatch
                                GlassContainer(
                                  padding: const EdgeInsets.all(16),
                                  borderRadius: BorderRadius.circular(16),
                                  opacity: 0.1,
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      final stopwatchState =
                                          ref.watch(stopwatchProvider);
                                      final notifier =
                                          ref.read(stopwatchProvider.notifier);
                                      final stationId = _selectedStation?.id;

                                      final currentDowntime = stationId != null
                                          ? stopwatchState
                                              .activeStops[stationId]
                                          : null;

                                      final isRunning =
                                          currentDowntime?.isRunning ?? false;
                                      final elapsed =
                                          currentDowntime?.elapsed ??
                                              Duration.zero;

                                      return Row(
                                        children: [
                                          const Icon(Icons.timer,
                                              color: Colors.white54),
                                          const Gap(16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Controle de Parada",
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: 12)),
                                                Text(_formatDuration(elapsed),
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontFamily: 'monospace',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: isRunning
                                                    ? Colors.green
                                                    : Colors.redAccent,
                                                foregroundColor: Colors.white),
                                            onPressed: () =>
                                                _handleStopwatchToggle(context,
                                                    notifier, isRunning),
                                            child: Text(isRunning
                                                ? "RETOMAR"
                                                : "PARAR"),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Divider(color: Colors.white10),

                          // History Panel (Constrained Height)
                          SizedBox(
                            height: 500,
                            child:
                                HistoryPanel(stationId: _selectedStation?.id),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),

        // Flash Overlay
        if (_flashColor != null)
          IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              color: _flashColor!.withValues(alpha: 0.3),
            ),
          ),
      ],
    );
  }

  Widget _buildNationalScanner(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.qr_code_scanner, size: 64, color: Colors.greenAccent),
        const Gap(24),
        Focus(
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.tab ||
                  event.logicalKey == LogicalKeyboardKey.arrowDown ||
                  event.logicalKey == LogicalKeyboardKey.arrowUp ||
                  event.logicalKey == LogicalKeyboardKey.arrowLeft ||
                  event.logicalKey == LogicalKeyboardKey.arrowRight) {
                return KeyEventResult.handled; // PREVENT FOCUS LOSS
              }
            }
            return KeyEventResult.ignored;
          },
          child: TextField(
            controller: _barcodeController,
            focusNode: _barcodeFocus,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "ESCANEIE AGORA",
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.1)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.black12,
            ),
            onChanged: (val) {
              // AUTO-SUBMIT LOGIC
              if (!_isExport) {
                // Fix: Only auto-submit on 10 digits (Volume ID).
                // Do NOT submit on 8 digits, as it interrupts the typing of a 10-digit code!
                if (val.length == 10) {
                  _submitProduction(val);
                }
              }
            },
            onSubmitted: (val) => _submitProduction(val),
          ),
        ),
        const Gap(16),
        const Text("Modo de Alta Velocidade Ativo",
            style: TextStyle(color: Colors.greenAccent, letterSpacing: 1.5)),
        const Text(
            "O sistema registrará automaticamente e estará pronto para o próximo.",
            style: TextStyle(color: Colors.white30, fontSize: 12)),
      ],
    );
  }

  Widget _buildExportForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Registro Manual de Exportação",
            style: TextStyle(fontSize: 20, color: Colors.orangeAccent)),
        const Gap(32),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _volumeController,
                focusNode: _volumeFocus,
                style: const TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: "Volume", border: OutlineInputBorder()),
                onSubmitted: (_) =>
                    _quantityFocus.requestFocus(), // Enter jumps to Quantity
              ),
            ),
            const Gap(16),
            Expanded(
              child: TextField(
                controller: _quantityController,
                focusNode: _quantityFocus,
                style: const TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: "Quantidade de Peças",
                    border: OutlineInputBorder()),
                onSubmitted: (_) =>
                    _submitProduction(_volumeController.text), // Enter submits
              ),
            ),
          ],
        ),
        const Gap(32),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.black),
            icon: const Icon(Icons.save),
            label: const Text("REGISTRAR EXPORTAÇÃO",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onPressed: () => _submitProduction(_volumeController.text),
          ),
        )
      ],
    );
  }

  // Helper
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  Future<void> _handleStopwatchToggle(
      BuildContext context, StopwatchNotifier notifier, bool isRunning) async {
    if (_selectedStation == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Selecione uma estação primeiro."),
          backgroundColor: Colors.red));
      return;
    }

    final stationId = _selectedStation!.id;

    if (isRunning) {
      await notifier.stop(stationId);
    } else {
      final reason = await showDialog<String>(
        context: context,
        builder: (ctx) => _ReasonDialog(),
      );
      if (reason != null && reason.isNotEmpty) {
        notifier.start(stationId, reason);
      }
    }
  }

  Future<void> _submitProduction(String barcode) async {
    if (_isSubmitting) return; // PREVENT DOUBLE SUBMISSION
    _isSubmitting = true;

    try {
      // 1. Validate Input (Empty check)
      if (barcode.isEmpty) {
        if (_isExport) _showError("Informe o Volume!");
        return;
      }

      // 2. STRICT VALIDATION (Volume ID vs Part Number)
      if (!_isExport) {
        // Rule: Volume ID is EXACTLY 10 digits (Numeric).
        // Part Number is usually 8 digits.
        // Location contains letters.

        final isVolumeId = RegExp(r'^\d{10}$').hasMatch(barcode);
        final isPartNumber = RegExp(r'^\d{8}$').hasMatch(barcode);

        if (isVolumeId) {
          // ACCEPT: Valid Volume ID, proceed below.
        } else if (isPartNumber) {
          // IGNORE: It's just a part number scan, not a volume.
          // Subtle feedback (Flash Warning) without error sound.
          _triggerFlash(Colors.orangeAccent);
          _barcodeController.clear();
          _barcodeFocus.requestFocus();
          return;
        } else {
          // ERROR: Random scan (Location, trash, or partial).
          // Trigger Red Flash + Error to indicate "Wrong Barcode"
          _triggerFlash(Colors.redAccent);
          _barcodeController.clear();
          _barcodeFocus.requestFocus();
          // Optional: Show error message if needed, but RED flash is usually sufficient for speed.
          // _showError("Código Inválido");
          return;
        }
      }

      // 3. Station Checks
      if (_selectedStation == null) {
        _showError("Selecione uma estação!");
        return;
      }
      if (_selectedStation!.assignedPackerId1 == null &&
          _selectedStation!.assignedPackerId2 == null) {
        _showError("Nenhum embalador na estação!");
        return;
      }

      // 4. DUPLICATE CHECK
      final repo = ref.read(productionRepositoryProvider);
      final existing =
          await repo.findProductionByBarcode(barcode, DateTime.now());

      if (existing != null) {
        await SystemSound.play(SystemSoundType.alert);

        // Fetch station name
        final stations = await repo.getAllStations();
        final stationName = stations
            .firstWhere((s) => s.id == existing.stationId,
                orElse: () =>
                    const Station(id: 0, name: 'Desconhecida', status: 'OK'))
            .name;

        if (!mounted) return;

        _triggerFlash(Colors.redAccent);

        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.red[900],
            title: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 32),
                Gap(12),
                Text("Volume Duplicado!",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Este volume já foi registrado anteriormente.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Horário:",
                          DateFormat("HH:mm").format(existing.timestamp)),
                      const Gap(8),
                      _buildDetailRow("Estação:", stationName),
                      const Gap(8),
                      Row(
                        children: [
                          const Text("Tipo:",
                              style: TextStyle(color: Colors.white70)),
                          const Gap(8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: existing.type == ProductionType.national
                                  ? Colors.greenAccent.withValues(alpha: 0.2)
                                  : Colors.purpleAccent.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color:
                                      existing.type == ProductionType.national
                                          ? Colors.greenAccent
                                          : Colors.purpleAccent),
                            ),
                            child: Text(
                              existing.type == ProductionType.national
                                  ? "NACIONAL"
                                  : "EXPORTAÇÃO",
                              style: TextStyle(
                                color: existing.type == ProductionType.national
                                    ? Colors.greenAccent
                                    : Colors.purpleAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red[900]),
                onPressed: () => Navigator.pop(ctx),
                child: const Text("OK",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        );

        _barcodeController.clear();
        _barcodeFocus.requestFocus();
        return;
      }

      if (!mounted) return;

      final int? vol = _isExport ? int.tryParse(_volumeController.text) : null;
      final int? qty =
          _isExport ? int.tryParse(_quantityController.text) : null;

      try {
        // Validate Part Type Selection (Mandatory for BOTH Modes)
        if (_selectedPartTypeId == null) {
          // Visual & Audio Feedback
          _triggerFlash(Colors.redAccent);
          await SystemSound.play(SystemSoundType.alert);

          if (!mounted) return;

          // Show Error Dialog
          await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.red[900],
                    title: const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.white),
                        Gap(8),
                        Text("Atenção", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    content: const Text(
                        "Por favor, selecione o Tipo de Peça antes de escanear!",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    actions: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red[900]),
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text("OK",
                              style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ));

          if (_isExport) {
            _volumeFocus.requestFocus();
          } else {
            _barcodeController.clear();
            _barcodeFocus.requestFocus();
          }
          return;
        }

        // Reset Timer on action
        _resetIdleTimer();

        await ref
            .read(productionControllerProvider.notifier)
            .registerProduction(
              stationId: _selectedStation!.id,
              type: _isExport ? ProductionType.export : ProductionType.national,
              barcode: barcode,
              isExport: _isExport,
              volume: vol,
              quantity: qty,
              partTypeId: _selectedPartTypeId,
            );

        if (!mounted) return;

        // SUCCESS FEEDBACK
        _triggerFlash(Colors.greenAccent);

        if (_isExport) {
          _volumeController.clear();
          _quantityController.clear();
          _volumeFocus.requestFocus();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Exportação Registrada!"),
              backgroundColor: Colors.green));
        } else {
          // National: RAPID FIRE
          _barcodeController.clear();
          _barcodeFocus.requestFocus();
        }
      } catch (e) {
        if (!mounted) return;

        if (e is StationStoppedException) {
          _triggerFlash(Colors.redAccent); // Visual Cue

          // Show Warning Dialog
          final shouldForce = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red[900],
              title: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.white, size: 32),
                  SizedBox(width: 12),
                  Text("ESTAÇÃO PARADA!",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              content: const Text(
                "Esta estação está em pausa. Deseja registrar a produção mesmo assim?",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false), // No
                  child: const Text("CANCELAR",
                      style: TextStyle(color: Colors.white70)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red[900]),
                  onPressed: () => Navigator.pop(context, true), // Yes
                  child: const Text("SIM, REGISTRAR (FORÇAR)"),
                ),
              ],
            ),
          );

          if (shouldForce == true) {
            // Retry with Force
            try {
              await ref
                  .read(productionControllerProvider.notifier)
                  .registerProduction(
                    stationId: _selectedStation!.id,
                    type: _isExport
                        ? ProductionType.export
                        : ProductionType.national,
                    barcode: barcode,
                    isExport: _isExport,
                    volume: vol,
                    quantity: qty,
                    partTypeId: _selectedPartTypeId,
                    force: true, // FORCE
                  );

              if (!mounted) return;
              _triggerFlash(Colors.greenAccent);

              if (_isExport) {
                _volumeController.clear();
                _quantityController.clear();
                _volumeFocus.requestFocus();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Exportação Registrada!"),
                    backgroundColor: Colors.green));
              } else {
                _barcodeController.clear();
                _barcodeFocus.requestFocus();
                // Keep selection for next scan in Rapid Mode?
                // Requirement says "Reset after 60s". So we KEEP it.
                _resetIdleTimer();
              }
              return;
            } catch (forceError) {
              _showError(forceError.toString());
            }
          } else {
            // Cancelled
            _barcodeController.clear();
            _barcodeFocus.requestFocus();
          }
        } else {
          _triggerFlash(Colors.redAccent);
          _showError(e.toString());
          if (!_isExport) _barcodeFocus.requestFocus();
        }
      }
    } finally {
      if (mounted) {
        _isSubmitting = false;
      }
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const Gap(8),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating));
  }
}

// 4. Recent History Widget (Last 1 Minute)
// 4. Recent History Widget (Last 1 Minute) - OPTIMIZED
// 4. History Panel with Search
class HistoryPanel extends ConsumerStatefulWidget {
  final int? stationId;
  const HistoryPanel({super.key, this.stationId});

  @override
  ConsumerState<HistoryPanel> createState() => _HistoryPanelState();
}

class _HistoryPanelState extends ConsumerState<HistoryPanel> {
  List<ProductionRecord> _history = [];
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _performSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HistoryPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stationId != widget.stationId) {
      _performSearch();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _performSearch();
    });
  }

  Future<void> _performSearch() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final repo = ref.read(productionRepositoryProvider);
      final query = _searchController.text.trim();
      final results = await repo.searchProduction(query);

      if (!mounted) return;

      var filtered = results;

      if (query.isEmpty && widget.stationId != null) {
        filtered =
            results.where((p) => p.stationId == widget.stationId).toList();
      }

      setState(() {
        _history = filtered;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<_HistoryGroup> _groupRecords(List<ProductionRecord> raw) {
    final Map<String, _HistoryGroup> groups = {};

    for (var record in raw) {
      final timeKey =
          "${record.timestamp.year}${record.timestamp.month}${record.timestamp.day}${record.timestamp.hour}${record.timestamp.minute}";
      final key = "${record.stationId}_${record.barcode}_$timeKey";

      if (groups.containsKey(key)) {
        final existing = groups[key]!;
        groups[key] =
            existing.copyWith(totalPackers: existing.totalPackers + 1);
      } else {
        groups[key] = _HistoryGroup(
          barcode: record.barcode,
          timestamp: record.timestamp,
          stationId: record.stationId,
          isExport: record.type == ProductionType.export,
          totalPackers: 1,
          itemCount: record.itemCount,
          partTypeId: record.partTypeId,
        );
      }
    }

    final list = groups.values.toList();
    list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // React to new scans
    ref.listen(productionControllerProvider, (_, next) {
      if (next is AsyncData) {
        _performSearch();
      }
    });

    // SOLID FIX: Properly watch the provider and handle states
    final partTypesAsync = ref.watch(partTypeControllerProvider);

    // Safely extract list, defaulting to empty if loading/error (keeps UI stable)
    final partTypes = partTypesAsync.maybeWhen(
      data: (data) => data,
      orElse: () => <db.PartType>[],
    );

    final partTypeMap = {for (var t in partTypes) t.id: t.name};

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      opacity: 0.1,
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Buscar Volume...",
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          const Gap(12),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _history.isEmpty
                    ? Center(
                        child: Text("Nenhum registro encontrado.",
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.3))))
                    : ListView.separated(
                        itemCount: _groupRecords(_history).length,
                        separatorBuilder: (_, __) =>
                            const Divider(color: Colors.white10),
                        itemBuilder: (context, index) {
                          final groupedList = _groupRecords(_history);
                          final item = groupedList[index];
                          final isExport = item.isExport;

                          // Subtitle Logic
                          String subtitleText;

                          // Improved Resolution Logic
                          String partTypeName = "Sem Tipo";

                          if (item.partTypeId != null) {
                            if (partTypeMap.containsKey(item.partTypeId)) {
                              partTypeName = partTypeMap[item.partTypeId]!;
                            } else {
                              // If ID exists but not in map, it might be loading or deleted.
                              // We check if partTypes are loaded.
                              if (partTypes.isEmpty &&
                                  partTypesAsync.isLoading) {
                                partTypeName = "..."; // Loading indicator
                              } else {
                                partTypeName =
                                    "ID: ${item.partTypeId}"; // Fallback to ID
                              }
                            }
                          }

                          if (isExport) {
                            subtitleText =
                                "Vol: ${item.barcode} • Qtd: ${item.itemCount} • $partTypeName";
                          } else {
                            subtitleText =
                                "Vol: ${item.barcode} • $partTypeName";
                          }

                          if (item.totalPackers > 1) {
                            subtitleText += " (Equipe Dupla)";
                          }

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isExport
                                    ? Colors.purpleAccent.withValues(alpha: 0.2)
                                    : Colors.greenAccent.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: isExport
                                        ? Colors.purpleAccent
                                        : Colors.greenAccent,
                                    width: 1),
                              ),
                              child: Text(
                                isExport ? "EXP" : "NAC",
                                style: TextStyle(
                                  color: isExport
                                      ? Colors.purpleAccent
                                      : Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            title: Text(
                                "[${DateFormat("HH:mm").format(item.timestamp)}] - Estação ${item.stationId}",
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                            subtitle: Text(subtitleText,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'monospace')),
                            trailing: isExport
                                ? const Icon(Icons.public,
                                    color: Colors.purpleAccent, size: 16)
                                : const Icon(Icons.flag,
                                    color: Colors.greenAccent, size: 16),
                            dense: true,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _ReasonDialog extends StatefulWidget {
  @override
  State<_ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<_ReasonDialog> {
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // FIX: Using Center Constraints here too as requested
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text('Motivo da Parada'),
          content: TextField(
            controller: _ctrl,
            decoration: const InputDecoration(
                hintText: 'Ex: Falta de material, Banheiro...'),
            autofocus: true,
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, _ctrl.text),
                child: const Text('Iniciar Parada')),
          ],
        ),
      ),
    );
  }
}

class _PackerInfoChip extends ConsumerWidget {
  final int packerId;
  const _PackerInfoChip({required this.packerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Optimization: Watch the controller state which is already cached by Riverpod
    // Assuming 'packerControllerProvider' returns AsyncValue<List<Packer>>
    final packersAsync = ref.watch(packerControllerProvider);

    return packersAsync.when(
      data: (packers) {
        // Find the packer in the cached list
        final p = packers.firstWhere(
          (x) => x.id == packerId,
          orElse: () => const Packer(
              id: -1,
              name: 'Desconhecido',
              phone: '',
              email: '',
              isActive: false),
        );

        return Chip(
          avatar: const CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 16, color: Colors.white),
          ),
          label: Text(p.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
          side: BorderSide(color: Colors.blueAccent.withValues(alpha: 0.5)),
        );
      },
      // Do not show loading/error for chips to avoid layout jumps, just shrink
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

/// A Dropdown for Station Selection with fixed size and proper state handling
class _StationDropdown extends ConsumerWidget {
  final Station? selectedStation;
  final ValueChanged<Station?> onStationChanged;

  const _StationDropdown({
    required this.selectedStation,
    required this.onStationChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationsAsync = ref.watch(stationControllerProvider);

    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: stationsAsync.when(
          data: (stations) {
            // 1. Sort Alphabetically
            final sortedStations = List<Station>.from(stations)
              ..sort((a, b) => a.name.compareTo(b.name));

            return DropdownButtonHideUnderline(
              child: DropdownButton<Station?>(
                value: selectedStation,
                hint: const Text("Selecione a Estação",
                    style: TextStyle(color: Colors.white70)),
                isExpanded: true,
                dropdownColor: const Color(0xFF1E293B), // Matches App Theme
                iconEnabledColor: Colors.white70,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                items: [
                  // 2. "Clear Selection" Option
                  const DropdownMenuItem<Station?>(
                    value: null,
                    child: Text(
                      "Todas as Estações",
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 3. Sorted Stations
                  ...sortedStations.map((s) {
                    return DropdownMenuItem<Station?>(
                      value: s,
                      child: Text(s.name,
                          style:
                              const TextStyle(fontWeight: FontWeight.normal)),
                    );
                  }),
                ],
                onChanged: onStationChanged,
              ),
            );
          },
          loading: () => const Center(
              child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2))),
          error: (e, st) => Center(
              child:
                  Text("Erro: $e", style: const TextStyle(color: Colors.red))),
        ),
      ),
    );
  }
}

class _HistoryGroup {
  final String barcode;
  final DateTime timestamp;
  final int stationId;
  final bool isExport;
  final int totalPackers;
  final int itemCount;
  final int? partTypeId; // Added Field

  _HistoryGroup({
    required this.barcode,
    required this.timestamp,
    required this.stationId,
    required this.isExport,
    required this.totalPackers,
    required this.itemCount,
    this.partTypeId,
  });

  _HistoryGroup copyWith({int? totalPackers}) {
    return _HistoryGroup(
      barcode: barcode,
      timestamp: timestamp,
      stationId: stationId,
      isExport: isExport,
      totalPackers: totalPackers ?? this.totalPackers,
      itemCount: itemCount,
      partTypeId: partTypeId,
    );
  }
}
