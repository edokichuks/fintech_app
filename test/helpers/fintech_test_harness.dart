// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/application/repositories/fintech/fintech_dashboard_repository.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';

class TestFintechDashboardRepository implements FintechDashboardRepository {
  TestFintechDashboardRepository({
    required Stream<FintechDashboardSnapshot> stream,
    FintechDashboardSnapshot? refreshedSnapshot,
    Object? refreshError,
  }) : _stream = stream,
       _refreshedSnapshot =
           refreshedSnapshot ?? FintechDashboardSnapshot.mock(),
       _refreshError = refreshError;

  final Stream<FintechDashboardSnapshot> _stream;
  final FintechDashboardSnapshot _refreshedSnapshot;
  final Object? _refreshError;

  int refreshCallCount = 0;

  @override
  Future<FintechDashboardSnapshot> refreshDashboard() async {
    refreshCallCount += 1;

    if (_refreshError != null) {
      throw _refreshError;
    }

    return _refreshedSnapshot;
  }

  @override
  Stream<FintechDashboardSnapshot> watchDashboard() => _stream;
}

ProviderContainer createTestContainer({
  List<Override> overrides = const <Override>[],
}) {
  final container = ProviderContainer(overrides: overrides);
  addTearDown(container.dispose);
  return container;
}

Future<void> pumpFintechApp(
  WidgetTester tester, {
  required ProviderContainer container,
  required Widget home,
  ThemeMode themeMode = ThemeMode.dark,
  RouteFactory? onGenerateRoute,
  Size size = const Size(375, 812),
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(() {
    tester.view.resetDevicePixelRatio();
    tester.view.resetPhysicalSize();
  });

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            onGenerateRoute: onGenerateRoute,
            home: home,
          );
        },
      ),
    ),
  );
}

FintechDashboardSnapshot buildTestSnapshot({int tick = 1}) {
  return FintechDashboardSnapshot.mock(tick: tick);
}
