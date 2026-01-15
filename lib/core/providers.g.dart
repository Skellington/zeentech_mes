// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localDatabase)
final localDatabaseProvider = LocalDatabaseProvider._();

final class LocalDatabaseProvider
    extends $FunctionalProvider<LocalDatabase, LocalDatabase, LocalDatabase>
    with $Provider<LocalDatabase> {
  LocalDatabaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'localDatabaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$localDatabaseHash();

  @$internal
  @override
  $ProviderElement<LocalDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDatabase create(Ref ref) {
    return localDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDatabase>(value),
    );
  }
}

String _$localDatabaseHash() => r'dc7abbfdb67b853dbc578ba5d7ddbf4b0266197a';

@ProviderFor(productionRepository)
final productionRepositoryProvider = ProductionRepositoryProvider._();

final class ProductionRepositoryProvider extends $FunctionalProvider<
    IProductionRepository,
    IProductionRepository,
    IProductionRepository> with $Provider<IProductionRepository> {
  ProductionRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productionRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productionRepositoryHash();

  @$internal
  @override
  $ProviderElement<IProductionRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IProductionRepository create(Ref ref) {
    return productionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IProductionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IProductionRepository>(value),
    );
  }
}

String _$productionRepositoryHash() =>
    r'42c56a0f594d3d969f1f799a781d9e98e922ef01';

@ProviderFor(statisticsService)
final statisticsServiceProvider = StatisticsServiceProvider._();

final class StatisticsServiceProvider extends $FunctionalProvider<
    StatisticsService,
    StatisticsService,
    StatisticsService> with $Provider<StatisticsService> {
  StatisticsServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'statisticsServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$statisticsServiceHash();

  @$internal
  @override
  $ProviderElement<StatisticsService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StatisticsService create(Ref ref) {
    return statisticsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatisticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatisticsService>(value),
    );
  }
}

String _$statisticsServiceHash() => r'a2e5363eb3866b5105c8f9e44dd6f5cc2015a633';

@ProviderFor(downtimeRepository)
final downtimeRepositoryProvider = DowntimeRepositoryProvider._();

final class DowntimeRepositoryProvider extends $FunctionalProvider<
    IDowntimeRepository,
    IDowntimeRepository,
    IDowntimeRepository> with $Provider<IDowntimeRepository> {
  DowntimeRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'downtimeRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$downtimeRepositoryHash();

  @$internal
  @override
  $ProviderElement<IDowntimeRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IDowntimeRepository create(Ref ref) {
    return downtimeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IDowntimeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IDowntimeRepository>(value),
    );
  }
}

String _$downtimeRepositoryHash() =>
    r'78c4ec179e01ebc0fe7c40b479b5fb518c12f061';

@ProviderFor(partTypeRepository)
final partTypeRepositoryProvider = PartTypeRepositoryProvider._();

final class PartTypeRepositoryProvider extends $FunctionalProvider<
    PartTypeRepository,
    PartTypeRepository,
    PartTypeRepository> with $Provider<PartTypeRepository> {
  PartTypeRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'partTypeRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$partTypeRepositoryHash();

  @$internal
  @override
  $ProviderElement<PartTypeRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PartTypeRepository create(Ref ref) {
    return partTypeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PartTypeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PartTypeRepository>(value),
    );
  }
}

String _$partTypeRepositoryHash() =>
    r'19161646161a44b34d4087578660733bf3513f37';
