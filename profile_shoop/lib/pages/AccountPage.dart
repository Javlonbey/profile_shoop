import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEDDEE),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 9.0,
              top: 30.0,
            ),
            child: Stack(
              children: [
                Center(
                  child: Transform.translate(
                    offset: const Offset(0, 165.0),
                    child: const CircleAvatar(
                      radius: 75,
                      backgroundColor: Color(0xFFF5F9FD),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF475269),
                        size: 100,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F9FD),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF475269).withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Color(0xFF475269),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 170),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF475269),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    'Акаунт Настройки⚙️',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FD),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 10.0),
                  child: Icon(
                    Icons.camera_alt,
                    size: 24,
                    color: Color(0xFF475269),
                  ),
                ),
                Text(
                  'Фото Профиля',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF475269),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FD),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 10.0),
                  child: Icon(
                    Icons.edit,
                    size: 24,
                    color: Color(0xFF475269),
                  ),
                ),
                Text(
                  'Изменить Имя',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF475269),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FD),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 10.0),
                  child: Icon(
                    Icons.info_outline,
                    size: 24,
                    color: Color(0xFF475269),
                  ),
                ),
                Text(
                  'Инструкция',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF475269),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FD),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 10.0),
                  child: Icon(
                    Icons.star_border,
                    size: 24,
                    color: Color(0xFF475269),
                  ),
                ),
                Text(
                  'Избранное',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF475269),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
