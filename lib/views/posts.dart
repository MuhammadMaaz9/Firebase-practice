import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
  final _ref = FirebaseDatabase.instance.ref('Post');
  final searchcontroller = TextEditingController();
  final editcontroller = TextEditingController();
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
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: searchcontroller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search here!',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: const Center(child: CircularProgressIndicator()),
              query: _ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('Name').value.toString();

                if (searchcontroller.text.isEmpty) {
                  return ListTile(
                    subtitle: Text(snapshot.child('id').value.toString()),
                    title: Text(snapshot.child('Name').value.toString()),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_horiz),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(title,
                                    snapshot.child('id').value.toString());
                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            )),
                        const PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                            ))
                      ],
                    ),
                  );
                } else if (title.toLowerCase().contains(
                    searchcontroller.text.toLowerCase().toLowerCase())) {
                  return ListTile(
                    title: Text(snapshot.child('Name').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
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
                  _ref.child(id).update(
                      {'Name': editcontroller.text.toString()}).then((value) {
                    Utils().getmessage('Edit Done');
                  }).onError((error, stackTrace) {
                    Utils().getmessage(error.toString());
                  });
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
