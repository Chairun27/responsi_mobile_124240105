import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/login_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Hive untuk database lokal (library)
  await Hive.initFlutter();
  // Membuka Box Hive dengan nama 'library'
  await Hive.openBox('library');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan GetMaterialApp agar GetX (Routing & State) berfungsi
    return GetMaterialApp(
      title: 'Hydra Games', 
      debugShowCheckedModeBanner: false,
      
      // Dark Mode 
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue, 
        scaffoldBackgroundColor: const Color(0xFF121212), 
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blue,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme( 
          backgroundColor: Colors.black,
          foregroundColor: Colors.white, 
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ), 
        ),
      ),
      
      home: const LoginPage(),
    );
  }
}