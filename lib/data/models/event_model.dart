// lib/data/models/event_model.dart

class EventModel {
  final String id;
  final String title;
  final String category;
  final String date;
  final String location;
  final int price; // Changed to int
  final String image; // Added image URL field
  
  // Note: We'll manually determine if an event is "Trending" in the repository 
  // or simply display all data and filter later. For simplicity, we'll keep 
  // the trending logic in the presentation layer for now.
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
      price: json['price'] as int, // Parse as int
      image: json['image'] as String, // Parse image URL
      // Mock trending logic for display on the Tixoo Discovery screen
      isTrending: (json['category'] == 'Music' || json['category'] == 'Standup'), 
    );
  }
}

// PromoterModel remains the same (if used in other parts of the app)
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