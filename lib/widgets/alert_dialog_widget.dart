import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(child: CircularProgressIndicator()),
    );
  }
}