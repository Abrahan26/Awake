 // @dart=2.9
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:newtotolist/Homepages/Homepage_Diario.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:newtotolist/pages/Homepage.dart';
import 'package:provider/provider.dart';
import 'Onboarding.dart';
import 'package:flutter/material.dart';

// const firebaseOptions = FirebaseOptions(
//   appId: '1:596776435344:android:a39bca37d7102d8bae6215',
//   apiKey: 'AIzaSyDHFtkFkY3-tIPdFa2hSVkrIpJ76My0GYk',
//   projectId: 'testfirebase-bbf06',
//   messagingSenderId: '596776435344',
//   authDomain: 'FIREBASE_AUTH_DOMAIN',
// );

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp().then((value) => 
    runApp(MyApp()));
  // await Firebase.initializeApp(options: firebaseOptions);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir',
        primarySwatch: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'avenir',
        primarySwatch: Colors.red),
      home: StreamBuilder<fireauth.User>(
        stream: fireauth.FirebaseAuth.instance.authStateChanges(),
        builder: ( context,  snapshot) {
          if (snapshot.hasData) {
            return Homepage();
          } else {
            return Onboarding();
          }
        },
      ),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget{
//   const AuthenticationWrapper({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final firebaseuser = context.watch<fireauth.User>();
//     if (firebaseuser != null) {
//       return HomePage();      
//     }
//     return Onboarding();
//   }}

//flutter run --no-sound-null-safety


