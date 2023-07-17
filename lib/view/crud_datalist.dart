import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudDatalist extends StatelessWidget {
  const CrudDatalist({super.key});

  // TODO : For practice of Database by kvn

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Data"),
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("crud_test").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  String id = data["id"];
                  return ListTile(
                    onTap: () {
                      FirebaseFirestore.instance.collection("crud_test").doc(id).update(
                          {
                            'Name' : "Kevin",
                            'Contact' : "12311231234",
                            'Email' : "kevin@gmail.com",
                            'id' : id
                          }).then((value) {
                            print("User Updated");
                      });
                    },
                    title: Text("${data['Name']}"),
                    subtitle: Text("${data['Email']}"),
                    trailing: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("crud_test")
                              .doc(id)
                              .delete()
                              .then((value) {
                            print("User Deleted");
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
