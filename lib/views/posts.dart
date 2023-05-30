import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/views/add_post_screen.dart';
import 'package:firebase_practice/views/login.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
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
        children: [],
      ),
    );
  }
}
