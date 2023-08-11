import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medzo/firebase_options.dart';
import 'package:medzo/theme/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: AppColors.lightGrey,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel Import and Export',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WebHomeScreen(),
    );
  }
}

class WebHomeScreen extends StatelessWidget {
  final CollectionReference medicinesRef =
      FirebaseFirestore.instance.collection('medicines');

  Future<void> importExcelFile() async {
    final FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.accept = '.xlsx'; // Specify the accepted file type(s)
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.length == 1) {
        final file = files[0];
        final reader = FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((e) async {
          final bytes = reader.result as Uint8List;
          final excel = Excel.decodeBytes(bytes);

          for (var table in excel.tables.keys) {
            for (var row in excel.tables[table]!.rows) {
              // Process and update Firestore based on row data
              // You may need to map Excel columns to Firestore fields
              // Use Firestore API to insert or update records
              final data = {
                'medicineName': row[0],
                'categoryId': row[1],
                'shortDescription': row[2],
                // ... map other fields
              };

              await medicinesRef.doc(row[0]?.sheetName.toString()).set(data);
            }
          }
        });
      }
    });
  }

  Future<void> exportExcelFile() async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    final querySnapshot = await medicinesRef.get();

    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      if (data == null && data is Map<String, dynamic>) {
        sheet.appendRow([
          data['medicineName'],
          data['categoryId'],
          data['shortDescription']
        ]);
      }
    }

    final Blob mBlob = Blob([excel.encode()] as Uint8List);
    // final url = Url.createObjectUrlFromBlob(mBlob);
    // final anchor = AnchorElement(href: url)
    //   ..target = 'blank'
    //   ..download = 'medicines.xlsx' // Specify the file name
    //   ..click();
    // Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Excel Import and Export')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: importExcelFile,
              child: Text('Import Excel File',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: exportExcelFile,
              child: Text('Export Excel File',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
