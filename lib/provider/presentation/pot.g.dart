// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pot.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hostSidePotsHash() => r'8c542be6bd6fd5e7a42d0086df9eb8f12d1723ce';

/// See also [HostSidePots].
@ProviderFor(HostSidePots)
final hostSidePotsProvider =
    AutoDisposeNotifierProvider<HostSidePots, List<SidePotEntity>>.internal(
  HostSidePots.new,
  name: r'hostSidePotsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hostSidePotsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HostSidePots = AutoDisposeNotifier<List<SidePotEntity>>;
String _$sidePotsHash() => r'c9af3c6def5d45e130e35c1f2dcce54e08500533';

/// See also [SidePots].
@ProviderFor(SidePots)
final sidePotsProvider =
    AutoDisposeNotifierProvider<SidePots, List<int>>.internal(
  SidePots.new,
  name: r'sidePotsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sidePotsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SidePots = AutoDisposeNotifier<List<int>>;
String _$potHash() => r'b18a3690218416f2276b7cceb1b829dba629e0d3';

/// See also [Pot].
@ProviderFor(Pot)
final potProvider = AutoDisposeNotifierProvider<Pot, int>.internal(
  Pot.new,
  name: r'potProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$potHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Pot = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
