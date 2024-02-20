import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profile_avatar/constants/return_container.dart';
import 'package:profile_avatar/pages/AccountPage.dart';
import 'package:profile_avatar/pages/AskAnExpertPage.dart';
import 'package:profile_avatar/pages/HelpCenterPage.dart';
import 'package:profile_avatar/pages/PreferencesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const ImagePickerPage(),
    );
  }
}

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;
  bool _isLoading = false;
  String _username = "Username";

  @override
  void initState() {
    super.initState();
    _loadImageAndUsernameFromCache();
  }

  Future<void> _loadImageAndUsernameFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('imagePath');
    final username = prefs.getString('username');
    if (imagePath != null) {
      final imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        final imageBytes = await imageFile.readAsBytes();
        setState(() {
          _imageBytes = Uint8List.fromList(imageBytes);
        });
      }
    }
    if (username != null) {
      setState(() {
        _username = username;
      });
    }
  }

  Future<void> _saveImagePathToCache(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', imagePath);
  }

  Future<void> _saveUsernameToCache(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<void> _getImageFromGallery() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final appDir = await getApplicationDocumentsDirectory();
        const imageFileName = 'avatar.jpg';
        final savedImage = File('${appDir.path}/$imageFileName');
        await savedImage.writeAsBytes(await image.readAsBytes());

        await _saveImagePathToCache(savedImage.path);

        final imageBytes = await savedImage.readAsBytes();
        setState(() {
          _imageBytes = Uint8List.fromList(imageBytes);
        });
      }
    } catch (e) {
      print('Ошибка: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _openFullScreenImage() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Полноэкранный режим'),
            ),
            body: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Hero(
                tag: 'imageHero',
                child: Image.memory(
                  _imageBytes!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _editUsername() async {
    final updatedUsername = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Изменить имя пользователя'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Введите новое имя пользователя',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_username);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );

    if (updatedUsername != null) {
      await _saveUsernameToCache(updatedUsername);
    }
  }

  Future<void> _confirmDeleteImage() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить фото профиля?'),
          content: const Text('Вы действительно хотите удалить фото профиля?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                _deleteImage();
                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  void _deleteImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('imagePath');
    setState(() {
      _imageBytes = null;
    });
  }

  void _openPreferences() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PreferencesPage()));
  }

  void _openAccount() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AccountPage()));
  }

  void _openHelpCenter() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HelpCenterPage()));
  }

  void _openAskAnExpert() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AskAnExpertPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEDDEE),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 80,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF425769),
                  Color(0xFF425769),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          title: const Text(
            '𝐏𝐫𝐨𝐟𝐢𝐥𝐞',
            style: TextStyle(
              fontSize: 30.5,
              color: Color(0xFFCEDDEE),
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              color: const Color(0xFFCEDDEE),
              icon: const Icon(Icons.edit),
              onPressed: _editUsername,
            ),
            IconButton(
              color: const Color(0xFFCEDDEE),
              icon: const Icon(Icons.delete),
              onPressed: _confirmDeleteImage,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: _imageBytes != null ? _openFullScreenImage : null,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Hero(
                    tag: 'imageHero',
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: const Color(0xFF425769),
                      backgroundImage: _imageBytes != null
                          ? MemoryImage(_imageBytes!)
                          : null,
                      child: _imageBytes == null
                          ? const Icon(
                              Icons.person,
                              size: 100,
                            )
                          : null,
                    ),
                  ),
                  if (_isLoading) const CircularProgressIndicator(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: _isLoading ? null : _getImageFromGallery,
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 25,
                        color: Color.fromARGB(255, 252, 250, 250),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            IntrinsicWidth(
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const emailScreen();
                          });
                    },
                    icon: const Icon(Icons.email_outlined),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF425769),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _username,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFFCEDDEE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFF425769),
                      ),
                      onPressed: _openPreferences,
                    ),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: Color(0xFF425769),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.account_circle,
                        color: Color(0xFF425769),
                      ),
                      onPressed: _openAccount,
                    ),
                    const Text(
                      'Account',
                      style: TextStyle(
                        color: Color(0xFF425769),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.help,
                        color: Color(0xFF425769),
                      ),
                      onPressed: _openHelpCenter,
                    ),
                    const Text(
                      'Help Center',
                      style: TextStyle(
                        color: Color(0xFF425769),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart_rounded,
                        color: Color(0xFF425769),
                      ),
                      onPressed: _openAskAnExpert,
                    ),
                    const Text(
                      'Purchases',
                      style: TextStyle(
                        color: Color(0xFF425769),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
