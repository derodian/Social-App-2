import 'package:social_app_2/src/features/components/animations/lottie_animation_view.dart';
import 'package:social_app_2/src/features/components/animations/models/lottie_animation.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(animation: LottieAnimation.error);
}
