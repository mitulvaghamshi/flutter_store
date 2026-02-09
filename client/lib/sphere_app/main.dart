import 'package:flutter/material.dart';
import 'package:flutter_store/sphere_app/app.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(context) =>
      const MaterialApp(title: 'Flutter Sphere', home: SphereApp());
}
