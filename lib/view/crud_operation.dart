import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/view/crud_datalist.dart';

// TODO : For practice of Database by kvn

class CrudOperation extends StatelessWidget {
  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("CRUD Firestore"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: tname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: temail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: tcontact,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Contact No.",
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String name = tname.text;
                  String email = temail.text;
                  String contact = tcontact.text;

                  String id = DateTime.now().microsecondsSinceEpoch.toString();

                  FirebaseFirestore.instance
                      .collection("crud_test")
                      .doc(id)
                      .set({
                    'id': id,
                    'Name': name,
                    'Email': email,
                    'Contact': contact
                  }).then((value) {
                    print("User Added");
                    Get.to(CrudDatalist());
                  });
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
