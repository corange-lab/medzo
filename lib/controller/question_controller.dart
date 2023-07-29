import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/api/auth_api.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/utils/string.dart';

class QuestionController extends GetxController {
  TextEditingController allergiesController = TextEditingController();
  TextEditingController howSeverAllergiesController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  RxBool healthAns = false.obs;
  // RxBool medicineAns = false.obs;
  // RxBool allergyAns = false.obs;

  var pageController = PageController().obs;
  var selectedPageIndex = 0.obs;
  RxString healthDropdown = "Ashthma".obs;
  RxString yearDropdown = "1 Years".obs;

  RxString selectedAge = "".obs;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  UserModel userModel = UserModel();
  int currentQuestionnairesPosition = 0;
  QuestionController({this.currentQuestionnairesPosition = 0});

  @override
  void onInit() {
    if (currentQuestionnairesPosition != 0) {
      selectedPageIndex.value = currentQuestionnairesPosition;
    }
    AuthApi.instance.getLoggedInUserData().then((UserModel? userModel) {
      if (userModel != null) {
        this.userModel = userModel;
      }
    });
    super.onInit();
  }

  Future<UserModel> updateData() async {
    final newDocRef = userCollection.doc(userModel.id);
    UserModel newUser = userModel.copyWith(id: newDocRef.id);
    print("Set Data");
    resetScreenData();
    await newDocRef.set(newUser.toMap());
    return newUser;
  }

  void resetScreenData() {
    healthDropdown = healthCondition.first.obs;
    yearDropdown = year.first.obs;
    healthAns = false.obs;
    // medicineAns = false.obs;
    // allergyAns = false.obs;
  }

  List<String> healthCondition = [
    "Ashthma",
    "Diabetic",
    "Cancer",
    "Food Poision",
    "Handicap"
  ];

  List<String> questionTopic = [
    "Current Health Conditions",
    "Current Medications being taken",
    "Current allergies",
    "Age"
  ];

  List<String> year = [
    "1 Years",
    "2 Years",
    "3 Years",
    "5 Years",
    "10 Years",
    "12 Years",
    "15 Years",
    "20 Years",
  ];

  List ageGroup = [
    "18-24",
    "25-34",
    "35-41",
    "42-48",
    "49-55",
    "56-61",
    "62-71"
  ];

  List questions = [
    [
      ConstString.question1,
      ConstString.question2,
      ConstString.question3,
    ],
    [
      ConstString.question4,
      ConstString.question5,
      ConstString.question6,
    ],
    [
      ConstString.question7,
      ConstString.question8,
      ConstString.question9,
    ],
    [
      ConstString.question10,
      ConstString.question11,
    ],
  ];
}
