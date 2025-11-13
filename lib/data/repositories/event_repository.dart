import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tixoo/data/models/event_model.dart';

class EventRepository {
  final String apiUrl = 'https://691488623746c71fe0489d47.mockapi.io/spotly/Events';

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Decode the JSON response body
      final List<dynamic> jsonList = jsonDecode(response.body);
      
      // Map the decoded list to a List<EventModel> using the fromJson constructor
      return jsonList.map((json) => EventModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      // Handle non-200 status code (Error Handling)
      throw Exception('Failed to load events. Status Code: ${response.statusCode}');
    }
  }
}

// Global provider for the repository instance
final eventRepositoryProvider = Provider((ref) => EventRepository());