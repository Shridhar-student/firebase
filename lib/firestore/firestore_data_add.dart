import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirestoreDataAddScreen extends StatefulWidget {
  const FirestoreDataAddScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FirestoreDataAddScreenState();
  }
}

class _FirestoreDataAddScreenState extends State<FirestoreDataAddScreen> {
  final firestoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextFormField(
              maxLines: 4,
              controller: firestoreController,
              decoration: const InputDecoration(
                  hintText: "Add text for firestore",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 30),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple),
                child: const Text('Add data'))
          ],
        ),
      ),
    );
  }
}
