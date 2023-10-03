import 'package:flutter/material.dart';
import 'package:medzo/theme/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Privacy Policy",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),),
      ),
    );
  }
}
