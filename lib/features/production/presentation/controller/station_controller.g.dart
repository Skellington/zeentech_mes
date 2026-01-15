// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StationController)
final stationControllerProvider = StationControllerProvider._();

final class StationControllerProvider
    extends $AsyncNotifierProvider<StationController, List<Station>> {
  StationControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'stationControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$stationControllerHash();

  @$internal
  @override
  StationController create() => StationController();
}

String _$stationControllerHash() => r'ef875ccce1333fb9ab72492e59307682ff8f9ac3';

abstract class _$StationController extends $AsyncNotifier<List<Station>> {
  FutureOr<List<Station>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Station>>, List<Station>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Station>>, List<Station>>,
        AsyncValue<List<Station>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
