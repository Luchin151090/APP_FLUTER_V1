import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screen/counter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
class Principal extends StatelessWidget{

  //CONSTRUCTOR
  const Principal({super.key});

  @override
  Widget build(BuildContext context){
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Counter(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    });


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 137, 132),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             const SizedBox(height: 90,),
             const Text('Plant-Blue v1.0',style:TextStyle(color:Colors.white,fontWeight: FontWeight.w100,fontSize: 40)),
             const  SizedBox(height: 50,),

             Image.asset('lib/assets/plantita_v1.png',height: 150.0),
             const SizedBox(height: 50,),
             Text('Sistema de Riego Automatizado',style: (TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.w200)),),
             const SizedBox(height: 100,),
             Image.asset('lib/assets/salle.png',height: 100,),
             const SizedBox(height: 5,),

             Text('By Luis A. Gonzáles Usca',style:TextStyle(fontSize:15,color: Color.fromARGB(255, 252, 251, 253)))

            ]

        ),
      ),
    
    );
  }
}