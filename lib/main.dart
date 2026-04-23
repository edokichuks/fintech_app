// Flutter imports:

// Flutter imports:
import 'dart:io';

import 'package:fintech_app/src/core/helpers/helper_functions.dart';
import 'package:fintech_app/src/core/router/router.dart';
import 'package:fintech_app/src/core/services/google_auto_updater.dart';
import 'package:fintech_app/src/core/config/exceptions/overall_app_error.dart';
import 'package:fintech_app/src/core/services/local_storage.dart/storage_keys.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/core/utils/theme/theme_notifier/theme_notifier.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();
  await Hive.openBox(LocalStoreKeysManger.appBox.rawValue);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await InAppUpdateAuto.checkForUpdate();
  AppErrorLog.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  final _controller = OverLayLoaderController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted) {
        HelperFunctions().activateTimer(dispose: false);
        if (Platform.isAndroid) {
          try {
            await InAppUpdateAuto.checkForUpdate();
          } catch (e) {
            debugLog('Auto-update check failed: $e');
          }
        }
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    HelperFunctions().activateTimer(dispose: true);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return Listener(
          onPointerDown: (event) {},
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'FinTrack',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appTheme.themeMode,
            scrollBehavior: const ScrollBehavior().copyWith(
              physics: const BouncingScrollPhysics(),
            ),
            initialRoute: AppRouter.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}
