import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final TextEditingController? controller;

  const BuildTextField({
    Key? key,
    required this.label,
    this.isObscure = false,
    this.controller,
  }) : super(key: key);

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  // State lokal untuk mengelola visibilitas password
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: body1TextStyle.copyWith(color: RColor().primaryBlueColor)),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _isObscured, // Menggunakan state lokal
            style: body1TextStyle.copyWith(
              color: RColor().primaryBlueColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),

              // --- PERUBAHAN DI SINI ---
              // Menambahkan ikon di akhir field jika isObscure true
              suffixIcon: widget.isObscure
                  ? IconButton(
                      icon: Icon(
                        // Mengubah ikon berdasarkan state
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: RColor().secondaryGreyColor,
                      ),
                      onPressed: () {
                        // Memperbarui state saat ikon ditekan
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null, // Tidak menampilkan ikon jika bukan password field
            ),
          ),
        )
      ],
    );
  }
}
