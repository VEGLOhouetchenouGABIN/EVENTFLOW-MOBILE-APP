// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventflow/Screens/deodat/screens/event_detail.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:eventflow/Screens/deodat/screens/notifications.dart';
// import 'package:eventflow/widgets/deodat/widgets/notification_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:eventflow/Model/event.dart';


// class EventScreen extends StatefulWidget {
//   const EventScreen({Key? key}) : super(key: key);

//   @override
//   State<EventScreen> createState() => _EventScreenState();
// }

// class _EventScreenState extends State<EventScreen> {

//   // events fetching from firebase store
//     // final CollectionReference _events = FirebaseFirestore.instance.collection("events");

// // Définissez les catégories disponibles
//   final List<String> categories = [
//     'Toutes',
//     'Sport',
//     'Flemme',
//     'Festival',
//     'Chills',
//     'Concert'
//   ];
//   String selectedCategory = 'Toutes'; // Catégorie sélectionnée par défaut

//   TextEditingController searchController = TextEditingController();
//   List<Event> filteredEvents = events;
//   late Timer _debounce;

//   @override
//   void initState() {
//     super.initState();
//     _debounce =
//         Timer(const Duration(milliseconds: 500), () {}); // Initialize _debounce
//     searchController.addListener(() {
//       if (_debounce.isActive) _debounce.cancel();
//       _debounce = Timer(const Duration(milliseconds: 500), () {
//         updateSearchResults();
//       });
//     });
//   }

//   void updateSearchResults() {
//     setState(() {
//       filteredEvents = events
//           .where((event) =>
//               (selectedCategory == 'Toutes' ||
//                   event.eventType == selectedCategory) &&
//               event.name
//                   .toLowerCase()
//                   .contains(searchController.text.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF252323), // Couleur de fond noire
//       appBar: AppBar(
//         title: const Text("Liste des Événements"),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.notifications,
//                   color:  Color(0xFF252323),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const PageNotification()),
//                   );
//                   Provider.of<NotificationProvider>(context, listen: false)
//                       .marquerToutesCommeLues();
//                 },
//               ),
//               if (Provider.of<NotificationProvider>(context)
//                       .nombreNotificationsNonLues >
//                   0)
//                 Positioned(
//                   right: 0,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.red,
//                     radius: 10,
//                     child: Text(
//                       Provider.of<NotificationProvider>(context)
//                           .nombreNotificationsNonLues
//                           .toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "EventFlow",
//                     style: TextStyle(
//                       color: Color(0xFFFFFF40), // Couleur du texte
//                       fontSize: 25.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 2),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 32),
//                   SearchBar(
//                     leading: const Icon(Icons.search),
//                     hintText: "Rechercher un évenement",
//                     backgroundColor: MaterialStateProperty.all(Colors.white),
//                     controller: searchController,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Row(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     "Catégorie",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10.0),
//                 DropdownButton<String>(
//                   value: selectedCategory,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   iconSize: 24,
//                   elevation: 16,
//                   style: const TextStyle(color: Color(0xFFFFFF40)),
//                   dropdownColor: const Color(0xFF252323),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedCategory = newValue!;
//                       updateSearchResults();
//                     });
//                   },
//                   items:
//                       categories.map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10.0),
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Recommandé",
//                     style: TextStyle(
//                       color: Color(0xFFFFFF40), // Couleur du texte
//                       fontSize: 22.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
//               child: Container(
//                 height: 200.0,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(35.0),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0, 2),
//                       blurRadius: 20.0,
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20.0),
//                           child: Image.asset(
//                             "assets/images/event2.png",
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       const Text(
//                         "Événement à la Une",
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF252323),
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       const Text(
//                         "Nom de l'événement",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color(0xFF252323),
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       const Row(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             color: Colors.black26,
//                             size: 18.0,
//                           ),
//                           SizedBox(width: 4.0),
//                           Text(
//                             "Lieu de l'événement",
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               color: Colors.black26,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Événements",
//                     style: TextStyle(
//                       color: Color(0xFFFFFF40),
//                       fontSize: 22.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: filteredEvents.length,
//               itemBuilder: (context, index) {
//                 return EventItem(
//                   event: filteredEvents[index],
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             EventDetailsPage(event: filteredEvents[index]),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     _debounce.cancel();
//     super.dispose();
//   }
// }

// class EventItem extends StatelessWidget {
//   final Event event;
//   final VoidCallback onTap;

//   const EventItem({required this.event, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
//         child: Container(
//           height: 100.0,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: const Color(0xFF252323),
//             borderRadius: BorderRadius.circular(35.0),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black,
//                 offset: Offset(0, 2),
//                 blurRadius: 5.0,
//               )
//             ],
//           ),
//           child: Stack(
//             alignment: Alignment.centerLeft,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(5.0),
//                     width: 100.0,
//                     height: 94.0,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30.0),
//                         bottomLeft: Radius.circular(30.0),
//                       ),
//                       color: Color(0xFF252323),
//                     ),
//                     child: ClipRRect(
//                       //padding: const EdgeInsets.only(top: 10.0),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30.0),
//                         bottomLeft: Radius.circular(30.0),
//                       ),
//                       child: Image(
//                         height: 94.0,
//                         width: 100.0,
//                         image: AssetImage(
//                             event.imageUrl), // Utilisez votre imageUrl
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 140.0,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 4.0, top: 15.0),
//                           child: Text(
//                             event.name,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0,
//                               color: Color(0xFFFFFF40),
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 width: 140.0,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 4.0),
//                                   child: Text(
//                                     event.date,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 13.0,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 width: 140.0,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 4.0),
//                                   child: Text(
//                                     event.eventType,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12.0,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 40.0,
//                                 width: 40.0,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFFFFF40),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 child: const Center(
//                                   child: Icon(
//                                     Icons.arrow_forward,
//                                     color: Color(0xFF252323),
//                                     size: 20.0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     // return GestureDetector(
//     //   onTap: onTap,
//     //   child: ListTile(
//     //     leading: Image.asset(event.imageUrl),
//     //     title: Text(
//     //       event.name,
//     //       style: const TextStyle(color: Colors.white),
//     //     ),
//     //     subtitle: Column(
//     //       crossAxisAlignment: CrossAxisAlignment.start,
//     //       children: <Widget>[
//     //         Text(event.eventType, style: const TextStyle(color: Colors.white)),
//     //         Text(event.date, style: const TextStyle(color: Colors.white)),
//     //       ],
//     //     ),
//     //     trailing: const Icon(Icons.arrow_forward),
//     //   ),
//     // );
//   }
// }

// // class Event {
// //   final String id;
// //   final String name;
// //   final String eventType;
// //   final String imageUrl;
// //   final String date;
// //   final String location;
// //   final String time;
// //   final int participants;
// //   final String about;
// //   final int price;

// //   Event(
// //       {required this.id,
// //       required this.name,
// //       required this.eventType,
// //       required this.imageUrl,
// //       required this.date,
// //       required this.location,
// //       required this.time,
// //       required this.participants,
// //       required this.about,
// //       required this.price});
// // }

// // final List<Event> events = <Event>[
// //   Event(
// //       id: "festichill2023",
// //       name: "FestiChill",
// //       eventType: "Concert",
// //       imageUrl: "assets/images/event2.png",
// //       date: "04 Février 2024",
// //       location: "Place de l'Amazone",
// //       time: "18",
// //       participants: 10000,
// //       about:
// //           "NumPy provides useful mathematical function, which are called Universal Functions. These functions operate element-wise on an array, producing another array as output.",
// //       price: 1500),
// //   Event(
// //       id: "noirr001",
// //       name: "Noirrr",
// //       eventType: "Flemme",
// //       imageUrl: "assets/images/event2.png",
// //       date: "26 Décembre 2023",
// //       location: "Online",
// //       time: "23",
// //       participants: 500,
// //       about:
// //           "NumPy provides useful mathematical function, which are called Universal Functions. These functions operate element-wise on an array, producing another array as output.",
// //       price: 2000),
// //   Event(
// //       id: "mevtr07",
// //       name: "MEVTR",
// //       eventType: "RAS RAS",
// //       imageUrl: "assets/images/event2.png",
// //       date: "2 Février 2024",
// //       location: "Hôtel 2 Février, Lome",
// //       time: "18",
// //       participants: 1470,
// //       about:
// //           "NumPy provides useful mathematical function, which are called Universal Functions. These functions operate element-wise on an array, producing another array as output.",
// //       price: 3500),
// //   Event(
// //       id: "nowwayhome78",
// //       name: "No way home",
// //       eventType: "Concert",
// //       imageUrl: "assets/images/event2.png",
// //       date: "18 Avril 2024",
// //       location: "Sèmè City",
// //       time: "20",
// //       participants: 1452,
// //       about:
// //           "NumPy provides useful mathematical function, which are called Universal Functions. These functions operate element-wise on an array, producing another array as output.",
// //       price: 5000),
// //   Event(
// //       id: "farfromhome23",
// //       name: "Far from home",
// //       eventType: "Concert",
// //       imageUrl: "assets/images/event2.png",
// //       date: "31 Décembre 2023",
// //       location: "Palais des Congrès",
// //       time: "17",
// //       participants: 2000,
// //       about:
// //           "NumPy provides useful mathematical function, which are called Universal Functions. These functions operate element-wise on an array, producing another array as output.",
// //       price: 2500),
// // ];





// // // Event(
// // //       id: "farfromhome23",
// // //       name: "Far from home",
// // //       eventType: "Concert",
// // //       imageUrl: "assets/images/event2.png",
// // //       date: "31 Décembre 2023",
// // //       location: "Palais des Congrès",
// // //       time: "17",
// // //       participants: 2000,
// // //       about:
// // //           "NumPy provides useful mathematical function, which are called Universal Functions. These functions operate element-wise on an array, producing another array as output.",
// // //       price: 2500),