import 'package:flutter/material.dart';

import '../widgets/common.dart';
import 'e02_page_ui.dart';

/// Create new password
class E06PageUI extends StatelessWidget {
  const E06PageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CurvedHeader(showBack: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('Create New Password',
                      style: poppins(size: 20, weight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Enter new password', style: poppins(size: 18)),
                  const SizedBox(height: 18),
                  const AppTextField(hint: 'Enter New password', obscureText: true),
                  const SizedBox(height: 12),
                  const AppTextField(hint: 'Confirm password', obscureText: true),
                  const SizedBox(height: 22),
                  PrimaryButton(
                    label: 'Submit',
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const E02PageUI()),
                      (route) => route.isFirst,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}