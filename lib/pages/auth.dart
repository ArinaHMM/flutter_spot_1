import 'package:flutter/material.dart';
import 'package:flutter_spot_1/theme/themeLight.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spot_1/database/auth/service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const SizedBox(height: 20.0),
                  _buildRoundedInput(
                    controller: emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 20.0),
                  _buildRoundedInput(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          Toast.show("Заполните поля");
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  color: Colors.black,
                                ),
                              );
                            },
                          );
                          var user = await authService.signIn(
                            emailController.text,
                            passwordController.text,
                          );
                          if (user != null) {
                            Toast.show('Вы успешно вошли');
                            Navigator.popAndPushNamed(context, '/base');
                          } else {
                            Toast.show('Неверный логин или пароль');
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text('Войти!'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 253, 103, 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const SizedBox(height: 10.0),
                  _buildRoundedButton(
                    text: 'Создать аккаунт',
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/reg');
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'В первый раз?',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedInput({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return SizedBox(
      width: 300.0,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
  }) {
    return SizedBox(
      width: 300.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor ?? Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
