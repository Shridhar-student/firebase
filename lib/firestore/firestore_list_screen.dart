import 'dart:async';

import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/firestore/firestore_data_add.dart';
import 'package:firebase/home/add_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final editController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  showDialogPost(String desc, String id) {
    editController.text = desc;
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: editController,
                decoration: const InputDecoration(hintText: 'Edit'),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: () {}, child: const Text('Update'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const LoginScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(
                        'Logged out succesfully',
                        style: TextStyle(color: Colors.white),
                      )));
                }).onError((error, t) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('data'),
                    subtitle: Text('id'),
                    trailing: PopupMenuButton(
                      onSelected: (value) {},
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          leading: const Icon(Icons.edit),
                          title: const Text('Edit'),
                        )),
                        const PopupMenuItem(
                            child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                        )),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return const FirestoreDataAddScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
