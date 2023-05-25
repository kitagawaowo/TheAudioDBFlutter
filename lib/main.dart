import 'package:flutter/material.dart';
import 'package:music_flutter/ui/home.dart';
void main() {
  runApp(const MyApp());
}
// alt + shift + f
//https://theaudiodb.com/api/v1/json/523532/track.php?m=2109889
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppSuperZound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

