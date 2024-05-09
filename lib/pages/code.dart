import 'package:flutter/material.dart';
import 'package:flutter_spot_1/database/auth/service.dart';
import 'package:flutter_spot_1/theme/themeLight.dart';

class VerificationPage extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();
  final String verificationId;
  final AuthService authService = AuthService();

  VerificationPage({super.key, required this.verificationId});

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
                  const Text(
                    'Введите код подтверждения',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    decoration: InputDecoration(
                      hintText: 'Введите код',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      bool verified =
                          await authService.verifyCode(codeController.text);
                      if (verified) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Код подтверждения успешно проверен'),
                          ),
                        );
                        Navigator.popAndPushNamed(context, '/auth');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Неверный код подтверждения'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 253, 103, 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Подтвердить'),
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
