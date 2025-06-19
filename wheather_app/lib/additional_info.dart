import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget{

  final IconData icon;
  final String text;
  final String val;

  const AdditionalInfo({super.key,
  required this.icon,
  required this.text,
  required this.val});

  @override
  Widget build(BuildContext context) {
    return Column(
                  children: [
                    Icon(icon,
                    size: 32,),
                    const SizedBox(height: 10,),
                    Text(text,
                    style: const TextStyle(fontSize: 18),),
                    const SizedBox(height: 10,),
                    Text(val,
                    style: const TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold),)
                  ],
                );
  }
}