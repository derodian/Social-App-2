import 'package:social_app_2/src/features/components/animations/lottie_animation_view.dart';
import 'package:social_app_2/src/features/components/animations/models/lottie_animation.dart';

class EmptyContentsAnimationView extends LottieAnimationView {
  const EmptyContentsAnimationView({super.key})
      : super(animation: LottieAnimation.empty);
}
