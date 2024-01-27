// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventflow/Screens/deodat/screens/event_detail.dart';
import 'package:eventflow/Screens/Bienvenu/eventDetail.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:eventflow/Screens/deodat/screens/notifications.dart';
import 'package:eventflow/widgets/deodat/widgets/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventflow/Model/event.dart';


class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}


class _EventScreenState extends State<EventScreen> {
  final CollectionReference _events = FirebaseFirestore.instance.collection("events");

  // Définissez les catégories disponibles
  final List<String> categories = [
    'Toutes',
    'Sport',
    'Flemme',
    'Festival',
    'Chills',
    'Concert'
  ];
  String selectedCategory = 'Toutes'; // Catégorie sélectionnée par défaut

  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> filteredEvents = [];
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    searchController.addListener(() {
      if (_debounce.isActive) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        updateSearchResults();
      });
    });
  }

  void updateSearchResults() {
    setState(() {
      filteredEvents = filteredEvents
          .where((event) =>
              event['name']
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... other Scaffold properties

      backgroundColor: const Color(0xFF252323), // Couleur de fond noire
      appBar: AppBar(
        title: const Text("Liste des Événements"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color:  Color(0xFF252323),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageNotification()),
                  );
                  Provider.of<NotificationProvider>(context, listen: false)
                      .marquerToutesCommeLues();
                },
              ),
              if (Provider.of<NotificationProvider>(context)
                      .nombreNotificationsNonLues >
                  0)
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      Provider.of<NotificationProvider>(context)
                          .nombreNotificationsNonLues
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),



      body: StreamBuilder(
        stream: _events.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            filteredEvents = streamSnapshot.data!.docs;

            return SingleChildScrollView(
              child: Column(
                children: [
                  // ... existing code for header and search bar




                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "EventFlow",
                            style: TextStyle(
                              color: Color(0xFFFFFF40), // Couleur du texte
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          SearchBar(
                            leading: const Icon(Icons.search),
                            hintText: "Rechercher un évenement",
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            controller: searchController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Catégorie",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        DropdownButton<String>(
                          value: selectedCategory,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Color(0xFFFFFF40)),
                          dropdownColor: const Color(0xFF252323),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue!;
                              updateSearchResults();
                            });
                          },
                          items:
                              categories.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),





                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Événements",
                          style: TextStyle(
                            color: Color(0xFFFFFF40),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      return EventItem(
                        event: filteredEvents[index],
                        onTap: () {
                          // Handle onTap
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context){
                               // EventDetailsPage(event: filteredEvents[index]),
                                Event event = extractEventFromDocumentSnapshot(filteredEvents[index]);
                                return EventDetailsPage(event: event);
                            }
                               
                          ),
                        );
                          
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  // ... existing code for dispose method
   @override
  void dispose() {
    searchController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  Event extractEventFromDocumentSnapshot(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Event(
      id: snapshot.id,
      name: data['name'],
      eventType: data['eventType'],
      imageUrl: data['imageUrl'],
      date: data['date'],
      location: data['location'],
      time: data['time'],
      participants: data['participants'],
      about: data['about'],
      price: data['price'],
    );
  }
}

class EventItem extends StatelessWidget {
  final DocumentSnapshot event;
  final VoidCallback onTap;

  const EventItem({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: Container(
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF252323),
            borderRadius: BorderRadius.circular(35.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 2),
                blurRadius: 5.0,
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: 100.0,
                    height: 94.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                      color: Color(0xFF252323),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                      child: Image.network(
                        event['imageUrl'], // Utilisez le champ 'imageUrl' du document Firebase
                        height: 94.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 15.0),
                          child: Text(
                            event['name'], // Utilisez le champ 'name' du document Firebase
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFFFFFF40),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // ... autres champs à afficher







                           Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 140.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    event["date"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                width: 140.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    event["eventType"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFF40),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF252323),
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),









                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
