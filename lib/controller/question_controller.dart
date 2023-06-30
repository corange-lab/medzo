import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/utils/string.dart';

class Question_controller extends GetxController {
  RxString healthAns = "No".obs;
  RxString medicineAns = "No".obs;
  RxString allergyAns = "No".obs;

  var pageController = PageController().obs;
  var selectedPageIndex = 0.obs;
  RxString healthDropdown = "Ashthma".obs;
  RxString yearDropdown = "1 Years".obs;

  RxString selectedAge = "".obs;

  List<String> healthCondition = [
    "Ashthma",
    "Diabetic",
    "Cancer",
    "Food Poision",
    "Handicap"
  ];

  List<String> QuestionTopic = [
    "Current Health Conditions",
    "Current Medications being taken",
    "Current allergies",
    "Age"
  ];

  List<String> year = [
    "1 Years",
    "2 Years",
    "3 Years",
    "4 Years",
    "5 Years",
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

  List medicineList = [
    "Medicine 1",
    "Medicine 2",
    "Medicine 3",
    "Medicine 4",
  ];

  List Questions = [
    [
      [ConstString.question1, "No"],
      [ConstString.question2, ""],
      [ConstString.question3, ""],
    ],
    [
      [ConstString.question4, ""],
      [ConstString.question5, ""],
      [ConstString.question6, ""],
    ],
    [
      [ConstString.question7, ""],
      [ConstString.question8, ""],
      [ConstString.question9, ""],
    ],
    [
      [ConstString.question10, ""],
      [ConstString.question11, ""],
    ],
  ];
}
