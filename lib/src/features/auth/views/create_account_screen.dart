import 'package:clean_flutter/src/core/router/router.dart';
import 'package:clean_flutter/src/core/extensions/navigation_extensions.dart';
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';
import 'package:clean_flutter/src/features/auth/widgets/auth_flow_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'steps/user_details_step.dart';
import 'steps/verify_account_step.dart';
import 'steps/work_details_step.dart';
import 'steps/open_banking_step.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    } else {
      // Flow complete. Navigate to next phase (Dashboard etc.)
      // For now we will just pop to login or show completion based on routing.
      context.pushNamed(
        AppRouter.login,
      ); // Replace with intended routing on complete
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            AuthFlowHeader(
              currentStep: _currentPage + 1,
              onBack: _previousPage,
            ),
            Expanded(
              child: AppPageView(
                pageController: _pageController,
                pageSnapping: true, // Typically prefer snapping on forms
                children: [
                  UserDetailsStep(onNext: _nextPage),
                  VerifyAccountStep(onNext: _nextPage),
                  WorkDetailsStep(onNext: _nextPage),
                  OpenBankingStep(onNext: _nextPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
