import 'package:flutter/material.dart';
import 'package:tixoo/core/constants/app_colors.dart';
import 'package:tixoo/data/models/event_model.dart';
import 'package:tixoo/presentation/screens/event_detail_screen.dart';
class TrendingEventCard extends StatelessWidget {
  final EventModel event;

  const TrendingEventCard({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed width ensures consistency when used inside PageView.builder
    final cardWidth = MediaQuery.of(context).size.width * 0.75; 

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(event: event),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for image/background area
            Padding(
              padding: const EdgeInsets.all(8.0), // Padding around the image
              child: Container(
                height: 220, 
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12), // Smoother internal corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    event.image, // Use the actual image URL
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null, color: AppColors.primaryGreen,));
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, color: AppColors.greyText)), // Error Handling
                  ),
                ),
              ),
            ),
            
            // Text Content (Adjusted padding to ensure no overflow)
            Padding(
              // Reduced vertical padding to save space for the larger image
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 4.0, bottom: 10.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date & Time
                  Text(
                    event.date, 
                    style: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Event Name
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: AppColors.darkText,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Location/Venue
                  Text(
                    event.category + ' • ' + event.location, 
                    style: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '₹ ${event.price.toString()} Onwards',
                        style: const TextStyle(
                          color: AppColors.darkText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.greyText,
                        size: 14,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}