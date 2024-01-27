class Event {
  final String id;
  final String name;
  final String eventType;
  final String imageUrl;
  final String date;
  final String location;
  final String time;
  final String participants;
  final String about;
  final int price;

  Event({
    required this.id,
    required this.name,
    required this.eventType,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.time,
    required this.participants,
    required this.about,
    required this.price,
  });

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    return Event(
      id: documentId,
      name: data['name'] ?? '',
      eventType: data['eventType'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      date: data['date'] ?? '',
      location: data['location'] ?? '',
      time: data['time'] ?? '',
      participants: data['participants'] ?? '',
      about: data['about'] ?? '',
      price: data['price'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'eventType': eventType,
      'imageUrl': imageUrl,
      'date': date,
      'location': location,
      'time': time,
      'participants': participants,
      'about': about,
      'price': price,
    };
  }
}
