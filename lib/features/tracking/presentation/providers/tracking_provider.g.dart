// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrackingNotifier)
final trackingProvider = TrackingNotifierProvider._();

final class TrackingNotifierProvider
    extends $NotifierProvider<TrackingNotifier, TrackingSessionState> {
  TrackingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackingNotifierHash();

  @$internal
  @override
  TrackingNotifier create() => TrackingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackingSessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackingSessionState>(value),
    );
  }
}

String _$trackingNotifierHash() => r'040c55884d5613d8a606174aa6b1646d6c3ddefe';

abstract class _$TrackingNotifier extends $Notifier<TrackingSessionState> {
  TrackingSessionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TrackingSessionState, TrackingSessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TrackingSessionState, TrackingSessionState>,
              TrackingSessionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
