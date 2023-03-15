import 'package:flutter/material.dart';
import 'package:news_app_flutter/ui/di/di.dart';
import 'package:news_app_flutter/ui/main/main_page.dart';
import 'package:news_app_flutter/ui/main/main_provider.dart';
import 'package:provider/provider.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: ChangeNotifierProvider(create: (context) => MainProvider(),child: const MainPage(),),
    );
  }
}
