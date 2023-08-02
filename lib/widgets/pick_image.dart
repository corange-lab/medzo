import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/widgets/custom_widget.dart';

class pickImageController extends GetxController {
  final _selectedImage = "".obs;

  String get selectedImage => _selectedImage.value;

  final ImagePicker picker = ImagePicker();

  pickMultipleImage(context, addChoosenFile) async {
    final List<XFile> pickedFile = await picker.pickMultiImage();
    List xPickFile = pickedFile;

    if (xPickFile.isNotEmpty) {
      for (var i = 0; i < xPickFile.length; i++) {
        //selectedMultiImages.add();
        addChoosenFile(File(xPickFile[i].path));
      }
    } else {
      toast(message: "Nothing is selected");
    }
  }

  Future<void> pickImage(context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: Responsive.height(22, context),
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: AppColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height(3, context),
              ),
              TextWidget(
                ConstString.selectchoice,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: Responsive.sp(4.8, context),
                    color: AppColors.black,
                    fontFamily: AppFont.fontFamilysemi),
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 1,
                width: Responsive.width(80, context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.splashdetail,
                ),
              ),
              SizedBox(
                height: Responsive.height(2, context),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);

                        if (image != null) {
                          _selectedImage.value = image.path;
                          print("Image Picked From Camera");
                        }
                        Get.back();
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset(SvgIcon.camerapng,
                                height: Responsive.height(5.5, context)),
                            SizedBox(
                              height: Responsive.height(1.3, context),
                            ),
                            TextWidget(ConstString.camera)
                          ],
                        ),
                        // height: Responsive.height(8, context),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () async {
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 70);

                      if (image != null) {
                        _selectedImage.value = image.path;
                        print("Image Picked From Gallery");
                      }
                      Get.back();
                    },
                    child: Container(
                      // height: Responsive.height(8, context),
                      child: Column(
                        children: [
                          Image.asset(SvgIcon.gallerypng,
                              height: Responsive.height(5.5, context)),
                          SizedBox(
                            height: Responsive.height(1.3, context),
                          ),
                          TextWidget(ConstString.gallery)
                        ],
                      ),
                    ),
                  )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
