import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final loading;
  const RoundButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                )
              : Text(title,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
        ),
      ),
    );
  }
}
