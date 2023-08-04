import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String? imageUrl;
  final Widget? component;

  ImagePreviewScreen.withUrl(this.imageUrl) : component = null;

  ImagePreviewScreen.withWidget(this.component) : imageUrl = null;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whitehome,
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(
                SvgIcon.backarrow,
                height: Responsive.height(2, context),
              )),
          title: Align(
            alignment: Alignment.centerLeft,
            child: TextWidget(
              ConstString.preview,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: Responsive.sp(4.8, context),
                  fontFamily: AppFont.fontBold,
                  letterSpacing: 0,
                  color: AppColors.black),
            ),
          ),
          elevation: 3,
          shadowColor: AppColors.splashdetail.withOpacity(0.1),
        ),
        body: Center(
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
            child: getWidget(),
          ),
        ));
  }

  Widget getWidget() {
    if (widget.imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CupertinoActivityIndicator(
            color: AppColors.primaryColor,
            animating: true,
            radius: 14,
          ),
        ),
      );
    } else if (widget.component != null) {
      return widget.component!;
    } else {
      return Container();
    }
  }
}
