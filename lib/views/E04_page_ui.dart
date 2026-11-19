import 'package:flutter/material.dart';

import '../widgets/common.dart';
import 'e03_page_ui.dart';
import 'e05_page_ui.dart';

/// Forgot password
class E04PageUI extends StatelessWidget {
  const E04PageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const CurvedHeader(showBack: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text('Forgot your password?',
                            style: poppins(size: 20, weight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('Enter email address', style: poppins(size: 15)),
                        const SizedBox(height: 10),
                        const AppTextField(keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          label: 'Send code',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const E05PageUI()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  FooterLink(
                    text: "Don't have an Account?",
                    linkText: 'Create Account',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const E03PageUI()),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}