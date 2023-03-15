import 'package:flutter/material.dart';

import '../clases/datos.dart';

class ListaDatos extends StatelessWidget {
  final List<Datos> lista;
  ListaDatos(this.lista);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Datos Aspirantes"),
        ),
        body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            final item = lista[index];
            return ListTile(
              title: Text(item.nombrecom),
              subtitle: Text(item.nombrecien),
              leading: Image(
                image: NetworkImage('https://picsum.photos/700/400'),
                fit: BoxFit.fitHeight,
              ),

            );
          },
        ));
  }
}
