import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firestore/add_firestor_data.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/views/login.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final _auth = FirebaseAuth.instance;
  final editcontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddFirestoreData()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                }).onError(
                  (error, stackTrace) {
                    Utils().getmessage(error.toString());
                  },
                );
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        backgroundColor: Colors.brown,
        title: const Text(
          'Post Screen',
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: firestore,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();

              if (snapshot.hasError) {
                return Text('some error');
              }
              return Expanded(
                  child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.docs[index]['title'].toString()),
                  );
                },
              ));
            },
          )
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editcontroller.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: Container(
            child: TextField(
              controller: editcontroller,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Update')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
          ],
        );
      },
    );
  }
}
