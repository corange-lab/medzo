import 'package:flutter/material.dart';
import 'package:medzo/app_font.dart';

class ThemeColor {
  static Color primaryColor = const Color(0xffF29D38);
  static Color darkPrimaryColor = const Color(0xff0D0D0D);
  static Color black = const Color(0xff180E02);
  static Color grey = const Color(0xff818181);
  static Color lightGrey = const Color(0xffBABABA);
  static Color white = const Color(0xffF8FAFA);
  static Color lightSky = const Color(0xffE8F5F5);
  static Color orange = const Color(0xffFF4000);
  static Color blue = const Color(0xff0064B2);
  static Color sky = const Color(0xff00B2CB);
  static Color lightgreen = const Color(0xff61CA05);
  static Color tilecolor = const Color(0xffFDF3E7);
  static Color lightpurple = const Color(0xffCE9FFC);
  static Color darkpurple = const Color(0xff7367F0);

  static ThemeData mThemeData(BuildContext context, {bool isDark = false}) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: lightGrey,
      scaffoldBackgroundColor: isDark ? Colors.black : const Color(0xffF3F4F9),
      applyElevationOverlayColor: true,
      bannerTheme: MaterialBannerTheme.of(context),
      bottomAppBarTheme: BottomAppBarTheme.of(context),
      canvasColor: isDark ? Colors.white : Colors.grey[50]!,
      cardColor: isDark ? Colors.black : Colors.white,
      cardTheme: CardTheme(
        color: isDark ? Colors.black : Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
      ),
      checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(primaryColor),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      dialogBackgroundColor: Colors.white,
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        contentTextStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      dividerColor: Colors.grey[500],
      dividerTheme: DividerThemeData(
          color: Colors.grey[500], indent: 8.0, endIndent: 8.0, space: 8.0),
      focusColor: Colors.pink[50],
      fontFamily: AppFont.fontFamily,
      hintColor: Colors.grey,
      indicatorColor: primaryColor,
      outlinedButtonTheme: OutlinedButtonThemeData(style: textButtonStyle),
      primaryTextTheme: textTheme(isDark),
      textButtonTheme: TextButtonThemeData(style: textButtonStyle),
      timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected) ? lightGrey : lightGrey),
          hourMinuteTextColor:
              MaterialStateColor.resolveWith((states) => primaryColor),
          dialHandColor: Colors.pink.shade200,
          dialBackgroundColor: lightGrey,
          dayPeriodColor: primaryColor,
          dialTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.black
                  : Colors.black),
          entryModeIconColor: primaryColor),
      buttonTheme: ButtonThemeData(
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // buttonColor: pink,
        textTheme: ButtonTextTheme.normal,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: primaryColor,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        hintStyle: TextStyle(
          fontSize: 14, // 35
          fontFamily: AppFont.fontFamily,
          color: primaryColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffF3F4F9),
        elevation: 0,
        actionsIconTheme: IconThemeData(color: primaryColor),
        toolbarTextStyle: TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 29, // 35
                  fontFamily: AppFont.fontFamily,
                  color: isDark ? Colors.white : Colors.black,
                ),
                bodyMedium: TextStyle(
                    fontSize: 29, // 35
                    fontFamily: AppFont.fontFamily,
                    color: Colors.grey))
            .bodyMedium,
        titleTextStyle: TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 29, // 35
                  fontFamily: AppFont.fontFamily,
                  color: isDark ? Colors.white : Colors.black,
                ),
                bodyMedium: TextStyle(
                    fontSize: 29, // 35
                    fontFamily: AppFont.fontFamily,
                    color: Colors.grey))
            .titleLarge,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: TextStyle(
          fontSize: 22,
          fontFamily: AppFont.fontFamily,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 22,
          fontFamily: AppFont.fontFamily,
        ),
      ),
      textTheme: textTheme(isDark),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: Colors.white,
        backgroundColor: isDark ? Colors.white : Colors.black,
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ),
      colorScheme: ColorScheme(
        primary: lightGrey,
        secondary: lightGrey,
        brightness: Brightness.light,
        background: isDark ? Colors.black : Colors.white,
        error: Colors.red,
        onBackground: lightGrey,
        onError: Colors.red,
        onPrimary: lightGrey,
        onSecondary: lightGrey,
        onSurface: lightGrey,
        surface: lightGrey,
      ).copyWith(background: lightGrey).copyWith(error: Colors.red),
    );
  }

  static ButtonStyle get textButtonStyle {
    return TextButton.styleFrom(
      // backgroundColor: primaryColor,
      textStyle: TextStyle(
        color: Colors.white,
        fontFamily: AppFont.fontFamily,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  static TextTheme textTheme(isDark) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 30, // 75
        fontFamily: AppFont.fontFamily,
        color: isDark ? Colors.white : Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 22, // 50
        color: isDark ? Colors.white : Colors.black,
        fontFamily: AppFont.fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 19, // 40
        color: isDark ? Colors.white : Colors.black,
        fontFamily: AppFont.fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 14, // 35
        color: isDark ? Colors.white : Colors.black,
        fontFamily: AppFont.fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 20, // 45
        fontFamily: AppFont.fontFamily,
      ),
      titleLarge: TextStyle(
          fontSize: 18, // 40
          fontFamily: AppFont.fontFamily,
          color: isDark ? Colors.white : Colors.black),
      bodyLarge: TextStyle(
        fontSize: 14, // 35
        fontFamily: AppFont.fontFamily,
        color: isDark ? Colors.white : Colors.grey,
      ),
      bodyMedium: TextStyle(
        fontSize: 14, // 35
        fontFamily: AppFont.fontFamily,
        color: isDark ? Colors.white : Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontFamily: AppFont.fontFamily,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontFamily: AppFont.fontFamily,
        letterSpacing: 0.1,
      ),
      labelSmall: TextStyle(
          fontSize: 13,
          fontFamily: AppFont.fontFamily,
          letterSpacing: 0.1,
          color: Colors.grey),
      labelLarge: TextStyle(
        fontSize: 22, // 50
        fontFamily: AppFont.fontFamily,
        color: isDark ? Colors.black : Colors.white,
      ),
      //caption: TextStyle(color: Colors.white),
    );
  }
}
