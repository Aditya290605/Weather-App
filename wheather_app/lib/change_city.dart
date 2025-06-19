import 'package:flutter/material.dart';
import 'package:wheather_app/secrets.dart';


class ChangeCity extends StatefulWidget {
  final TextEditingController textController;
  const ChangeCity({super.key,
  required this.textController});

  @override
  State<ChangeCity> createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            
          ),
          child: Column(
            children: [
              const Text("Enter the city name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              ),

              const SizedBox(height: 20,),
        
              TextField(
                
                controller: widget.textController,
                style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusColor: Colors.black
                ),
              ),

              const SizedBox(height: 20,),
        
              ElevatedButton(onPressed: (){
               setState(() {
                 cityName = widget.textController.text;
                Navigator.of(context).pop();
               });
              }, 
              child: const Text("done",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              ))
            ],
          ),
        
        ),
      ),
    );
  }
}