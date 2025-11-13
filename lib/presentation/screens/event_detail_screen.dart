// lib/presentation/screens/event_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tixoo/core/constants/app_colors.dart';
import 'package:tixoo/data/models/event_model.dart';

// --- Reusable Widget: Detail Info Row ---
class DetailInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const DetailInfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container (Off-white background with green icon)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryGreen),
          ),
          const SizedBox(width: 16),
          
          // Title and Subtitle Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          
          // Forward Arrow Icon
          const Icon(
            Icons.arrow_forward,
            color: AppColors.greyText,
            size: 18,
          ),
        ],
      ),
    );
  }
}

// --- Event Detail Screen ---

class EventDetailScreen extends ConsumerWidget {
  final EventModel event;

  const EventDetailScreen({required this.event, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // Body uses Stack to place the scrolling content behind the persistent bottom bar
      body: Stack(
        children: [
          _buildDetailContent(context),
          _buildPersistentBottomBar(context),
        ],
      ),
    );
  }
  
  // CustomScrollView for the main content and collapsing header
  Widget _buildDetailContent(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        // 1. Image Header (Sliver AppBar with collapsing effect)
        _buildSliverAppBar(context),
        
        // 2. Main Content (Sliver List)
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Title
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkText,
                      ),
                    ),
                    
                    const SizedBox(height: 16),

                    // Date and Time Rows
                    DetailInfoRow(
                      icon: Icons.calendar_today_outlined,
                      title: 'Date and Time',
                      subtitle: event.date,
                    ),
                    const Divider(color: AppColors.cardBackground, thickness: 1),
                    DetailInfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'Venue and Location',
                      // FIX: Using only event.location since subtitle is not in API
                      subtitle: event.location, 
                    ),
                    const Divider(color: AppColors.cardBackground, thickness: 1),

                    // Detailed Description (Mock Content)
                    const SizedBox(height: 16),
                    const Text(
                      'About the Event',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Join us for an unforgettable night of music featuring Casa Bacardi on Tour. The event will showcase local talent and a headlining performance. Get ready for a high-energy show with incredible production and sound. Doors open at 5:00 PM. Book your tickets now before they sell out!',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.greyText,
                        height: 1.5,
                      ),
                    ),
                    
                    // Spacer to ensure content scrolls above the bottom bar
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      // Image covers about 45% of screen height
      expandedHeight: MediaQuery.of(context).size.height * 0.45, 
      pinned: true, // Keeps the App Bar visible after collapsing
      backgroundColor: AppColors.background,
      elevation: 0,
      
      // Back Button (Wrapped in a translucent circle as per design)
      leading: Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      actions: [
        // Heart Icon (Wrapped in a translucent circle)
        Container(
          margin: const EdgeInsets.only(right: 4, top: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
        ),
        // Share Icon (Wrapped in a translucent circle)
        Container(
          margin: const EdgeInsets.only(right: 14, top: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
      
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          event.image, // Use the event image URL
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null, color: AppColors.primaryGreen,));
          },
          errorBuilder: (context, error, stackTrace) => Center(child: Container(color: Colors.grey[300], child: const Icon(Icons.broken_image, color: AppColors.greyText, size: 50))),
        ),
      ),
    );
  }

  // Persistent Bottom Booking Bar
  Widget _buildPersistentBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        // Add bottom padding for phone safe area (notch/gesture bar)
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Base Price',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
                Text(
                  // Use the price from the event model
                  '₹ ${event.price.toString()}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
            // Book Now Button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Booking for ${event.title} confirmed!',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: AppColors.primaryGreen,
                    behavior: SnackBarBehavior.floating, // To float above the persistent bar
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}