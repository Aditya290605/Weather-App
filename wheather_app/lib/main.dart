import 'package:flutter/material.dart';
import 'package:wheather_app/start_screen.dart';


void main(){
    runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(
          useMaterial3:true
            ),
        debugShowCheckedModeBanner: false,
        home: const StartScreen(),
    );
  }
}