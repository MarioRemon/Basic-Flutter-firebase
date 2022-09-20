// ignore_for_file:

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'User.dart';

class SeoncdPage extends StatelessWidget {
  const SeoncdPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Contacts(),
    );
  }
}

class Contacts extends StatefulWidget {
  Contacts({
    Key? key,
  }) : super(key: key);

  @override
  State<Contacts> createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    Stream<List<User>> readUsers() => FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshots) =>
            snapshots.docs.map((doc) => User.fromJson(doc.data())).toList());
    Widget buildUsers(User user) => ListTile(
          title: Text(user.firstname),
        );
    return Scaffold(
        body: StreamBuilder<List<User>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(
                  children: users.map(buildUsers).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
