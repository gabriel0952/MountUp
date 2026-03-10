// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routeRepository)
final routeRepositoryProvider = RouteRepositoryProvider._();

final class RouteRepositoryProvider
    extends
        $FunctionalProvider<RouteRepository, RouteRepository, RouteRepository>
    with $Provider<RouteRepository> {
  RouteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeRepositoryHash();

  @$internal
  @override
  $ProviderElement<RouteRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RouteRepository create(Ref ref) {
    return routeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouteRepository>(value),
    );
  }
}

String _$routeRepositoryHash() => r'de4720374937114ee8ffabfe63102555ca2c546f';

@ProviderFor(routeList)
final routeListProvider = RouteListProvider._();

final class RouteListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RouteEntity>>,
          List<RouteEntity>,
          FutureOr<List<RouteEntity>>
        >
    with
        $FutureModifier<List<RouteEntity>>,
        $FutureProvider<List<RouteEntity>> {
  RouteListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeListHash();

  @$internal
  @override
  $FutureProviderElement<List<RouteEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RouteEntity>> create(Ref ref) {
    return routeList(ref);
  }
}

String _$routeListHash() => r'66fe484b1694c75a50e677c15376fecf1f067c8d';

@ProviderFor(routeById)
final routeByIdProvider = RouteByIdFamily._();

final class RouteByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<RouteEntity>,
          RouteEntity,
          FutureOr<RouteEntity>
        >
    with $FutureModifier<RouteEntity>, $FutureProvider<RouteEntity> {
  RouteByIdProvider._({
    required RouteByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'routeByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routeByIdHash();

  @override
  String toString() {
    return r'routeByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RouteEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RouteEntity> create(Ref ref) {
    final argument = this.argument as String;
    return routeById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routeByIdHash() => r'e10f55583d9df6b874e9f87bb274a4b4a1e483ab';

final class RouteByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RouteEntity>, String> {
  RouteByIdFamily._()
    : super(
        retry: null,
        name: r'routeByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RouteByIdProvider call(String id) =>
      RouteByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'routeByIdProvider';
}

@ProviderFor(routeGpx)
final routeGpxProvider = RouteGpxFamily._();

final class RouteGpxProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  RouteGpxProvider._({
    required RouteGpxFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'routeGpxProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routeGpxHash();

  @override
  String toString() {
    return r'routeGpxProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as String;
    return routeGpx(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteGpxProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routeGpxHash() => r'49474376ed5bfba15a6a3c8d12040cf44b9f4fc9';

final class RouteGpxFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String?>, String> {
  RouteGpxFamily._()
    : super(
        retry: null,
        name: r'routeGpxProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RouteGpxProvider call(String routeId) =>
      RouteGpxProvider._(argument: routeId, from: this);

  @override
  String toString() => r'routeGpxProvider';
}

@ProviderFor(RouteFilter)
final routeFilterProvider = RouteFilterProvider._();

final class RouteFilterProvider
    extends $NotifierProvider<RouteFilter, RouteFilterState> {
  RouteFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeFilterHash();

  @$internal
  @override
  RouteFilter create() => RouteFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouteFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouteFilterState>(value),
    );
  }
}

String _$routeFilterHash() => r'3875d3f5fba695ea358ab72592f4da06223b4319';

abstract class _$RouteFilter extends $Notifier<RouteFilterState> {
  RouteFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RouteFilterState, RouteFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RouteFilterState, RouteFilterState>,
              RouteFilterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
