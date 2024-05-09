import 'package:flutter_spot_1/pages/auth.dart';
import 'package:flutter_spot_1/pages/base.dart';
import 'package:flutter_spot_1/pages/code.dart';
import 'package:flutter_spot_1/pages/reg.dart';

final routes = {
  '/auth': (context) => const AuthPage(),
  '/reg': (context) => const RegistrationPage(),
  '/ver': (context) => VerificationPage(
        verificationId: '',
      ),
  '/base': (context) => const SimplePage(),
};
