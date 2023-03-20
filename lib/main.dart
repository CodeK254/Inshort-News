import 'package:flutter/material.dart';
import 'package:news/pages/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context) => const HomeScreen(),
      },
    )
  );
}