import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tixoo/data/models/event_model.dart';
import 'package:tixoo/data/repositories/event_repository.dart';

// This class holds the logic for fetching and managing the list of events.
class EventNotifier extends StateNotifier<AsyncValue<List<EventModel>>> {
  
  final EventRepository _repository;

  EventNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchEvents();
  }

  // Uses the repository to make the API call
  Future<void> fetchEvents() async {
    try {
      // Call the real API via the repository
      final events = await _repository.fetchEvents(); 
      
      // Update state to success
      state = AsyncValue.data(events); 
      
    } catch (e, st) {
      // Handle API/Network errors
      state = AsyncValue.error('Failed to load events: ${e.toString()}', st);
    }
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, AsyncValue<List<EventModel>>>(
  (ref) => EventNotifier(ref.watch(eventRepositoryProvider)),
);