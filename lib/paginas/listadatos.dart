import 'package:avesdgobd/paginas/formulario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Aves Durango'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('avesdgo').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>; //nuevo paquete
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onLongPress: () async {
                            String elemento = await getDocumentId(data['nombrecien']);
                            bool confirmado =
                                await mostrarDialogoDeConfirmacion(context,
                                    '¿Qué desea hacer?');
                            if (confirmado) {
                              final ref = FirebaseFirestore.instance.collection('avesdgo').doc(elemento);
                              await ref.delete();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.check_circle, color: Colors.green, size: 50),
                                        SizedBox(height: 16),
                                        Text('Registro Eliminado', style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          // Cerrar el diálogo
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                            } else {
                              String elemento = await getDocumentId(data['nombrecien']);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context){

                                    return Formulario(elemento,data['nombrecom'], data['nombrecom'], data['nombrecien'], data['nombrecdr'],data['foto'] );//GoogleAuth();//Inicio();
                                  }
                              ));
                            }
                          },
                          child: Column(
                            children: [
                              Image.network(data['foto']),
                              ListTile(
                                title:
                                    Text("Nombre común: " + data['nombrecom']),
                                //leading: Icon(Icons.favorite,color: Colors.red,),
                                subtitle: Text(
                                  "Nombre científico: " +
                                      data['nombrecien'] +
                                      "\n" +
                                      "Fotografiada por: " +
                                      data['nombrecdr'],
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }));
  }

  Future<String> getDocumentId(String nombrecien) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('avesdgo')
        .where('nombrecien', isEqualTo: nombrecien)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    } else {
      return '';
    }
  }

  Future mostrarDialogoDeConfirmacion(BuildContext context, String mensaje) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Editar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
