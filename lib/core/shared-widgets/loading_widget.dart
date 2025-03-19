import 'package:flutter/material.dart';

import '../styles/colors/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LinearProgressIndicator(
        color: AppColors.mainBlue,
      ),
    );
  }
}
