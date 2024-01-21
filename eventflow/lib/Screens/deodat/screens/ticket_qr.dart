import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:event_flow/widgets/default_button.dart';
import 'package:eventflow/Screens/deodat/screens/events.dart';
import 'package:ticket_widget/ticket_widget.dart';
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
    // Initialiser les données QR avec l'ID unique de l'événement
    qrData = widget.event.id;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTicketWidget(
      event: widget.event,
      qrData: qrData,
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Billet d'événement"),
    //     backgroundColor: Colors.blue,
    //     actions: const <Widget>[],
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Center(
    //       child: Column(
    //         children: [
    //           TicketWidget(
    //             width: 250,
    //             height: 400,
    //             isCornerRounded: true,
    //             child: Stack(
    //               children: [
    //                 Positioned(
    //                   top: 0,
    //                   right: 20,
    //                   child: Container(
    //                     height: 50,
    //                     width: 28,
    //                     alignment: Alignment.center,
    //                     color: const Color(0xFFFFFF40),
    //                     child: Text(
    //                       '${widget.event.price}',
    //                       style: const TextStyle(
    //                         color: Color(0xFF252323),
    //                         fontSize: 10,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Column(
    //                   children: [
    //                      CircleAvatar(
    //                       backgroundColor: const Color(0xFFFFFF40),
    //                       radius: 60,
    //                       child: CircleAvatar(
    //                         backgroundColor: Colors.white,
    //                         radius: 55,
    //                         backgroundImage: AssetImage(widget.event.imageUrl),
    //                       ),
    //                     ),
    //                     Text(
    //                       widget.event.name,
    //                       style: const TextStyle(
    //                         color: Color(0xFFFFFF40),
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const Icon(Icons.location_on,
    //                             color: Color(0xFFFFFF40), size: 18),
    //                         Text(
    //                           widget.event.location,
    //                           style: const TextStyle(
    //                             color: Color(0xFF252323),
    //                           ),
    //                         ),
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.stretch,
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: <Widget>[
    //                             QrImageView(
    //                               //place where the QR Image will be shown
    //                               data: qrData,
    //                               version: QrVersions.auto,
    //                               size: 200,
    //                             ),
    //                             const SizedBox(
    //                               height: 40.0,
    //                             ),
    //                             const Text(
    //                               "New QR Link Generator",
    //                               style: TextStyle(fontSize: 20.0),
    //                             ),
    //                             TextField(
    //                               controller:
    //                                   TextEditingController(text: qrData),
    //                               enabled: false, // Disable editing
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}








            //TextField(
            //   controller: qrdataFeed,
            //   decoration: const InputDecoration(
            //     hintText: "Input your link or data",
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            //   child: DefaultButton(
            //     onPressed: () async {
            //       if (qrdataFeed.text.isEmpty) {
            //         //a little validation for the textfield
            //         setState(() {
            //           qrData = "";
            //         });
            //       } else {
            //         setState(() {
            //           qrData = qrdataFeed.text;
            //         });
            //       }
            //     },
            //     child: const Text(
            //       "Generate QR",
            //       style: TextStyle(
            //           color: Colors.blue, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // )