import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Greeting extends StatelessWidget {
  const Greeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hey User',
                style: GoogleFonts.montserrat(
                    fontSize: 27, fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            Text('Good Morning',
                style: GoogleFonts.montserrat(
                    fontSize: 27, fontWeight: FontWeight.w700))
          ]),
      ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
              height: 70,
              width: 70,
              child: Image.asset('assets/images/user.png')))
    ]);
  }
}
