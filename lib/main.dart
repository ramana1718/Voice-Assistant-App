import 'package:voiceassistant/Services/auth_gate.dart';
import 'package:voiceassistant/Services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voiceassistant/components/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBJ8_iepzYbJCXJjWhaG9-2HucRgdsM-18',
      authDomain: 'chatapp-58cfe.firebaseapp.com',
      projectId: 'chatapp-58cfe',
      storageBucket:
          'https://console.firebase.google.com/u/0/project/chatapp-58cfe/storage/chatapp-58cfe.appspot.com/files',
      messagingSenderId: '36964825983',
      appId: '1:36964825983:android:70b6116737108f6a46384a',
    ),
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramana',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallete.whiteColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Pallete.whiteColor,
          )),
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
