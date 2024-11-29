import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:poker_chip/ignore/revenue_data_source.dart';
import 'package:poker_chip/page/game/host/host_page.dart';
import 'package:poker_chip/page/game/participant/paticipant_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poker_chip/page/root/root_page.dart';
import 'package:uuid/uuid.dart';

final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);

final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);

final firebaseAnalyticsProvider = Provider((_) => FirebaseAnalytics.instance);

final analyticsObserverProvider = Provider((ref) =>
    FirebaseAnalyticsObserver(analytics: ref.watch(firebaseAnalyticsProvider)));

final uuidProvider = Provider((_) => const Uuid());

final isProUserProvider = FutureProvider<bool>(
  (ref) async => await ref.read(revenueProvider).getIsProUser(),
);

/// ページ遷移のプロバイダ
final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RootPage(),
        routes: [
          GoRoute(
            path: 'host',
            pageBuilder: (context, state) =>
                _buildPageWithAnimation(const HostPage()),
          ),
          GoRoute(
            path: 'participant',
            pageBuilder: (context, state) => _buildPageWithAnimation(
                ParticipantPage(id: state.extra as String?)),
          ),
        ],
      ),
    ],
  ),
);

CustomTransitionPage _buildPageWithAnimation(Widget page) {
  return CustomTransitionPage(
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    transitionDuration: const Duration(milliseconds: 0),
  );
}
