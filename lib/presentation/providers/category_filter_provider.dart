import 'package:flutter_riverpod/legacy.dart';

enum EventCategoryFilter {
  all,
  music,
  standup,
  poetry,
  // Sports category removed
}

final categoryFilterProvider = StateProvider<EventCategoryFilter>(
  (ref) => EventCategoryFilter.all,
);