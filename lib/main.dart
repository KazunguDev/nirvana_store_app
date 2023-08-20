import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nirvana_store_app/constants/theme.dart';
import 'package:nirvana_store_app/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:nirvana_store_app/firebase_helper/firebase_options/firebase_options.dart';
import 'package:nirvana_store_app/provider/app_provider.dart';
import 'package:nirvana_store_app/screens/auth_ui/home/home.dart';
import 'package:nirvana_store_app/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(create: (context)=> AppProvider(),
     child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nirvana Store',
      theme: themeData,
      home: StreamBuilder(
        stream: FirebaseAuthHelper.instance.getAuthChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  const HomePage();
          }
          return const SplashScreen();
        },
      ),
     ),  );
  }
}
//A Screen from which the app starts..