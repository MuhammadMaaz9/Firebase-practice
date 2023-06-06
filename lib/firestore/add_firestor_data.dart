import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  bool loading = false;
  final postcontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Add Firestore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postcontroller,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
              title: 'Add',
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                firestore.doc(id).set({
                  'title': postcontroller.text.toString(),
                  'id': id,
                }).then((value) {
                  postcontroller.clear();
                  Utils().getmessage('data added successfully');
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().getmessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
