// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common.dart';
import 'e02_page_ui.dart';

/// หน้าแรก: Berry Juice
class E01PageUI extends StatelessWidget {
  const E01PageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            children: [
              // รูปผลไม้ (ใส่รูปที่ AppAssets.juice)
              const Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: AppImage(asset: AppAssets.juice, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'BERRY JUICE',
                style: GoogleFonts.roboto(
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'A Moments of healthy sip\nThe best vitamin for your health',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 16, height: 1.25),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Explore Now',
                radius: 28,
                trailing: const Icon(Icons.chevron_right, color: Colors.white, size: 34),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const E02PageUI()),
                ),
              ),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}