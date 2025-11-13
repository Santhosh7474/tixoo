import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tixoo/data/models/event_model.dart';

class EventRepository {
  final String apiUrl = 'https://691488623746c71fe0489d47.mockapi.io/spotly/Events';

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      
      return jsonList.map((json) => EventModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load events. Status Code: ${response.statusCode}');
    }
  }
}

final eventRepositoryProvider = Provider((ref) => EventRepository());