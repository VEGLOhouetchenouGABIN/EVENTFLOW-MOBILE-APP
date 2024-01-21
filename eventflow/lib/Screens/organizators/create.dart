


import 'package:eventflow/Screens/organizators/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({ Key? key }) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Center(
                    child: Text("Créer un profil utilisateur"),
                  )
                ],
              ),
              Form(
                key: _formkey,
                child: Column(children: [
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text("Prénom(s)"),
                    // icon: Icon(Icons.email),
                    hintText: "Votre prénom(s)"
                  ),
                ),
                TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Votre nom",
                    label: Text("Nom"),
                    // icon: Icon(Icons.password,
                    // )
                  ),

                ),
               
              ],
              )),


               
               ElevatedButton(
                  onPressed: ()async{
                    if (_formkey.currentState!.validate()){
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _firstNameController.text, password: _lastNameController.text).then((value){
                        _lastNameController.text="";
                        _firstNameController.text = "";
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                      }).onError((error, stackTrace){
                        _firstNameController.text="";
                        _lastNameController.text = "";
                        print("Error ${error.toString()}");
                      });
                    }
                  }, 
                  child: Text("Créer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                  )
            
            ],
            
          ),
        ),
      ),
    );
  }
}