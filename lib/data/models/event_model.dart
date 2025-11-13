// lib/data/models/event_model.dart

class EventModel {
  final String id;
  final String title;
  final String category;
  final String date;
  final String location;
  final int price; 
  final String image; 
  
  final bool isTrending; 

  EventModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.price,
    required this.image,
    this.isTrending = false,
  });

  // Factory constructor to create an EventModel from a JSON map
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
      location: json['location'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
      // MOCK LOGIC for Trending status
      isTrending: (json['category'] == 'Music' || json['category'] == 'Standup'), 
    );
  }
}

class PromoterModel {
  final String id;
  final String name;
  final String rating;
  final String description;

  PromoterModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.description,
  });
}