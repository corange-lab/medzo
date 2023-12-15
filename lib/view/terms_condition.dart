import 'package:flutter/material.dart';
import 'package:medzo/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  late final WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white)
      ..loadRequest(Uri.parse('https://www.medzoapp.com/terms'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Terms and Conditions",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.white),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
