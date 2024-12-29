import 'package:social_app_2/src/features/components/animations/lottie_animation_view.dart';
import 'package:social_app_2/src/features/components/animations/models/lottie_animation.dart';

class WaitingApprovalAnimationView extends LottieAnimationView {
  const WaitingApprovalAnimationView({super.key})
      : super(animation: LottieAnimation.waitingApproval);
}
