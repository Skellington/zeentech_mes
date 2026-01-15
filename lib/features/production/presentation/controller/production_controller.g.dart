// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductionController)
final productionControllerProvider = ProductionControllerProvider._();

final class ProductionControllerProvider
    extends $AsyncNotifierProvider<ProductionController, void> {
  ProductionControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productionControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productionControllerHash();

  @$internal
  @override
  ProductionController create() => ProductionController();
}

String _$productionControllerHash() =>
    r'a21b2ce6d2edbe7d5daeb581253b670c5383f72d';

abstract class _$ProductionController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
