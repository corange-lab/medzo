import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/model/review_data_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewScreen extends StatefulWidget {
  final Medicine? medicineDetails;
  final List<ReviewDataModel>? reviewList;

  ReviewScreen(this.medicineDetails, this.reviewList);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  Medicine? medicineDetails;

  MedicineController medicineController = Get.put(MedicineController());

  @override
  void initState() {
    medicineDetails = widget.medicineDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              SvgIcon.backarrow,
              height: 15,
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            ConstString.addreview,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 17.5,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              TextWidget(
                ConstString.writereview,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 21,
                    letterSpacing: 0,
                    fontFamily: AppFont.fontBold),
              ),
              SizedBox(
                height: 10,
              ),
              TextWidget(
                ConstString.leavereview,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 13,
                    letterSpacing: 0,
                    color: AppColors.grey.withOpacity(0.8),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              TextWidget(
                medicineDetails?.genericName ?? "-",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 15.5,
                    letterSpacing: 0,
                    color: AppColors.darkPrimaryColor,
                    fontFamily: AppFont.fontBold),
              ),
              SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextWidget(
                  ConstString.rateproduct,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkPrimaryColor,
                      fontFamily: AppFont.fontMedium),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SmoothStarRating(
                  rating: medicineController.rating,
                  allowHalfRating: true,
                  defaultIconData: Icons.star_outline_rounded,
                  filledIconData: Icons.star_rounded,
                  halfFilledIconData: Icons.star_half_rounded,
                  starCount: 5,
                  onRatingChanged: (rating) {
                    setState(() {
                      medicineController.rating = rating;
                    });
                  },
                  size: 30,
                  color: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  TextWidget(
                    ConstString.review,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 0,
                        fontFamily: AppFont.fontMedium),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: SvgPicture.asset(
                        SvgIcon.info,
                        height: 15,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  controller: medicineController.reviewText,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: false,
                  maxLines: 5,
                  cursorColor: AppColors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    hintText: "Write a review",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 14),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextWidget(
                  "210 character required",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: AppColors.icongrey, fontSize: 11.5),
                ),
              ),
              SizedBox(
                height: 75,
              ),
              ElevatedButton(
                onPressed: () {
                  if (medicineController.reviewText.text.trim().isEmpty) {
                    toast(message: "Please add review");
                    return;
                  }

                  progressDialogue(context, title: "Uploading Review");

                  double ratingValue = double.parse(
                      medicineController.rating.toStringAsFixed(1));

                  String medicineId = medicineDetails!.id!;
                  final reviewId = medicineController.reviewRef.doc().id;
                  final userId = FirebaseAuth.instance.currentUser!.uid;

                  ReviewDataModel review = ReviewDataModel(
                    id: reviewId,
                    medicineId: medicineId,
                    userId: userId,
                    rating: ratingValue,
                    review: medicineController.reviewText.text,
                    createdTime: DateTime.now(),
                  );

                  medicineController.reviewRef
                      .doc(reviewId)
                      .set(review.toMap())
                      .then((value) {
                    widget.reviewList!.add(review);

                    String medicineRating = medicineController
                        .countMedicineRating(widget.reviewList!);

                    widget.medicineDetails!.ratings = medicineRating;

                    medicineController.medicineRef.doc(medicineId).set(
                        widget.medicineDetails!.toMap(),
                        SetOptions(
                          merge: true,
                        ));

                    medicineController.reviewText.clear();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return successDialogue(
                          titleText: "Successful",
                          subtitle:
                              "Your review has been submitted \nsuccessfully.",
                          iconDialogue: SvgIcon.check_circle,
                          btntext: "Continue",
                          onPressed: () {
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                        );
                      },
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize: Size(170, 55),
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: TextWidget(
                  ConstString.submit,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.buttontext,
                      fontSize: 15,
                      fontFamily: AppFont.fontMedium),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
