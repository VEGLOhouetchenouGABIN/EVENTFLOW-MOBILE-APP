

//Page de création d'un événement 

// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'dart:typed_data';
import 'dart:io';
import 'package:eventflow/Model/createEvent.dart';
import 'package:eventflow/Utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final eventKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController eventTypeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  // TextEditingController _picked = TextEditingController();
  late TimeOfDay _timeChosen;


  // TextEditingController dateController = TextEditingController();

  Future<void> _selectDate()async{
  DateTime? _picked = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(),
    firstDate: DateTime(2024), 
    lastDate: DateTime(2200));

  if (_picked != null){
    setState(() {
      dateController.text = _picked.toString().split(" ")[0];
      // print(dateController);
    });
  }
}



  String? _validateRequired(String? value) {
    return (value == null || value == "") ? "Ce champ est obligatoire" : null;
  }

   int _selectedIndex=0;



  Uint8List? _imageUrl;

  void selectImage()async{
      Uint8List img = await pickImage(ImageSource.gallery);
      
      setState(() {
        _imageUrl = img;
      });
  }

  void _pickTime(){
    showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
      ).then((value) {
        setState(() {
          _timeChosen = value!;
          print(_timeChosen.format(context).toString());
          print(_timeChosen);
        });
      });
  }






  void _submitForm() async{

    

   
    if (eventKey.currentState!.validate()) {
      // Form is valid, process the data

      String name = nameController.text;
      String eventType = _value;
      String location = locationController.text;
      String time = _timeChosen.format(context).toString();
      String price = priceController.text;
      String about = aboutController.text;
      String participants = participantsController.text;
      String date = dateController.text;
      String country = countryController.text;
      // TimeOfDay time = _timeChosen;
    

    // print("Name: $name");
    // print("Location:  $location");
    // //  print("ImageUrl: $_imageUrl");
    // print("Date:  $date");
    //  print("About: $about");
    // print("Price:  $price");

    
    String resp  = await StoreEvent().saveData(name: name, eventType: eventType, file: _imageUrl!, date: date, location: location,time: time, participants: participants, about: about, price: price, country: country);

  print(resp);


    nameController.text="";
    eventTypeController.text="";
    locationController.text="";
    timeController.text="";
    priceController.text="";
    aboutController.text="";
    participantsController.text="";
    dateController.text="";
    countryController.text="";
    _imageUrl =null;

    
    }

    else{
      print("Please fill all fields above!");
    }
  }


// Value initialisation for event type 
var _value = null;


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Créer un événement"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(children: <Widget>[
                  Form(
                key: eventKey,
                child: Column(
                  children: [
                    
                     SizedBox(height: 22),
                     Text("Choisissez une image de votre choix qui illustre votre évènement"),
                     SizedBox(height: 12.0,),
                    Stack(
                      children: [
                        _imageUrl != null?
                        CircleAvatar(
                          radius: 74,
                          backgroundImage: MemoryImage(_imageUrl!),
                        ):
                        CircleAvatar(
                          radius: 74,
                          backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                            ),
                          ),
                          Positioned(
                            child: IconButton(
                              onPressed: selectImage, 
                            icon: Icon(Icons.add_a_photo
                            )),
                            bottom: -10,
                            left: 80,
                            )
                      ],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      // decoration: InputDecoration(labelText: "Nom ou denomination de l'évènement"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2)
                        ),
                        labelText: "Nom ou denomination de l'évènement"
                      ),
                      
                      validator: _validateRequired,
                    ),
                    const SizedBox(height: 18.0),


                    DropdownButtonFormField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2)
                        ),
                        labelText: "Choisissez une catégorie"
                      ),
                      value: _value,
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('Toutes'),
                          value: 'Toutes',
                          ),
                           DropdownMenuItem<String>(
                          child: Text('Sport'),
                          value: 'Sport',
                          ),
                           DropdownMenuItem<String>(
                          child: Text('Flemme',),
                          value: 'Flemme',
                          ),

                           DropdownMenuItem<String>(
                          child: Text('Festival'),
                          value: 'Festival',
                          ),
                          DropdownMenuItem<String>(
                          child: Text('Chills'),
                          value: 'Chills',
                          ),
                          DropdownMenuItem<String>(
                          child: Text('Concert'),
                          value: 'Concert',
                          ),
                      ], 
                      onChanged: (newvalue){
                        setState(() {
                          _value = newvalue;
                          print(_value);
                        });
                      }
                      ),
    
                    // TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   controller: eventTypeController,
                    //   decoration: InputDecoration(labelText: "Type de l'évènement"),
                    //   validator: _validateRequired,
                    // ),
                    const SizedBox(height: 18.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: "Date",
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          // borderRadius: BorderRadius.all(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)
                        )
                        ),
                      // validator: _validateRequired,
                      readOnly: true,
                      onTap: (){
                        _selectDate();
                      },
                    ),
                    const SizedBox(height: 18.0),
                     TextFormField(
                      keyboardType: TextInputType.text,
                      controller: locationController,
                      // decoration: InputDecoration(labelText: "Lieu ou Place"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2)
                        ),
                        labelText: "Lieu ou Place"
                      ),
                      validator: _validateRequired,
                    ),
                    
                    SizedBox(height: 18.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: countryController,
                      // decoration: InputDecoration(labelText: "Pays"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2)
                        ),
                        labelText: "Pays"
                      ),
                      validator: _validateRequired,
                    ),

                  //  SizedBox(width: 18.0),
                  //   TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: timeController,
                  //     decoration: InputDecoration(labelText: "L'heure"),
                  //     validator: _validateRequired,
                  //   ),

                    SizedBox(height: 18.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: participantsController,
                      // decoration: InputDecoration(labelText: "Participants"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2)
                        ),
                        labelText: "Participants"
                      ),
                      validator: _validateRequired,
                    ),

                    SizedBox(width: 18.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: aboutController,
                      // decoration: InputDecoration(labelText: "Un petit mot sur l'évènement"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2)
                        ),
                        labelText: "Un petit mot sur l'évènement"
                      ),
                      validator: _validateRequired,
                    ),

                    SizedBox(height: 18.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: priceController,
                      // decoration: InputDecoration(labelText: "Prix du ticket"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2)
                        ),
                        labelText: "Prix du ticket"
                      ),
                      validator: _validateRequired,
                    ),
                    SizedBox(height: 18.0),
                    
                  ],
                ),
              ),
              
                    //],
                    //),
                    SizedBox(height: 18.0),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Background color
                      onPrimary: Colors.white, // Text color
                      fixedSize: Size(200.0, 50.0), // Set height and width here
                    ),
                      onPressed: _pickTime, 
                      child: Text("Choisissez l'heure"),
                      
                      ),

                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () =>_submitForm(),
                      child: Text('Ajouter'),
                    ),
                    SizedBox(height: 20.0,)
                ]),)
            ),
          )
    ),
    );
  }



 
}



