import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class MyLoaderScreen extends StatelessWidget {
  const MyLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            size: 75, color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.dark,
    );
  }
}
