// import 'package:eventflow/Screens/deodat/screens/scan.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:eventflow/Model/event.dart';
import 'package:eventflow/widgets/deodat/widgets/ticketcustom.dart';

class TicketQRPage extends StatefulWidget {
  final Event event;
  final String eventTitle;

  TicketQRPage({required this.event, required this.eventTitle});

  @override
  _TicketQRPageState createState() => _TicketQRPageState();
}

class _TicketQRPageState extends State<TicketQRPage> {
  String qrData = " "; // already generated qr code when the page opens
  final qrdataFeed = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize QR data with the unique ID of the event
    qrData = widget.event.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket QR Page"),
      ),
      body:SingleChildScrollView(child:
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: qrdataFeed,
              decoration: const InputDecoration(
                hintText: "Input your link or data",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (qrdataFeed.text.isEmpty) {
                  // A little validation for the text field
                  setState(() {
                    qrData = "";
                  });
                } else {
                  setState(() {
                    qrData = qrdataFeed.text;
                  });
                }
              },
              child: const Text(
                "Generate QR",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // QrImage(
            //   data: qrData,
            //   version: QrVersions.auto,
            //   size: 200.0,
            // ),
            Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    QrImageView(
                      //place where the QR Image will be shown
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Text(
                      "New QR Link Generator",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextField(
                      controller:
                          TextEditingController(text: qrData),
                      enabled: false, // Disable editing
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed: (){
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context)=>ScanScreen())
                      // );
                    }, child: Text("Scanner un code QR"))
                  ],
                ),
          ],
        ),
      ),)
    );
  }
}




