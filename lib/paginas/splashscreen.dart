import 'dart:async';
import 'package:avesdgobd/menus/inicio.dart';
import 'package:avesdgobd/paginas/googleauth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
      return _SplashScreenState();
  }
}

class _SplashScreenState extends State{
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),(){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context){
            return Inicio();//GoogleAuth();//Inicio();
          }
        ));
        }
    );
  }
    @override
    Widget build(BuildContext context) {
          return Scaffold(
                      body: Center(
                        child: Image.asset('imagenes/logo.jpg'),
                      ),
          );
    }
}