import 'package:flutter/material.dart';
import 'package:flutter_spot_1/database/auth/service.dart';
import 'package:flutter_spot_1/database/collections/users_collections.dart';
import 'package:flutter_spot_1/pages/code.dart'; // Импортируйте страницу верификации
import 'package:flutter_spot_1/theme/themeLight.dart';
//import 'package:toast/toast.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController phoneNumberController = TextEditingController();
  AuthService authService = AuthService();
  UsersCollection usersCollection = UsersCollection();
  static const String countryCode = '+7';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: GradientBackground(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/logo.png",
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Введите номер',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Нужно ввести номер',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Номер телефона',
                        prefix: const Text(countryCode),
                        prefixIcon: const Icon(Icons.phone),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 211, 230, 255),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      bool verified = await authService.verifyPhoneNumber(
                        countryCode + phoneNumberController.text,
                        context,
                      );
                      if (verified) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationPage(
                              verificationId: authService.verificationId,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Не удалось отправить код подтверждения'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 30),
                      backgroundColor: const Color.fromARGB(255, 253, 103, 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Продолжить'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
