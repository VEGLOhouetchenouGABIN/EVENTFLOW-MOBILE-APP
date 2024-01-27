#Page d'un Organisateur connecté

import 'package:flutter/material.dart';
import 'package:admin_base/OrgEvent/CreateEvent.dart';

class OrgPage extends StatefulWidget {
  /*final String lastname;
  final String firstname;*/
  OrgPage({/*required this.lastname, required this.firstname,*/ super.key});

  @override
  State<OrgPage> createState() => _OrgPageState();
}

class _OrgPageState extends State<OrgPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
              child: Column(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 70.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20.0),
                          children: [
                        TextSpan(
                            //text: "${widget.firstname} ${widget.lastname}"//
                            ),
                      ]))
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateEvent()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.yellow), // Couleur du bouton
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black), // Couleur du texte
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ), // Espacement interne
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Bordure arrondie
                          ),
                        ),
                      ),
                      child: Column(children: [
                        Icon(Icons.add),
                        Text("Créer un événement"),
                      ]),
                    ),
                    SizedBox(
                      width: 60.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListEvent()))*/
                          ;
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.yellow), // Couleur du bouton
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.black), // Couleur du texte
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ), // Espacement interne
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Bordure arrondie
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.event,
                            ),
                            Text("Mes événements"),
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
