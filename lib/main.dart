import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:poker_chip/data/firebase_auth_data_source.dart';
import 'package:poker_chip/page/component/ad/gdpr.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/repository/user_repository.dart';
import 'package:poker_chip/ignore/billing_info.dart';
import 'package:poker_chip/util/environment/environment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/provider/domain_providers.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  billingInit();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await configureSDK();
  const flavorName = String.fromEnvironment('flavor');
  final flavor = Flavor.values.byName(flavorName);
  await Firebase.initializeApp(
    options: firebaseOptionsWithFlavor(flavor),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    Future(() async {
      ref.read(authProvider).autoLogin();
      final user = ref.read(userRepositoryProvider);
      final name = await user.getName();
      final uid = await user.getUID();
      ref.read(uidProvider.notifier).update((state) => uid);
      ref.read(nameProvider.notifier).update((state) => name);
    });
    initPlugin();
    super.initState();
  }

  Future<void> initPlugin() async {
    TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }
    if (status == TrackingStatus.authorized) {
      gdpr();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: ColorConstant.black100,
        fontFamily: 'Kaisei_Decol',
        dividerColor: Colors.transparent,
      ),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
