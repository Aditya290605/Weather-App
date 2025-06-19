import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/change_city.dart';
import 'package:wheather_app/secrets.dart';
import 'hourly_forcaste.dart';
import 'additional_info.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget{

  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  Future<Map<String,dynamic>> getCurrentWeather() async{
    try{
    final res = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$watherApiKey")
      
    );
    final data = jsonDecode(res.body);
    
    if (data['cod']!='200'){
      throw "something unexpected happend !";
    }
    return data;

    }catch(e){
      throw e.toString();
    }
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getCurrentWeather(),
      builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if(snapshot.hasError == true){
         return Center(
           child: Text(snapshot.error.toString(),
           style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
           ),),
         );
        }
        final TextEditingController text = TextEditingController();

        final data = snapshot.data!;
        final currentTemp = (((data['list'][0]['main']['temp'])-273.15).toString()).substring(0,2);
        final currentSky = data['list'][0]['weather'][0]['main'];

        final windSpeed = data['list'][0]['wind']['speed'];
        final pressure = data['list'][0]['main']['pressure'];
        final humidity = data['list'][0]['main']['humidity'];
        

        return Scaffold(
        
        appBar: AppBar(
          
              backgroundColor: Colors.amber,
              title: const Text("Weather App",
              
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),),
              centerTitle: true,
              actions:[
                IconButton(onPressed: (){
                  setState(() {
                    
                  });
                },
                icon: const Icon(Icons.refresh)),

                 IconButton(onPressed: () async{
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ChangeCity(
                      textController: text)),
                  )
                  ;
                  setState(() {
                    
                  });
                },
                icon: const Icon(Icons.add))
              ],
        ),
        backgroundColor: const Color.fromARGB(255, 99, 154, 209),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 99, 154, 209),
          ),
          child: Padding(
            
            padding: const EdgeInsets.all(16.0),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                SizedBox(
                  
                  width: double.infinity,
                  child: Container(
                  
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient:const  LinearGradient(colors: [ Color.fromARGB(255, 229, 242, 255),Color.fromARGB(170, 1, 68, 183)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)
                  ),
            
                    child: ClipRRect(
                      
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                      
                      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                        child: Padding(
                          
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(cityName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),),
            
                              const SizedBox(height: 10,),
                            
                              Text("$currentTemp °C",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold
                              ),),
                              const SizedBox(height: 20,),
                          
                             Icon(currentSky == 'Clouds'|| currentSky == 'Rain'?
                              Icons.cloud : Icons.sunny ,size: 64,),
                          
                              const SizedBox(height: 20,),
                          
                              Text("$currentSky",
                              style: const TextStyle(
                                fontSize: 22
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(height: 20,),
            
                const Text("Weather Forecast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
                  
                const SizedBox(height: 20,),
                  
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context,index){
                      final currentSk = data['list'][index+1]['weather'][0]['main'];
                      final date = DateTime.parse(data['list'][index+1]['dt_txt']);
                      return HourlyForcaste(
                        icon: currentSk == 'Clouds' || currentSk == 'Rainy'?
                        Icons.cloud : Icons.sunny,
                         time: DateFormat.j().format(date),
                          val: "${(data['list'][index+1]['main']['temp']-273.15).toString().substring(0,2)} °C"
                          );
                    }),
                ),
                  
                const SizedBox(height: 20,),
                const Text("Additional Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
                  
                const SizedBox(height: 16,),
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(icon: Icons.water_drop,
                    text:"Humidity",
                    val:"$humidity"),
                  
                    AdditionalInfo(icon: Icons.air,
                    text:"Wind Speed",
                    val:"$windSpeed"),
                  
                    AdditionalInfo(icon: Icons.beach_access,
                    text:"Pressure",
                    val: "$pressure")
                    
                  ],
                    )
                  ],
                )
            
              ,
            ),
        ),
        );
      },
    );
    
  }
}

