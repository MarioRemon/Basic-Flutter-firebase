// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'List.dart';
//import 'dart:html';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: addNewContact(),
    );
  }
}

class addNewContact extends StatefulWidget {
  const addNewContact({
    Key? key,
  }) : super(key: key);

  @override
  State<addNewContact> createState() => addNewContactState();
}

class addNewContactState extends State<addNewContact> {
  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final phoneNumberController = TextEditingController();
    return (Scaffold(
        appBar: AppBar(
          title: Text('Add New Contact'),
          actions: <Widget>[
            IconButton(onPressed: () => (Null), icon: Icon(Icons.person)),
          ],
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () => {print("add Image")},
                  ),
                ),
                /////////////////////////////////////////

                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                  autofocus: true,
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: "Second Name",
                  ),
                  autofocus: true,
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autofocus: true,
                ),
                FloatingActionButton.extended(
                    label: Text("Submit"),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      createUser(
                          firstname: firstNameController.text,
                          lastname: lastNameController.text,
                          phonenumber: phoneNumberController.text);
                      print("navigating");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeoncdPage()));
                    })
              ],
            ),
          ),
        )));
  }

  Future createUser(
      {required String firstname,
      required String lastname,
      required String phonenumber}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final json = {
      'firstname': firstname,
      'secondname': lastname,
      'phonenumber': phonenumber,
    };
    await docUser.set(json);
  }
}
