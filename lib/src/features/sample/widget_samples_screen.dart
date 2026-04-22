// Flutter imports:
import 'package:clean_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:clean_flutter/src/core/utils/theme/theme_notifier/theme_notifier.dart';
import 'package:clean_flutter/src/core/router/router.dart';

class WidgetSamplesScreen extends ConsumerStatefulWidget {
  const WidgetSamplesScreen({super.key});

  @override
  ConsumerState<WidgetSamplesScreen> createState() =>
      _WidgetSamplesScreenState();
}

class _WidgetSamplesScreenState extends ConsumerState<WidgetSamplesScreen> {
  bool switchValue = false;
  String? selectedDropdownValue;
  String? selectedRadioValue;
  bool isLoading = false;
  final TextEditingController textController = TextEditingController();

  final List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
  final List<String> radioOptions = ['Choice A', 'Choice B', 'Choice C'];

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Widget Samples'),
        backgroundColor: AppColors.primary300,
        actions: [
          Row(
            children: [
              const AppText(text: 'Dark Mode'),
              Spacing.width(8.w),
              AppSwitch(
                value: appTheme.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
              Spacing.width(16.w),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Widgets Section
            _buildSection(
              title: 'Text Widgets',
              children: [
                const AppText(
                  text: 'Default App Text',
                  style: TextStyle(fontSize: 16),
                ),
                Spacing.height(8.h),
                const AppCurrencyAndText(
                  amount: '1,500.00',
                  currencySymbol: '₦',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            //Testing generated path images
            AppText(text: 'Testing Generated image assets'),
            Assets.images.png.onboard1.image(),
            AppImageView(svgPath: Assets.images.svg.padlock),
            // Container Section
            _buildSection(
              title: 'Containers',
              children: [
                AppContainer(
                  height: 80.h,
                  color: AppColors.primary300.withValues(alpha: 0.1),
                  child: const AppText(text: 'Custom App Container'),
                ),
              ],
            ),

            // Button Section
            _buildSection(
              title: 'Buttons',
              children: [
                AppButton(
                  text: 'Primary Button',
                  onPressed: () => _showToastExample(),
                  buttonStyle: AppButtonStyle.primary(),
                ),
                Spacing.height(12.h),
                AppButton(
                  text: 'Loading Button',
                  isLoading: isLoading,
                  onPressed: () => _toggleLoading(),
                  buttonStyle: AppButtonStyle.secondary(),
                ),
              ],
            ),

            // Input Fields Section
            _buildSection(
              title: 'Input Fields',
              children: [
                AppTextField(
                  controller: textController,
                  label: 'Sample Input',
                  hintText: 'Enter some text...',
                ),
                Spacing.height(12.h),
                AppPasswordField(
                  label: 'Password Field',
                  hintText: 'Enter password...',
                ),
              ],
            ),

            // Dropdown Section
            _buildSection(
              title: 'Dropdown',
              children: [
                AppDropdown<String>(
                  label: 'Select Option',
                  hintText: 'Choose an option',
                  items: dropdownItems,
                  initialValue: selectedDropdownValue,
                  onChanged: (value) {
                    setState(() {
                      selectedDropdownValue = value;
                    });
                  },
                ),
              ],
            ),

            // Switch Section
            _buildSection(
              title: 'Switch',
              children: [
                Row(
                  children: [
                    const AppText(text: 'Toggle Switch: '),
                    Spacing.width(12.w),
                    AppSwitch(
                      value: switchValue,
                      onChanged: (value) {
                        setState(() {
                          switchValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Radio Buttons Section
            _buildSection(
              title: 'Radio Buttons',
              children: [
                ...radioOptions.map(
                  (option) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        AppRadio<String>(
                          value: option,
                          groupValue: selectedRadioValue,
                          onRadioChanged: (value) {
                            setState(() {
                              selectedRadioValue = value;
                            });
                          },
                        ),
                        Spacing.width(8.w),
                        AppText(text: option),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Loader Section
            _buildSection(
              title: 'Loader',
              children: [const Center(child: AppLoader(size: 40))],
            ),

            // Dialog & Toast Section
            _buildSection(
              title: 'Dialogs & Toasts',
              children: [
                AppButton(
                  text: 'Show Dialog',
                  onPressed: () => _showDialogExample(),
                  buttonStyle: AppButtonStyle.primary(),
                ),
                Spacing.height(12.h),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Success Toast',
                        onPressed: () =>
                            showSuccessToast(message: 'Success message!'),
                        buttonStyle: AppButtonStyle.primary(),
                      ),
                    ),
                    Spacing.width(12.w),
                    Expanded(
                      child: AppButton(
                        text: 'Error Toast',
                        onPressed: () =>
                            showErrorToast(message: 'Error message!'),
                        buttonStyle: AppButtonStyle.secondary(),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // File Download Section
            _buildSection(
              title: 'File Download',
              children: [
                AppButton(
                  text: 'Download Sample',
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.fileDownloadSample,
                  ),
                  buttonStyle: AppButtonStyle.primary(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Spacing.height(12.h),
        ...children,
        Spacing.height(24.h),
      ],
    );
  }

  void _showToastExample() {
    showSuccessToast(message: 'Button pressed successfully!');
  }

  void _toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });

    if (isLoading) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _showDialogExample() {
    showAppDialogue(
      context: context,
      title: 'Sample Dialog',
      subtitle: 'This is a demonstration of the AppDialog widget',
      actions: [
        AppButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
          buttonStyle: AppButtonStyle.secondary(),
        ),
        Spacing.height(12.h),
        AppButton(
          text: 'Confirm',
          onPressed: () {
            Navigator.pop(context);
            showSuccessToast(message: 'Dialog confirmed!');
          },
          buttonStyle: AppButtonStyle.primary(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
