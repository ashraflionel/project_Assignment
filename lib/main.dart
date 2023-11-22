import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/homepage.dart';
import 'package:flutter_application_1/Services/product_service.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider<ProductListAPIProvider>(
          create: (_) => ProductListAPIProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "ProductApp()",
        home: HomePage(),
      ),
    );
  }
}