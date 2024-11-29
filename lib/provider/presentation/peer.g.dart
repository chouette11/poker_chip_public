// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hostConsHash() => r'9909ebbc407d9ea750d02d8f3e85a98e99c49235';

/// See also [HostCons].
@ProviderFor(HostCons)
final hostConsProvider =
    AutoDisposeNotifierProvider<HostCons, List<DataConnection>>.internal(
  HostCons.new,
  name: r'hostConsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hostConsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HostCons = AutoDisposeNotifier<List<DataConnection>>;
String _$hostConnOpenHash() => r'd5ac56368f248a522ecec3f1d2df11c368714735';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$HostConnOpen extends BuildlessNotifier<bool> {
  late final Peer peer;

  bool build(
    Peer peer,
  );
}

/// See also [HostConnOpen].
@ProviderFor(HostConnOpen)
const hostConnOpenProvider = HostConnOpenFamily();

/// See also [HostConnOpen].
class HostConnOpenFamily extends Family<bool> {
  /// See also [HostConnOpen].
  const HostConnOpenFamily();

  /// See also [HostConnOpen].
  HostConnOpenProvider call(
    Peer peer,
  ) {
    return HostConnOpenProvider(
      peer,
    );
  }

  @override
  HostConnOpenProvider getProviderOverride(
    covariant HostConnOpenProvider provider,
  ) {
    return call(
      provider.peer,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hostConnOpenProvider';
}

/// See also [HostConnOpen].
class HostConnOpenProvider extends NotifierProviderImpl<HostConnOpen, bool> {
  /// See also [HostConnOpen].
  HostConnOpenProvider(
    Peer peer,
  ) : this._internal(
          () => HostConnOpen()..peer = peer,
          from: hostConnOpenProvider,
          name: r'hostConnOpenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hostConnOpenHash,
          dependencies: HostConnOpenFamily._dependencies,
          allTransitiveDependencies:
              HostConnOpenFamily._allTransitiveDependencies,
          peer: peer,
        );

  HostConnOpenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.peer,
  }) : super.internal();

  final Peer peer;

  @override
  bool runNotifierBuild(
    covariant HostConnOpen notifier,
  ) {
    return notifier.build(
      peer,
    );
  }

  @override
  Override overrideWith(HostConnOpen Function() create) {
    return ProviderOverride(
      origin: this,
      override: HostConnOpenProvider._internal(
        () => create()..peer = peer,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        peer: peer,
      ),
    );
  }

  @override
  NotifierProviderElement<HostConnOpen, bool> createElement() {
    return _HostConnOpenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HostConnOpenProvider && other.peer == peer;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, peer.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HostConnOpenRef on NotifierProviderRef<bool> {
  /// The parameter `peer` of this provider.
  Peer get peer;
}

class _HostConnOpenProviderElement
    extends NotifierProviderElement<HostConnOpen, bool> with HostConnOpenRef {
  _HostConnOpenProviderElement(super.provider);

  @override
  Peer get peer => (origin as HostConnOpenProvider).peer;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
