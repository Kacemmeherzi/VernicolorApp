import 'package:flutter/material.dart';
import 'package:vernicolorapp/services/AuthService.dart';
import 'package:vernicolorapp/views/CustomerListPage.dart';
import 'package:vernicolorapp/views/HomePage.dart';
import 'package:vernicolorapp/views/LoginView.dart';
import 'package:vernicolorapp/views/ProductListPage.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
     final AuthService authService = AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home:  Loginview(authService: authService),
       initialRoute: '/',
      routes: {
        '/': (context) => Loginview(authService: AuthService()),
        '/home': (context) =>  HomePage(),
        '/products' : (context) => ProductListPage(),
        '/customers' : (context) => CustomerListPage()
      },

    );
  }
}


