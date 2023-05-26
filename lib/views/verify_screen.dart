import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  String Verificationid;
  VerifyPhone({super.key, required this.Verificationid});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final phonenumber = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Verify PhoneNumber'),
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
              controller: phonenumber,
              decoration: const InputDecoration(
                hintText: '+123 455 866524',
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
              loading: loading,
              title: 'Login',
              ontap: () {
                setState(() {
                  loading = true;
                });
                _auth.verifyPhoneNumber(
                  phoneNumber: phonenumber.text,
                  verificationCompleted: (phoneAuthCredential) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (error) {
                    Utils().getmessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                  codeSent: (verificationId, forceResendingToken) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyPhone(
                                  Verificationid: verificationId,
                                )));
                    debugPrint('verifyy : ${verificationId.toString()}');
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) {
                    Utils().getmessage(verificationId.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
