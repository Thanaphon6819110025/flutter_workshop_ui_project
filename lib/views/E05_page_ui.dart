import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/common.dart';
import 'e06_page_ui.dart';

/// OTP Verification
class E05PageUI extends StatefulWidget {
  const E05PageUI({super.key});

  @override
  State<E05PageUI> createState() => _E05PageUIState();
}

class _E05PageUIState extends State<E05PageUI> {
  static const _otpLength = 4;

  final _controllers = List.generate(_otpLength, (_) => TextEditingController());
  final _nodes = List.generate(_otpLength, (_) => FocusNode());
  Timer? _timer;
  int _seconds = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds <= 1) {
        t.cancel();
        setState(() => _seconds = 0);
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  Widget _otpBox(int i) {
    OutlineInputBorder border() => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFCFCFCF)),
        );
    return SizedBox(
      width: 55,
      height: 55,
      child: TextField(
        controller: _controllers[i],
        focusNode: _nodes[i],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: poppins(size: 20, weight: FontWeight.w600),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFE4E4E4),
          contentPadding: EdgeInsets.zero,
          enabledBorder: border(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.focus, width: 1.5),
          ),
        ),
        onChanged: (v) {
          if (v.isNotEmpty && i < _otpLength - 1) {
            _nodes[i + 1].requestFocus();
          } else if (v.isEmpty && i > 0) {
            _nodes[i - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CircleBackButton(background: Color(0xFFF3E6A8)),
                  ),
                  Text('OTP Verification', style: poppins(size: 20, weight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 32),
              // ภาพประกอบ (ใส่รูปที่ AppAssets.otp)
              const SizedBox(
                width: double.infinity,
                height: 280,
                child: AppImage(asset: AppAssets.otp, fit: BoxFit.contain),
              ),
              const SizedBox(height: 28),
              Text('Enter OTP', style: poppins(size: 22, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                'An 4 digit code has been sent to your email',
                style: poppins(size: 15, color: const Color(0xFF555555)),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (int i = 0; i < _otpLength; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    _otpBox(i),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: _seconds > 0
                    ? Text.rich(
                        TextSpan(
                          style: poppins(size: 14, color: const Color(0xFF555555)),
                          children: [
                            const TextSpan(text: 'You should recieve the OTP in '),
                            TextSpan(
                              text: '$_seconds Second',
                              style: poppins(
                                size: 14,
                                weight: FontWeight.w600,
                                color: const Color(0xFFE0762A),
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: _startTimer,
                        child: Text('Resend OTP',
                            style: poppins(size: 14, weight: FontWeight.w600, color: AppColors.link)),
                      ),
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: 'Verify',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const E06PageUI()),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
