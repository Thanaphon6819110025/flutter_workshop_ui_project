import 'package:flutter/material.dart';

import '../widgets/common.dart';
import 'e02_page_ui.dart';

/// Register
class E03PageUI extends StatelessWidget {
  const E03PageUI({super.key});

  @override
  Widget build(BuildContext context) {
    final linkStyle = poppins(
      size: 12,
      weight: FontWeight.w600,
      color: AppColors.link,
    ).copyWith(decoration: TextDecoration.underline, decorationColor: AppColors.link);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ส่วนหัวเตี้ยกว่าหน้าอื่น และโชว์ส่วนล่างของรูป
            const CurvedHeader(heightFactor: 0.56, imageAlignment: Alignment.bottomCenter),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Text('Register', style: poppins(size: 28, weight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text('Create your new account', style: poppins(size: 18)),
                  const SizedBox(height: 22),
                  const AppTextField(hint: 'Name'),
                  const SizedBox(height: 12),
                  const AppTextField(hint: 'E-mail', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 12),
                  const AppTextField(hint: 'Phone', keyboardType: TextInputType.phone),
                  const SizedBox(height: 12),
                  const AppTextField(hint: 'Password', obscureText: true),
                  const SizedBox(height: 18),
                  Text.rich(
                    TextSpan(
                      style: poppins(size: 12),
                      children: [
                        const TextSpan(text: 'By signing up you agree to our '),
                        TextSpan(text: 'Terms & Conditions', style: linkStyle),
                        const TextSpan(text: '\nand '),
                        TextSpan(text: 'Privacy Policy', style: linkStyle),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(label: 'Sign Up', onPressed: () {}),
                  const SizedBox(height: 18),
                  const OrDivider(),
                  const SizedBox(height: 22),
                  const SocialRow(),
                  const SizedBox(height: 24),
                  FooterLink(
                    text: 'Already have an Account?',
                    linkText: 'Log In',
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const E02PageUI()),
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