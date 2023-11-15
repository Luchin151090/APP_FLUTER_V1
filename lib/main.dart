import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screen/counter.dart';
import 'package:flutter_application_1/presentation/screen/home.dart';

void main(){
  runApp(const Myapp());
}


class Myapp extends StatelessWidget{
  
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        useMaterial3: true
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => const Principal(),
        '/blue':(context) => const Counter(),
      },
      //home:const Counter()
      );
  }
}