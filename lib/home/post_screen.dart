import 'dart:async';

import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/home/add_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final filterController = TextEditingController();
  final editController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final postdata = FirebaseDatabase.instance.ref('post');

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
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    postdata.child(id).update({
                      'description': editController.text.toString()
                    }).then((val) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.blue,
                          content: Text(
                            'Updated succesfully',
                            style: TextStyle(color: Colors.white),
                          )));
                    }).onError((error, t) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    });
                  },
                  child: const Text('Update'))
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
          // Expanded(
          //   child: StreamBuilder(
          //       stream: postdata.onValue,
          //       builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //         return ListView.builder(
          //             itemCount: snapshot.data!.snapshot.children.length,
          //             itemBuilder: (ctx, index) {
          //               Map<dynamic, dynamic> data =
          //                   snapshot.data!.snapshot.value as dynamic;
          //               List<dynamic> list = [];
          //               list = data.values.toList();
          //               final postDataList = list[index];
          //               print(data[index]);
          //               return ListTile(
          //                 title: Text(postDataList['description']),
          //                 subtitle: Text(postDataList['type']),
          //               );
          //             });
          //       }),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: filterController,
              onChanged: (value) {
                print(filterController.text);
                setState(() {});
              },
              decoration: const InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: postdata,
                defaultChild: const Center(
                  child: CircularProgressIndicator(),
                ),
                itemBuilder: (context, snapshot, animation, index) {
                  final id = snapshot.child('id').value.toString();
                  final desc = snapshot.child('description').value.toString();
                  print(desc);

                  if (filterController.text.isEmpty) {
                    return ListTile(
                      title:
                          Text(snapshot.child("description").value.toString()),
                      subtitle: Text(id),
                      trailing: PopupMenuButton(
                        onSelected: (value) {},
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showDialogPost(desc, id);
                            },
                            leading: const Icon(Icons.edit),
                            title: const Text('Edit'),
                          )),
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              postdata.child(id).remove().then((val) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Deleted succesfully',
                                          style: TextStyle(color: Colors.white),
                                        )));
                              }).onError(
                                (error, stackTrace) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'Error occured',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )));
                                },
                              );
                            },
                            leading: const Icon(Icons.delete),
                            title: const Text('Delete'),
                          )),
                        ],
                      ),
                    );
                  } else if (desc.toLowerCase().contains(
                      filterController.text.toLowerCase().toString())) {
                    return ListTile(
                      title:
                          Text(snapshot.child("description").value.toString()),
                      subtitle: Text(id),
                    );
                  } else
                    // ignore: curly_braces_in_flow_control_structures
                    return Container();
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return const AddPostScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
