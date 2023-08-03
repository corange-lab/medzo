import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/widgets/custom_widget.dart';

class NetworkImagePreviewScreen extends StatefulWidget {
  final String imageUrl;
  const NetworkImagePreviewScreen({required this.imageUrl});

  @override
  State<NetworkImagePreviewScreen> createState() =>
      _NetworkImagePreviewScreenState();
}

class _NetworkImagePreviewScreenState extends State<NetworkImagePreviewScreen> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.dark,
              size: Responsive.height(2.5, context),
            ),
          ),
          title: TextWidget(
            'Preview',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: Responsive.sp(3.5, context),
                color: AppColors.dark,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 5.0,
                scaleEnabled: true,
                onInteractionUpdate: (ScaleUpdateDetails details) {
                  if (details.scale != _previousScale) {
                    setState(() {
                      _scale = _previousScale * details.scale;
                    });
                  }
                },
                onInteractionEnd: (ScaleEndDetails details) {
                  setState(() {
                    _previousScale = _scale;
                  });
                },
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}
