

import 'package:flutter/material.dart';

class AdminAccount extends StatefulWidget {
  const AdminAccount({ Key? key }) : super(key: key);

  @override
  _AdminAccountState createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("EVENTFLOW",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.blue),),
      ),
    );
  }
}

