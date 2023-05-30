import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/views/posts.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  String VerificationId;
  VerifyPhone({super.key, required this.VerificationId});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final verifycode = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: verifycode,
              decoration: const InputDecoration(
                hintText: 'Enter 6 digit code',
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
              loading: loading,
              title: 'Verify',
              ontap: () async {
                final credentials = PhoneAuthProvider.credential(
                  verificationId: widget.VerificationId,
                  smsCode: verifycode.text,
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostScreen()));

                try {
                  await _auth.signInWithCredential(credentials);
                } catch (e) {}
              },
            )
          ],
        ),
      ),
    );
  }
}
