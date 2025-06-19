import 'package:flutter/material.dart';
import 'package:wheather_app/weather_screen.dart';

class StartScreen extends StatefulWidget {

  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with TickerProviderStateMixin {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const WeatherScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 120,horizontal: 100),
        decoration:  const BoxDecoration(
          gradient: LinearGradient(colors:[ Color.fromARGB(255, 21, 3, 141),Color.fromARGB(255, 6, 205, 209)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft)
          
        ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network("https://cdn.jim-nielsen.com/ios/512/weather-2021-12-07.png?rf=1024",)),
            const SizedBox(height: 20,),
            const Text("Weather App",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
        ],
      ),
      ),
    );
  }
}