import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// สีที่ใช้ในแอป
class AppColors {
  static const orange = Color(0xFFEB963A);
  static const yellow = Color(0xFFE0C95E);
  static const link = Color(0xFFE8A23F);
  static const border = Color(0xFF8E8E8E);
  static const hint = Color(0xFF8A8A8A);
  static const focus = Color(0xFFF0C44C);
}

/// ชื่อไฟล์รูปภาพ — เอารูปไปวางในโฟลเดอร์ assets/images/ ตามชื่อเหล่านี้
class AppAssets {
  static const juice = 'assets/images/e01_juice.png'; // E01 รูปผลไม้ + น้ำผลไม้
  static const header = 'assets/images/header_orange.png'; // E02, E03, E04, E06 รูปส้มพื้นเหลือง
  static const otp = 'assets/images/e05_otp.png'; // E05 ภาพประกอบ OTP
  static const google = 'assets/images/ic_google.png';
  static const facebook = 'assets/images/ic_facebook.png';
  static const apple = 'assets/images/ic_apple.png';
}

TextStyle poppins({
  double size = 14,
  FontWeight weight = FontWeight.w400,
  Color color = Colors.black,
}) =>
    GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);

/// รูปภาพจาก assets — ถ้ายังไม่ได้ใส่ไฟล์จะแสดงไอคอนว่างแทน (ไม่ error)
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.fallbackIcon = Icons.image_outlined,
    this.fallbackColor = Colors.black26,
  });

  final String asset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final IconData fallbackIcon;
  final Color fallbackColor;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      errorBuilder: (_, __, ___) => SizedBox(
        width: width,
        height: height,
        child: Center(child: Icon(fallbackIcon, color: fallbackColor, size: 40)),
      ),
    );
  }
}

/// ปุ่มย้อนกลับกลม ๆ
class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    super.key,
    this.background = const Color.fromRGBO(255, 255, 255, 0.5),
    this.size = 36,
  });

  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.maybePop(context),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: const Icon(Icons.chevron_left, color: Colors.white, size: 26),
      ),
    );
  }
}

class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final p = Path()
      ..lineTo(0, s.height)
      ..cubicTo(s.width * 0.40, s.height, s.width * 0.75, s.height * 0.78,
          s.width, s.height * 0.56)
      ..lineTo(s.width, 0)
      ..close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// ส่วนหัวพื้นเหลืองโค้ง ๆ ที่ใส่รูปส้ม
class CurvedHeader extends StatelessWidget {
  const CurvedHeader({
    super.key,
    this.heightFactor = 0.86,
    this.showBack = false,
    this.imageAlignment = Alignment.topCenter,
  });

  /// ความสูงเทียบกับความกว้างหน้าจอ
  final double heightFactor;
  final bool showBack;
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final top = MediaQuery.paddingOf(context).top;
    return SizedBox(
      width: double.infinity,
      height: w * heightFactor,
      child: ClipPath(
        clipper: _CurveClipper(),
        child: Container(
          color: AppColors.yellow,
          child: Stack(
            children: [
              Positioned.fill(
                child: AppImage(
                  asset: AppAssets.header,
                  fit: BoxFit.cover,
                  alignment: imageAlignment,
                ),
              ),
              if (showBack)
                Positioned(left: 20, top: top + 8, child: const CircleBackButton()),
            ],
          ),
        ),
      ),
    );
  }
}

/// ปุ่มสีส้ม
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.radius = 18,
    this.trailing,
  });

  final String label;
  final VoidCallback? onPressed;
  final double radius;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        child: trailing == null
            ? Text(label, style: poppins(size: 19, weight: FontWeight.w600, color: Colors.white))
            : Row(
                children: [
                  const SizedBox(width: 8),
                  Text(label, style: poppins(size: 18, weight: FontWeight.w600, color: Colors.white)),
                  const Spacer(),
                  trailing!,
                  const SizedBox(width: 8),
                ],
              ),
      ),
    );
  }
}

/// ช่องกรอกข้อมูล ขอบมน
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color c, double w) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c, width: w),
        );
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: poppins(size: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: poppins(size: 13, color: AppColors.hint),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: border(AppColors.border, 1),
        focusedBorder: border(AppColors.focus, 1.5),
      ),
    );
  }
}

/// เส้น ───── OR ─────
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    const line = Expanded(child: Divider(color: Color(0xFFEFB760), thickness: 1));
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('OR', style: poppins(size: 16)),
        ),
        line,
      ],
    );
  }
}

/// ไอคอน Google / Facebook / Apple
class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

  Widget _icon(String asset, IconData fallback, Color color) {
    return SizedBox(
      width: 38,
      height: 38,
      child: AppImage(
        asset: asset,
        fit: BoxFit.contain,
        fallbackIcon: fallback,
        fallbackColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _icon(AppAssets.google, Icons.g_mobiledata, Colors.red),
        const SizedBox(width: 30),
        _icon(AppAssets.facebook, Icons.facebook, const Color(0xFF3B7AF0)),
        const SizedBox(width: 30),
        _icon(AppAssets.apple, Icons.apple, Colors.black),
      ],
    );
  }
}

/// ข้อความ "Don't have an Account? Create Account"
class FooterLink extends StatelessWidget {
  const FooterLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  final String text;
  final String linkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: poppins(size: 12)),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(linkText, style: poppins(size: 12, color: AppColors.link)),
        ),
      ],
    );
  }
}