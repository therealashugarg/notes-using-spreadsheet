import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text reusableText(String text) {
  return Text(
    text,
    style: GoogleFonts.jost(
        color: Colors.grey[850], fontSize: 15, fontWeight: FontWeight.w600),
    textAlign: TextAlign.center,
  );
}
