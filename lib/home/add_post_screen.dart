import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPostScreenState();
  }
}

class _AddPostScreenState extends State<AddPostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref("post");
  final databaseTypeRef = FirebaseDatabase.instance.ref("type");
  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextFormField(
              controller: postController,
              decoration: const InputDecoration(
                  hintText: "Add text for post", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  String id = DateTime.now().millisecond.toString();
                  databaseRef.child(id).set({
                    'id': id,
                    'description': postController.text.toString()
                  }).then((val) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 24, 79, 230),
                        content: Text(
                          'Added succesfully',
                          style: TextStyle(color: Colors.white),
                        )));
                    postController.clear();
                  }).onError((error, t) {});
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 30),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple),
                child: const Text('Add post'))
          ],
        ),
      ),
    );
  }
}
