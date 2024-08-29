import 'package:demo/src/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        expansionTileTheme: const ExpansionTileThemeData(
          iconColor: Colors.orange,
          textColor: Colors.orange,
          collapsedTextColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}
