// lib/presentation/screens/event_discovery_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tixoo/core/constants/app_colors.dart';
import 'package:tixoo/data/models/event_model.dart';
import 'package:tixoo/presentation/providers/category_filter_provider.dart';
import 'package:tixoo/presentation/providers/event_provider.dart';
import 'package:tixoo/presentation/widgets/list_event_item.dart';
import 'package:tixoo/presentation/widgets/trending_event_card.dart';

class EventDiscoveryScreen extends ConsumerWidget {
  const EventDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> eventFilters = [
      'Filters',
      'Today',
      'Tomorrow',
      '10 km Far Away',
      'Music',
    ];
    // REMOVED 'Sports' from categoryTabs
    final List<String> categoryTabs = ['All', 'Music', 'Standup', 'Poetry'];

    return DefaultTabController(
      length: categoryTabs.length,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            // 1. App Bar/Header (Scrolls Away)
            _buildSliverAppBar(context),

            // 2. Dark Category Tabs (Type Bar - FIXED OVERFLOW)
            _buildDarkCategoryTabs(context, ref, categoryTabs),

            // 3. Section Title: Trending This Week
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'Trending this week',
                paddingBefore: 24,
                paddingAfter: 12,
              ),
            ),

            // 4. Trending This Week Section
            _buildTrendingSection(context, ref),

            // 5. Section Title: Artists on Tixoo
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'Artists on Tixoo',
                paddingBefore: 24,
                paddingAfter: 12,
              ),
            ),

            // 6. Artists on Tixoo Section (Square Cards)
            _buildArtistsSection(context),

            // 7. Section Title: All Events
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'All Events',
                paddingBefore: 24,
                paddingAfter: 12,
              ),
            ),

            // 8. Filters (Chips)
            _buildFiltersSection(eventFilters),

            // 9. All Events List (The main vertical list - uses filtered data)
            _buildAllEventsList(context, ref),

            // 10. Offers On Tixoo Section
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'Offers On Tixoo',
                isTitleGreen: true,
                paddingBefore: 24,
                paddingAfter: 12,
              ),
            ),
            _buildOffersSection(),

            // 11. Promoters On Tixoo Section
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'Promoters On Tixoo',
                isTitleGreen: true,
                paddingBefore: 24,
                paddingAfter: 12,
              ),
            ),
            _buildPromotersSection(context),

            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  // --- Helper Methods ---

  Widget _buildSectionTitle(
    String title, {
    bool isTitleGreen = false,
    double paddingBefore = 16,
    double paddingAfter = 8,
  }) {
    final color = isTitleGreen ? AppColors.primaryGreen : AppColors.darkText;
    final fontWeight = isTitleGreen ? FontWeight.w900 : FontWeight.bold;

    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, paddingBefore, 16, paddingAfter),
        child: Text(
          '— $title —',
          style: TextStyle(color: color, fontWeight: fontWeight, fontSize: 18),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      // Header scrolls away
      pinned: false,
      elevation: 0,
      toolbarHeight: 250,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      flexibleSpace: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.background, AppColors.pinkBannerBottom],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.darkText,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Haldwani',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.darkText,
                            ),
                          ),
                          Text(
                            'Uttrakhand, India',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.greyText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.lightGreen,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.flash_on,
                              color: AppColors.primaryGreen,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Get Plus',
                              style: TextStyle(
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.cardBackground,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for events',
                    hintStyle: TextStyle(color: AppColors.greyText),
                    prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CENTRAL SQUARE',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: 10,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'YOUR NEW\nADDRESS FOR\nGROWTH',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildDarkCategoryTabs(
    BuildContext context,
    WidgetRef ref,
    List<String> categoryTabs,
  ) {
    final currentFilter = ref.watch(categoryFilterProvider);
    final setFilter = ref.read(categoryFilterProvider.notifier);

    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          // FIX: Reduced height to prevent 7.0px overflow
          height: 58,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.darkCategory,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: categoryTabs.map((title) {
              final filterEnum = _mapTitleToFilter(title);
              final isSelected = currentFilter == filterEnum;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setFilter.state = filterEnum;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryGreen
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getCategoryIcon(title),
                          size: 18,
                          color: isSelected
                              ? AppColors.lightGreen
                              : Colors.white.withOpacity(0.7),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: isSelected
                                ? AppColors.lightGreen
                                : Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  EventCategoryFilter _mapTitleToFilter(String title) {
    switch (title) {
      case 'All':
        return EventCategoryFilter.all;
      case 'Music':
        return EventCategoryFilter.music;
      case 'Standup':
        return EventCategoryFilter.standup;
      case 'Poetry':
        return EventCategoryFilter.poetry;
      // Removed Sports mapping
      default:
        return EventCategoryFilter.all;
    }
  }

  IconData _getCategoryIcon(String title) {
    switch (title) {
      case 'Music':
        return Icons.music_note;
      case 'Standup':
        return Icons.mic;
      case 'Poetry':
        return Icons.favorite;
      case 'Theatre':
        return Icons.theater_comedy;
      // Removed Sports Icon
      default:
        return Icons.category;
    }
  }

  SliverToBoxAdapter _buildTrendingSection(
    BuildContext context,
    WidgetRef ref,
  ) {
    final eventsAsync = ref.watch(filteredEventsProvider);

    return eventsAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: SizedBox(
          height: 380,
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primaryGreen),
          ),
        ),
      ),
      error: (err, stack) => SliverToBoxAdapter(
        child: SizedBox(
          height: 380,
          child: Center(
            child: Text(
              'Failed to load trending: ${err.toString()}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
      data: (events) {
        final trendingEvents = events.where((e) => e.isTrending).toList();

        return SliverToBoxAdapter(
          child: SizedBox(
            // FIX: Height increased to prevent 23.0px overflow
            height: 380,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.8),
              itemCount: trendingEvents.length > 0
                  ? trendingEvents.length * 100
                  : 1,
              itemBuilder: (context, index) {
                if (trendingEvents.isEmpty)
                  return const Center(child: Text("No trending events found."));

                final event = trendingEvents[index % trendingEvents.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: TrendingEventCard(event: event),
                );
              },
            ),
          ),
        );
      },
    );
  }

  SliverToBoxAdapter _buildArtistsSection(BuildContext context) {
    final List<Map<String, String>> mockArtists = [
      {
        'name': 'Karan Aujla',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Karan_Aujla_2020.jpg/250px-Karan_Aujla_2020.jpg',
      },
      {
        'name': 'Seedhe Maut',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/5/50/SeedheMaut%28SM%29.jpg',
      },
      {
        'name': 'Arijit Singh',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Arijit_5th_GiMA_Awards.jpg/250px-Arijit_5th_GiMA_Awards.jpg',
      },
      {
        'name': 'Diljit Dosanjh',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Diljit_Dosanjh.jpg/250px-Diljit_Dosanjh.jpg',
      },
      {
        'name': 'Anirudh Ravichander',
        'image':
            'https://wallpaperbat.com/img/6938982-gallery-of-actor-anirudh-ravichander.jpg',
      },
      {
        'name': 'Taylor Swift',
        'image':
            'https://charts-static.billboard.com/img/2006/12/taylor-swift-vug-artistchart-ko8-180x180.jpg?reload=1763009370153',
      },
      {
        'name': 'Morgan Wallen',
        'image':
            'https://charts-static.billboard.com/img/2018/01/morgan-wallen-eos-artistchart-g3r-180x180.jpg?reload=1763009370153',
      },
      {
        'name': 'Tyler, The Creator',
        'image':
            'https://charts-static.billboard.com/img/2011/12/tyler-the-creator-loo-artistchart-6iy-180x180.jpg?reload=1763009370153',
      },
      {
        'name': 'Florence + The Machine',
        'image':
            'https://charts-static.billboard.com/img/2011/12/florence-the-machine-9p8-artistchart-w0z-180x180.jpg?reload=1763009370153',
      },
      {
        'name': 'Sabrina Carpenter',
        'image':
            'https://charts-static.billboard.com/img/2014/08/sabrina-carpenter-l0r-artistchart-5os-180x180.jpg',
      },
    ];

    return SliverToBoxAdapter(
      child: Center(
        child: SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: mockArtists.length,
            itemBuilder: (context, index) {
              final artist = mockArtists[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.background,
                          width: 4,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Image.network(
                              artist['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryGreen,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.greyText,
                                    ),
                                  ),
                            ),

                            const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.favorite,
                                  color: AppColors.primaryGreen,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      artist['name']!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.darkText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAllEventsList(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(filteredEventsProvider);

    return eventsAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: CircularProgressIndicator(color: AppColors.primaryGreen),
          ),
        ),
      ),
      error: (err, stack) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error loading events: ${err.toString()}. Please check API.',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
      data: (events) {
        if (events.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No events found for this filter.',
                style: TextStyle(color: AppColors.greyText),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListEventItem(event: events[index]);
            }, childCount: events.length),
          ),
        );
      },
    );
  }

  Widget _buildFiltersSection(List<String> filters) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: filters
                .map((filter) {
                  final isFilterButton = filter == 'Filters';
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isFilterButton ? 10 : 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isFilterButton
                            ? AppColors.background
                            : AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.greyText.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (isFilterButton)
                            const Icon(
                              Icons.filter_list,
                              size: 16,
                              color: AppColors.darkText,
                            ),
                          if (isFilterButton) const SizedBox(width: 4),
                          Text(
                            isFilterButton ? 'Filters' : filter,
                            style: TextStyle(
                              color: AppColors.darkText,
                              fontWeight: isFilterButton
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          if (isFilterButton)
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 16,
                              color: AppColors.darkText,
                            ),
                        ],
                      ),
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          ),
        ),
      ),
    );
  }

  Widget _buildOffersSection() {
    final List<String> mockOffers = List.generate(4, (index) => 'Offer $index');
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mockOffers.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return Container(
              width: 250,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10% Cashback',
                    style: TextStyle(
                      color: AppColors.primaryGreen.withOpacity(0.8),
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'on HDFC Bank Debit & Credit Cards',
                    style: TextStyle(color: AppColors.greyText, fontSize: 14),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPromotersSection(BuildContext context) {
    final List<PromoterModel> mockPromotersList = List.generate(
      4,
      (index) => PromoterModel(
        id: '$index',
        name: 'Drix Entertainment',
        rating: '4.8',
        description: 'Promoter for major concerts',
      ),
    );

    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mockPromotersList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final promoter = mockPromotersList[index];
                return Container(
                  width: 350,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        // height: 0,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground, // Changed color to light background for image
                          borderRadius: BorderRadius.circular(10), 
                          border: Border.all(color: AppColors.background, width: 4), 
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              // Image Placeholder / Network Image
                              Image.network(
                                'https://blenderartists.org/uploads/default/original/4X/7/c/d/7cda0e07e22143c4e05cc25b5c9659a1bc169227.jpeg', // Use the specific image URL
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: CircularProgressIndicator(color: AppColors.primaryGreen));
                                },
                                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.person, color: AppColors.greyText)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              promoter.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.darkText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              promoter.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.greyText,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFC107),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          promoter.rating,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkText,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF66BB6A),
                                        AppColors.primaryGreen,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Explore more',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          // See All Promoters Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.greyText.withOpacity(0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'See All Promoters',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: AppColors.darkText, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
