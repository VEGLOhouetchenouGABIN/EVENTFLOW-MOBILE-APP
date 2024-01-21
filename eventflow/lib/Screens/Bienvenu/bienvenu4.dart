import 'package:flutter/material.dart';
import 'package:eventflow/controller/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:eventflow/Screens/deodat/screens/home_page.dart';
import 'package:eventflow/Screens/Bienvenu/goToListEvents.dart';




class Bienvenu4 extends StatefulWidget {
  const Bienvenu4({ Key? key }) : super(key: key);

  @override
  _Bienvenu4State createState() => _Bienvenu4State();
}

class _Bienvenu4State extends State<Bienvenu4> {
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Container(

                      child: Image.asset("assets/Festival 1.png", width: screenWidth,height: 500, fit: BoxFit.cover),
                    ),
                    Container(
                      child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("EVENTFLOW",style: TextStyle(color: Colors.yellow, fontSize: 35,fontWeight: FontWeight.bold),),
                            SizedBox(height: 30,),
                            Text("Bienvenue sur EventFlow", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 30,),
                            ElevatedButton.icon(
                              style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(
                                  color: Colors.yellow, // Specify the border color
                                  width: 2.0, // Specify the border width
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black, // Specify the background color
                              ),
                            ),
                                onPressed:() {
                                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                  provider.googleLogin();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=> GoToListEvents())
                                  );
                                },

                                icon: FaIcon(FontAwesomeIcons.google),
                                label: Text("Connexion avec google", style: TextStyle(color: Colors.white, fontSize: 18)),
                            ),
                            SizedBox(height: 20,),
                          ]),

                    )
                  ],
                ),
              ),
            )
          )
      ),

    );
  }
}