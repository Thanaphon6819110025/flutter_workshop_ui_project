import 'package:flutter/material.dart';

import '../widgets/common.dart';
import 'e03_page_ui.dart';
import 'e04_page_ui.dart';

/// Login
class E02PageUI extends StatefulWidget {
  const E02PageUI({super.key});

  @override
  State<E02PageUI> createState() => _E02PageUIState();
}

class _E02PageUIState extends State<E02PageUI> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hidePass = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

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
                children: [
                  Text('Welcome back', style: poppins(size: 28, weight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text('Login to your account', style: poppins(size: 18)),
                  const SizedBox(height: 22),
                  AppTextField(
                    hint: 'Enter email or phone',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    hint: 'Password',
                    controller: _passCtrl,
                    obscureText: _hidePass,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _hidePass ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.hint,
                      ),
                      onPressed: () => setState(() => _hidePass = !_hidePass),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const E04PageUI()),
                      ),
                      child: Text('Forgot Password ?',
                          style: poppins(size: 12, color: AppColors.link)),
                    ),
                  ),
                  const SizedBox(height: 22),
                  PrimaryButton(label: 'Log In', onPressed: () {}),
                  const SizedBox(height: 22),
                  const OrDivider(),
                  const SizedBox(height: 24),
                  const SocialRow(),
                  const SizedBox(height: 28),
                  FooterLink(
                    text: "Don't have an Account?",
                    linkText: 'Create Account',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const E03PageUI()),
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