// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sittingUidsHash() => r'f5adc3e8e8f9bc3fc9c7b2bd97c49941032bb2f8';

/// See also [SittingUids].
@ProviderFor(SittingUids)
final sittingUidsProvider =
    NotifierProvider<SittingUids, List<String>>.internal(
  SittingUids.new,
  name: r'sittingUidsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sittingUidsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SittingUids = Notifier<List<String>>;
String _$errorTextHash() => r'aea0f4abbae1219059d69bb04b2dad779367118d';

/// See also [ErrorText].
@ProviderFor(ErrorText)
final errorTextProvider =
    AutoDisposeNotifierProvider<ErrorText, String>.internal(
  ErrorText.new,
  name: r'errorTextProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$errorTextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ErrorText = AutoDisposeNotifier<String>;
String _$bigIdHash() => r'6f38f700df68724e770dccfd64f4d8778b5beb66';

///
/// position
///
///
/// Copied from [BigId].
@ProviderFor(BigId)
final bigIdProvider = NotifierProvider<BigId, int>.internal(
  BigId.new,
  name: r'bigIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bigIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BigId = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
