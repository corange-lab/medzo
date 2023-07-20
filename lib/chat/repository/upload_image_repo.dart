import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medzo/chat/repository/conversation_repository.dart';
import 'package:medzo/theme/colors.dart';

class UploadImageRepo {
  UploadImageRepo._();
  static final UploadImageRepo _instance = UploadImageRepo._();
  static UploadImageRepo getInstance() => _instance;

  Future<File?> getImage(
      bool showLoading, bool isCameraOption, BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile;

    if (isCameraOption) {
      final imageSource = await _selectImageSource(context);
      pickedFile = await imagePicker.pickImage(
        source: imageSource ?? ImageSource.gallery,
      );
    } else {
      pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
    }
    return null;
  }

  Future<ImageSource?> _selectImageSource(BuildContext context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoActionSheet(
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: Text(
                      "takePhoto".tr,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: AppColors.textColor),
                    ),
                    onPressed: () => Navigator.pop(context, ImageSource.camera),
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      "chooseFromGallery".tr,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: AppColors.textColor),
                    ),
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.gallery),
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text(
                    'cancel'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ));
  }

  Future<String> uploadFile(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask =
        ConversationsRepository.getInstance().uploadFile(imageFile, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      return 'error';
    }
  }
}
