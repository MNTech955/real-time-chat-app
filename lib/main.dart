import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/theme/light_mode.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async{
  
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_)=>ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
    
        
        
      
      home: AuthGate()
    );
  }
}


