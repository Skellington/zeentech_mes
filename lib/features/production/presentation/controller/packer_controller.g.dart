// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PackerController)
final packerControllerProvider = PackerControllerProvider._();

final class PackerControllerProvider
    extends $AsyncNotifierProvider<PackerController, List<Packer>> {
  PackerControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'packerControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$packerControllerHash();

  @$internal
  @override
  PackerController create() => PackerController();
}

String _$packerControllerHash() => r'a1f8a4616368411dd4be7dc9c6ea3c0c5d7c357d';

abstract class _$PackerController extends $AsyncNotifier<List<Packer>> {
  FutureOr<List<Packer>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Packer>>, List<Packer>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Packer>>, List<Packer>>,
        AsyncValue<List<Packer>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
