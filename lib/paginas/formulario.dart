import 'package:avesdgobd/clases/datos.dart';
import 'package:avesdgobd/menus/inicio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MiFormulario();
  }
}

class MiFormulario extends State<Formulario> {
  final nomComun = TextEditingController();
  final nomCient = TextEditingController();
  final nomCreador = TextEditingController();

  Datos? dat = Datos("", "", "", "","");

  Future<void> guardarDatos(
      String nomComun, String nomCient, String nomCreador, String foto) async {
    Future.delayed(Duration(seconds: 7), () async {
      final datos = await FirebaseFirestore.instance.collection('avesdgo');
      return datos.add({
        'nombrecom': nomComun,
        'nombrecien': nomCient,
        'nombrecdr': nomCreador,
        'foto': foto,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos de la ave"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(10.0)),
              TextField(
                controller: nomComun,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nombre Comun'),
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              TextField(
                controller: nomCient,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Cientifico'),
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              TextField(
                controller: nomCreador,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nombre Creador'),
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              ElevatedButton(
                  onPressed: () {
                    dat!.nombrecom = nomComun.text;
                    dat!.nombrecien = nomCient.text;
                    dat!.nombrecdr = nomCreador.text;
                    dat!.foto = Datos.downloadURL;
                    guardarDatos(dat!.nombrecom, dat!.nombrecien,
                        dat!.nombrecdr, dat!.foto);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Inicio()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: const Text("Registrar"))
            ],
          ),
        ),
      ),
    );
  }
}
