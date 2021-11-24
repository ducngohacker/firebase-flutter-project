import 'package:firebase_database/app/sign_in/landing_page.dart';
import 'package:firebase_database/app/sign_in/sign_in_page.dart';
import 'package:firebase_database/services/auth.dart';
import 'package:firebase_database/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Provider<AuthBase>(
      create: (_) => Auth(),
      child: MaterialApp(

        theme: ThemeData(
          primarySwatch: Colors.indigo
        ),
        home:  LandingPage()
      ),
    );
  }
}
