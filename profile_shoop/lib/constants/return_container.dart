import 'package:flutter/material.dart';

class emailScreen extends StatefulWidget {
  const emailScreen({super.key});

  @override
  State<emailScreen> createState() => _emailScreenState();
}

class _emailScreenState extends State<emailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385,
      height: 416,
      decoration: BoxDecoration(
        color: Color(0xFF425769),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(55),
          topRight: Radius.circular(55),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment(0.0, -0.40),
            child: FractionalTranslation(
              translation: Offset(0.0, -0.40),
              child: Container(
                height: 40,
                width: 250,
                // padding: EdgeInsets.symmetric(horizontal: 250),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F9FD),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.email,
                      size: 25,
                      color: Color(0xFF475269),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '@user12345.com',
                      style: TextStyle(
                          color: Color(0xFF475269),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
