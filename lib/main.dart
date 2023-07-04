import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:indagram/screens/SignInScreen.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

 
// class GoogleSignIn extends StatefulWidget {
//   GoogleSignIn({Key? key}) : super(key: key);
//    @override
//   _GoogleSignInState createState() => _GoogleSignInState();
// }
 
// class _GoogleSignInState extends State<GoogleSignIn> {
//   @override
//   Widget build(BuildContext context) {
     
//     // we return the MaterialApp here ,
//     // MaterialApp contain some basic ui for android ,
//     return MaterialApp(   
       
//       //materialApp title
//       title: 'GEEKS FOR GEEKS', 
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
       
//       // home property contain SignInScreen widget
//       home: SignInScreen(),  
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}