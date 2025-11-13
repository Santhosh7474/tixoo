// lib/presentation/widgets/list_event_item.dart

import 'package:flutter/material.dart';
import 'package:tixoo/core/constants/app_colors.dart';
import 'package:tixoo/data/models/event_model.dart';
import 'package:tixoo/presentation/screens/event_detail_screen.dart'; 

class ListEventItem extends StatelessWidget {
  final EventModel event;

  const ListEventItem({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Event Detail Screen (Screen 3)
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        // Use intrinsic height to make the card size itself based on the tallest child
        constraints: const BoxConstraints(minHeight: 143), 
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
        child: IntrinsicHeight( // Ensures the Row children match the height of the tallest child
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children vertically
            children: [
              // 50% Image Placeholder (Left Side) - Fixed width based on visual aspect ratio
              Container( 
                width: 143, 
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                ),
                child: ClipRRect( // Clip the image to match the container's rounded corners
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                  child: Image.network(
                    event.image, // Use the actual image URL
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                          color: AppColors.primaryGreen,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, color: AppColors.greyText)), // Error Handling
                  ),
                ),
              ),
              
              // 50% Details (Right Side)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Row: Date & Heart Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // Shows just the date part, e.g., "Sun, 25 Jan"
                            event.date.split(',').first, 
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(
                            Icons.favorite,
                            color: AppColors.primaryGreen,
                            size: 20,
                          ),
                        ],
                      ),
                      
                      // Event Title
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.darkText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // Location/Venue (FIX: Using available event.location field)
                      Text(
                        event.location, 
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.greyText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // Bottom Row: Price & Button (The overflow fix area)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // FIX: Wrap Text in Expanded to solve 2.4px overflow
                          Expanded(
                            child: Text(
                              '₹ ${event.price.toString()} Onwards',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              minimumSize: Size.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}