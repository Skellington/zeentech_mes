// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardController)
final dashboardControllerProvider = DashboardControllerFamily._();

final class DashboardControllerProvider
    extends $AsyncNotifierProvider<DashboardController, DashboardData> {
  DashboardControllerProvider._(
      {required DashboardControllerFamily super.from,
      required DashboardFilter super.argument})
      : super(
          retry: null,
          name: r'dashboardControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dashboardControllerHash();

  @override
  String toString() {
    return r'dashboardControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DashboardController create() => DashboardController();

  @override
  bool operator ==(Object other) {
    return other is DashboardControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dashboardControllerHash() =>
    r'd13cfb0d73b7f26747ed03f45f0fe80154f36108';

final class DashboardControllerFamily extends $Family
    with
        $ClassFamilyOverride<DashboardController, AsyncValue<DashboardData>,
            DashboardData, FutureOr<DashboardData>, DashboardFilter> {
  DashboardControllerFamily._()
      : super(
          retry: null,
          name: r'dashboardControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DashboardControllerProvider call(
    DashboardFilter filter,
  ) =>
      DashboardControllerProvider._(argument: filter, from: this);

  @override
  String toString() => r'dashboardControllerProvider';
}

abstract class _$DashboardController extends $AsyncNotifier<DashboardData> {
  late final _$args = ref.$arg as DashboardFilter;
  DashboardFilter get filter => _$args;

  FutureOr<DashboardData> build(
    DashboardFilter filter,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DashboardData>, DashboardData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<DashboardData>, DashboardData>,
        AsyncValue<DashboardData>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

@ProviderFor(DashboardFilterController)
final dashboardFilterControllerProvider = DashboardFilterControllerProvider._();

final class DashboardFilterControllerProvider
    extends $NotifierProvider<DashboardFilterController, DashboardFilter> {
  DashboardFilterControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dashboardFilterControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dashboardFilterControllerHash();

  @$internal
  @override
  DashboardFilterController create() => DashboardFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardFilter>(value),
    );
  }
}

String _$dashboardFilterControllerHash() =>
    r'67878dfc05c35dfe749bfa8a6c16a809832125f5';

abstract class _$DashboardFilterController extends $Notifier<DashboardFilter> {
  DashboardFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DashboardFilter, DashboardFilter>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DashboardFilter, DashboardFilter>,
        DashboardFilter,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(dashboardData)
final dashboardDataProvider = DashboardDataProvider._();

final class DashboardDataProvider extends $FunctionalProvider<
        AsyncValue<DashboardData>, DashboardData, FutureOr<DashboardData>>
    with $FutureModifier<DashboardData>, $FutureProvider<DashboardData> {
  DashboardDataProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dashboardDataProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dashboardDataHash();

  @$internal
  @override
  $FutureProviderElement<DashboardData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardData> create(Ref ref) {
    return dashboardData(ref);
  }
}

String _$dashboardDataHash() => r'609f66c7f4cc0e88786a167fca4f4ed77f22071b';
