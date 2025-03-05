import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/components/app_bar/home_app_bar.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class InstaScreen extends ConsumerWidget {
  const InstaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: HomeAppBar(title: 'Insta'.hardcoded),
      body: Center(
        child: Text('Insta Screen'.hardcoded),
      ),
    );
  }
}
