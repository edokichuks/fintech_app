// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/core/extensions/navigation_extensions.dart';
import 'package:fintech_app/src/core/extensions/theme_extensions.dart';
import 'package:fintech_app/src/core/router/router.dart';
import 'package:fintech_app/src/core/utils/app_colors.dart';
import 'package:fintech_app/src/core/utils/app_margin_util.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int page = 0;
  bool _swipingFromPageView = true;

  final List<(String, String)> _items = [
    (
      "Amazing Vendors",
      "Too busy or can’t cook? We're just a click away. Fasten with our amazing vendors.",
    ),
    (
      "Easy Payment",
      "Secure and seamless transactions. Pay effortlessly with multiple options.",
    ),
    (
      "Fast Delivery",
      "Quick and reliable delivery. Enjoy your meals hot and fresh, right on time.",
    ),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            _animateCurrentPage(status);
          });
    _forwardAnimation();
  }

  void _animateCurrentPage(AnimationStatus status) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (status == AnimationStatus.completed) {
        if (page == (_items.length - 1)) {
          _animationController.stop();
        } else {
          page += 1;
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
          );
        }

        _resetAnimation();
      }
    });
  }

  void _goToNextpage() {
    _swipingFromPageView = false;
    if (page == (_items.length - 1)) {
      _animationController.stop();

      context.pushNamed(AppRouter.splashScreen);
    } else {
      page += 1;
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );
      if (page == (_items.length - 1)) _animationController.stop();
    }
  }

  void _forwardAnimation() {
    _animationController.forward();
  }

  void _resetAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

  void _changePage(int value) => setState(() {
    page = value;
    if (_swipingFromPageView) _resetAnimation();
    _swipingFromPageView = true;
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return PageView.builder(
            onPageChanged: _changePage,
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              final item = _items[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/mockup${index + 1}.png",
                    fit: BoxFit.cover,
                    height: screenHeight(context),
                    width: screenWidth(context),
                  ),
                  Positioned(
                    right: 30.w,
                    top: 50.h,
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppRouter.splashScreen);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Skip",
                            style: context.textTheme.s16w700.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 1.5.w),
                          Padding(
                            padding: EdgeInsets.only(top: 2.7.h),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      bottom: 95.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item.$1,
                          style: context.textTheme.s32w700.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          item.$2,
                          textAlign: TextAlign.center,
                          style: context.textTheme.s12w400.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 28.h),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                3,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 5.h,
                                    width: index != page ? 5.w : 10.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: switch (index != page) {
                                        true => AppColors.white,
                                        _ => AppColors.primary300,
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 60.h),
                        Consumer(
                          builder: (context, ref, __) {
                            return AppButton(
                              text: page != 2 ? "Next" : "Get Started",
                              onPressed: _goToNextpage,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
