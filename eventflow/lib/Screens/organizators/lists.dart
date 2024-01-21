

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListsOrganizators extends StatefulWidget {
  const ListsOrganizators({ Key? key }) : super(key: key);

  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<ListsOrganizators> {


  final CollectionReference _organizators = FirebaseFirestore.instance.collection("organisateurs");


  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();


  TextEditingController birthDateController = TextEditingController();




/*
await _organizators.add({'birthDate':birthDate,"firstName":firstName,"lastName":lastName});  create a new instance
await _organizators.update({'birthDate':birthDate,"firstName":firstName,"lastName":lastName}); update an existing instance
await _organizators.doc(organizatorId).delete(); delete the instance
 */

Future<void> _create([DocumentSnapshot? documentSnapshot]) async {

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: birthDateController,
                  decoration: const InputDecoration(labelText: 'birthDate'),
                ),
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'firstName'),
                ),
                TextField(
                  // keyboardType:
                  // const TextInputType.numberWithOptions(decimal: true),
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'lastName',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String firstName = firstNameController.text;
                    final String lastName = lastNameController.text;
                    final String birthDate = birthDateController.text;
                    
                    if (lastName != null) {
                        await _organizators.add({"firstName": firstName, "lastName": lastName, "birthDate": birthDate});

                      firstNameController.text = '';
                      lastNameController.text = '';
                      birthDateController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );

        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(
        stream: _organizators.snapshots(),  // build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context,index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['lastName']),
                    subtitle: Text(documentSnapshot['firstName'] + ' '+ "BirthDate: "+ documentSnapshot['birthDate']),
                  ),
                  );
              },
              ); //Listview builder
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _create(),
        child: Icon(Icons.add),
        ),
    );
  }
}