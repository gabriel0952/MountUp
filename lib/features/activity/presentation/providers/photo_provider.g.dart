// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoRepository)
final photoRepositoryProvider = PhotoRepositoryProvider._();

final class PhotoRepositoryProvider
    extends
        $FunctionalProvider<PhotoRepository, PhotoRepository, PhotoRepository>
    with $Provider<PhotoRepository> {
  PhotoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoRepositoryHash();

  @$internal
  @override
  $ProviderElement<PhotoRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoRepository create(Ref ref) {
    return photoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoRepository>(value),
    );
  }
}

String _$photoRepositoryHash() => r'90f61b9fb868005b2afb546dd2c8164cfe8699f6';
