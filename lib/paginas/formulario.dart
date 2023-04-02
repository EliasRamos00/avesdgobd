import 'dart:ffi';

import 'package:avesdgobd/clases/datos.dart';
import 'package:avesdgobd/menus/inicio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class Formulario extends StatefulWidget {
  final String id;
  final String numcontrol;
  final String nombrecom;
  final String nombrecien;
  final String nombrecdr;
  final String foto;

      const Formulario (this.id, this.numcontrol,this.nombrecom,this.nombrecien,this.nombrecdr,this.foto);

  @override
  State<StatefulWidget> createState() {
    return MiFormulario();

  }
}

class MiFormulario extends State<Formulario> {
  final nomComun = TextEditingController();
  final nomCient = TextEditingController();
  final nomCreador = TextEditingController();

  Future<void> guardarDatos(String id,String nomComun, String nomCient, String nomCreador, String foto) async {
    if(id.isNotEmpty){

      final firestoreInstance = FirebaseFirestore.instance;
      final userDoc = firestoreInstance.collection('avesdgo').doc(id);
      userDoc.update({
        'nombrecom': nomComun,
        'nombrecien': nomCient,
        'nombrecdr': nomCreador,
      });

    }else{
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
  }

  @override
  Widget build(BuildContext context) {
    String textButton = "Registrar";
    if(widget.id.length != 0){
      textButton = "Editar";
    }

    Datos? dat = Datos(widget.id,widget.numcontrol, widget.nombrecom, widget.nombrecien, widget.nombrecdr,widget.foto);
    nomComun.text = widget.nombrecom;
    nomCient.text = widget.nombrecien;
    nomCreador.text = widget.nombrecdr;
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
                    dat!.id = widget.id;
                    dat!.nombrecom = nomComun.text;
                    dat!.nombrecien = nomCient.text;
                    dat!.nombrecdr = nomCreador.text;
                    dat!.foto = Datos.downloadURL;
                    guardarDatos(dat!.id,dat!.nombrecom, dat!.nombrecien,
                        dat!.nombrecdr, dat!.foto);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Inicio()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Text(textButton))
            ],
          ),
        ),
      ),
    );
  }
}