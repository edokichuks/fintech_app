import 'package:fintech_app/src/application/repositories/user/user_repository_impl.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

class InAppReviewService {
  final InAppReview _inAppReview = InAppReview.instance;
  final Ref _ref;

  InAppReviewService(this._ref);

  Future<bool> shouldShowReview() async {
    try {
      final userRepo = _ref.read(userRepositoryProvider);
      // final appConfig = _ref.read(appConfigProvider);

      //! Check if rating is enabled by admin
      // final isRatingEnabled = appConfig.general?.appRatingEnabled ?? false;
      // if (!isRatingEnabled) {
      //   debugLog('In-app review disabled by admin');
      //   return false;
      // }

      // Check if user has already rated
      if (userRepo.getHasRatedApp()) {
        debugLog('User has already rated the app');
        return false;
      }

      // Check 30-day cooldown
      final lastRatedDate = userRepo.getLastRatedDate();
      if (lastRatedDate != null) {
        final daysSinceRating = DateTime.now().difference(lastRatedDate).inDays;
        if (daysSinceRating < 30) {
          debugLog(
            '30-day cooldown active. Days since rating: $daysSinceRating',
          );
          return false;
        }
      }

      // Check transaction count (3-5 transactions)
      final transactionCount = userRepo.getTransactionCountSinceRating();
      if (transactionCount < 3) {
        debugLog('Not enough transactions. Count: $transactionCount');
        debugPrint('Not enough transactions. Count: $transactionCount');
        return false;
      }

      return true;
    } catch (e) {
      debugLog('Error checking if should show review: $e');
      return false;
    }
  }

  Future<void> requestReview() async {
    try {
      final shouldShow = await shouldShowReview();
      if (!shouldShow) return;

      final isAvailable = await _inAppReview.isAvailable();
      if (isAvailable) {
        debugPrint('reviewing');
        await _inAppReview.requestReview();

        // Mark as rated and reset transaction count
        final userRepo = _ref.read(userRepositoryProvider);
        await userRepo.setHasRatedApp(true);
        await userRepo.setLastRatedDate(DateTime.now());
        await userRepo.resetTransactionCount();

        debugLog('In-app review requested successfully');
      } else {
        debugLog(
          'this device cannot call review...probably show a custom dialoge for the review',
        );
      }
    } catch (e) {
      debugLog('Error requesting review: $e');
    }
  }

  Future<void> incrementTransactionCount() async {
    try {
      final userRepo = _ref.read(userRepositoryProvider);
      await userRepo.incrementTransactionCount();
      debugLog('Transaction count incremented');
    } catch (e) {
      debugLog('Error incrementing transaction count: $e');
    }
  }
}

final inAppReviewServiceProvider = Provider<InAppReviewService>((ref) {
  return InAppReviewService(ref);
});


//? USAGE EXAMPLE
    // Increment transaction count for review tracking
    // await ref.read(inAppReviewServiceProvider).incrementTransactionCount();

    // Request review if conditions are met
    // await ref.read(inAppReviewServiceProvider).requestReview();

