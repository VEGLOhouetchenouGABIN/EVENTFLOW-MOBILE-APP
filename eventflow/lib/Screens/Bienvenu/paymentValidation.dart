import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventflow/Model/event.dart';
import 'package:eventflow/Screens/Bienvenu/passageAuPayement.dart';
// import 'package:eventflow/Screens/Bienvenu/paymentWithKKIAPAY.dart';
import 'package:flutter/material.dart';
// import 'package:eventflow/Screens/deodat/screens/events.dart';
//import 'package:event_flow/widgets/default_button.dart';
import 'package:eventflow/Screens/deodat/screens/ticket_qr.dart';

class PaymentValidation extends StatefulWidget {
  final Event event;
  const PaymentValidation({super.key, required this.event});

  @override
  _PaymentValidationState createState() => _PaymentValidationState();
}

class _PaymentValidationState extends State<PaymentValidation> {
  int numberOfTickets = 1;
  late int totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount = (widget.event.price * numberOfTickets) as int;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252323),
      appBar: AppBar(
        title: const Text(
          'Détails de l\'événement',
          style:
              TextStyle(color: Color(0xFF252323), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.event.imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: const Color(0xFFFFFF40),
                          child: Text(
                            '${widget.event.price} XOF',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF252323),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFFF40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: const Color(0xFFFFFF40),
                      ),
                      const SizedBox(width: 1),
                      Text(
                        widget.event.location,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.event.date,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.event.participants} Participants',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        '${widget.event.time} heures',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nombre de tickets",
                    style:
                        TextStyle(fontSize: 20, color: const Color(0xFFFFFF40)),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: Colors.white,
                        onPressed: () {
                          if (numberOfTickets > 1) {
                            setState(() {
                              numberOfTickets--;
                              totalAmount =
                                  (widget.event.price * numberOfTickets) as int;
                            });
                          }
                        },
                      ),
                      Text(
                        numberOfTickets.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFF40),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            numberOfTickets++;
                            totalAmount = (widget.event.price * numberOfTickets) as int;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Material(
                color: const Color(0xFFFFFF40),
                borderRadius: BorderRadius.circular(10.0),
                child: Center(
                  child: Text(
                    'TOTAL - $totalAmount XOF',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: const Color(0xFF252323),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
                  SizedBox(
              width: double.infinity,
              child: Material(
                color: const Color(0xFFFFFF40),
                child: MaterialButton(
                  child: const Text(
                    'Valider paiement',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF252323),
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PassageAuPayement(),
                      ),
                    );
                  },
                ),
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: Material(
            //     color: const Color(0xFFFFFF40),
            //     child: MaterialButton(
            //       child: const Text(
            //         'Valider paiement',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           color: Color(0xFF252323),
            //           fontSize: 18,
            //         ),
            //       ),
            //       onPressed: () {
            //         // Navigator.push(
            //         //   context,
            //         //   MaterialPageRoute(
            //         //     builder: (context) => TicketQRPage(
            //         //       event: widget.event,
            //         //       eventTitle: widget.event.name,
            //         //     ),
            //         //   ),
            //         // );
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => KkiapaySample(),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';
// import 'package:kkiapay_flutter_sdk/utils/config.dart';
// import "package:eventflow/Screens/Bienvenu/paymentSuccess.dart";

// class PaymentValidation extends StatefulWidget {
//   final Event event;
//   const PaymentValidation({super.key, required this.event});

//   @override
//   _PaymentValidationState createState() => _PaymentValidationState();
// }

// class _PaymentValidationState extends State<PaymentValidation> {
//   int numberOfTickets = 1;
//   late int totalAmount;

//   @override
//   void initState() {
//     super.initState();
//     totalAmount = (widget.event.price * numberOfTickets) as int;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ... (le reste de votre code reste inchangé)
//       SizedBox(
//         width: double.infinity,
//         child: Material(
//           color: const Color(0xFFFFFF40),
//           child: MaterialButton(
//             child: const Text(
//               'Valider paiement',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Color(0xFF252323),
//                 fontSize: 18,
//               ),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => KkiapaySample(kkiapay: kkiapay),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//       // ... (le reste de votre code reste inchangé)
//     );
//   }
// }
