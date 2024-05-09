import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_spot_1/database/auth/service.dart';
import 'package:flutter_spot_1/routes/routes.dart';
//import 'package:flutter_spot_1/theme/themeDark.dart';
import 'package:flutter_spot_1/theme/themeLight.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAvdAKlUbxaCDLFS5XAYwrGyd-_Av1hls8',
          appId: '1:249841653632:android:e82121d3bc2a375ffd5365',
          messagingSenderId: '249841653632',
          projectId: 'spotproject-ce8b3',
          storageBucket: 'spotproject-ce8b3.appspot.com'));
  runApp(const ThemeAppMenu());
}

class ThemeAppMenu extends StatelessWidget {
  const ThemeAppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().currentUser,
      child: PlatformApp(
        debugShowCheckedModeBanner: false,
        title: 'Spot',
        builder: (context, child) {
          return MaterialApp(
            theme: lightTheme,
            //darkTheme: darkTheme,
            initialRoute: '/auth',
            routes: routes,
          );
        },
      ),
    );
  }
}
