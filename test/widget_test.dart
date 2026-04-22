// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:fintech_app/src/features/home/views/widgets/dashboard_loading_view.dart';
import 'package:fintech_app/src/general_widgets/fintech_shimmer_box.dart';

// Relative imports:
import 'helpers/fintech_test_harness.dart';

void main() {
  testWidgets(
    'dashboard loading smoke test replaces the default counter test',
    (WidgetTester tester) async {
      final container = createTestContainer();

      await pumpFintechApp(
        tester,
        container: container,
        home: const DashboardLoadingView(),
      );
      await tester.pump();

      expect(find.byType(FintechShimmerBox), findsWidgets);
    },
  );
}
