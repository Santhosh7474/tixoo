import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tixoo/data/models/event_model.dart';
import 'package:tixoo/data/repositories/event_repository.dart';
import 'package:tixoo/presentation/providers/category_filter_provider.dart';

final allEventsProvider = FutureProvider<List<EventModel>>((ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  return repository.fetchEvents();
});

final filteredEventsProvider = FutureProvider<List<EventModel>>((ref) async {
  final allEventsAsyncValue = ref.watch(allEventsProvider); 
  final currentFilter = ref.watch(categoryFilterProvider);

  return allEventsAsyncValue.when(
    loading: () => const [], 
    error: (err, stack) => throw err, 
    data: (allEvents) {
      if (currentFilter == EventCategoryFilter.all) {
        return allEvents;
      }
      
      final filterString = currentFilter.name.toLowerCase(); 
      
      return allEvents
          .where((event) => event.category.toLowerCase() == filterString)
          .toList();
    },
  );
});