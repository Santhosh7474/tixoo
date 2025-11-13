import 'package:flutter_riverpod/legacy.dart';

enum EventCategoryFilter {
  all,
  music,
  standup,
  poetry,
}

final categoryFilterProvider = StateProvider<EventCategoryFilter>(
  (ref) => EventCategoryFilter.all,
);