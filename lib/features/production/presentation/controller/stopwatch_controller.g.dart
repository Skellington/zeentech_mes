// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stopwatch_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StopwatchNotifier)
final stopwatchProvider = StopwatchNotifierProvider._();

final class StopwatchNotifierProvider
    extends $NotifierProvider<StopwatchNotifier, StopwatchState> {
  StopwatchNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'stopwatchProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$stopwatchNotifierHash();

  @$internal
  @override
  StopwatchNotifier create() => StopwatchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StopwatchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StopwatchState>(value),
    );
  }
}

String _$stopwatchNotifierHash() => r'ccca7b7b2395dfe06e390d1396fe567dc2918f99';

abstract class _$StopwatchNotifier extends $Notifier<StopwatchState> {
  StopwatchState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<StopwatchState, StopwatchState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<StopwatchState, StopwatchState>,
        StopwatchState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
