
import 'package:eventflow/Screens/Bienvenu/eventDisplay.dart';
import 'package:eventflow/Screens/organizators/lists.dart';
import 'package:eventflow/Services/auth_Service.dart';
import 'package:eventflow/controller/google_sign_in.dart';

// KKIAPAY

import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';
import "package:eventflow/Screens/Bienvenu/paymentSuccess.dart";


// NEW VERSION


import 'dart:io';

import 'package:eventflow/Screens/Bienvenu/createEvenement.dart';
import 'package:flutter/material.dart';
// import 'package:eventflow/Screens/deodat/screens/';
// import 'package:eventflow/Screens/deodat/screens/events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eventflow/widgets/deodat/widgets/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:eventflow/Screens/deodat/screens/home_page.dart';
import 'package:eventflow/widgets/deodat/widgets/app_logo.dart';
import 'package:eventflow/widgets/deodat/widgets/my_circular_progress.dart';


import 'package:eventflow/Screens/Bienvenu/bienvenu1.dart';
import 'package:eventflow/Screens/Bienvenu/bienvenu2.dart';
import 'package:eventflow/Screens/Bienvenu/bienvenu4.dart';

import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => NotificationProvider(),
//       child: const MyApp(),
//     ),
//   );
// }



// some solutions for multi-provider error
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        // Other providers if any
      ],
      child: MyApp(),
    ),
  );
}









class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   final AuthService _authService = AuthService();

  // @override
  // void initState() {
  //   super.initState();
  //   // Utilisez Future.delayed pour rediriger automatiquement après un certain délai
  //   Future.delayed(const Duration(seconds: 5), () {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => const Bienvenu2(),
  //     ));
  //   });
  // }


  @override
  void initState() {
    super.initState();

    // Utilize Future.delayed to redirect automatically after a certain delay
    Future.delayed(const Duration(seconds: 5), () {
      if (_authService.currentUser != null) {
        // User is already signed in, navigate to the home page
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const EventScreen(),
        ));
      } else {
        // User is not signed in, show the login page
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Bienvenu1(),
        ));
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Bienvenu1()
    );

  }
}






// if (_authService.currentUser != null) {
//       // User is already signed in, navigate to the home page
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Home Page'),
//         ),
//         body: Center(
//           child: Text('Welcome, ${_authService.currentUser!.displayName}!'),
//         ),
//       );
//     } else {
//       // User is not signed in, show the login page
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Login Page'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               // Sign in with Google
//               await _authService.signInWithGoogle();
//             },
//             child: Text('Sign in with Google'),
//           ),
//         ),
//       );
//     }
//   }
// }