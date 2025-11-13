// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tixoo/core/constants/app_colors.dart';
import 'package:tixoo/presentation/screens/event_discovery_screen.dart'; // Import the next screen

// --- Reusable Widget: Category Card ---

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double width;
  final VoidCallback? onTap;

  const CategoryCard({
    required this.title,
    required this.subtitle,
    required this.width,
    this.onTap, 
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: onTap, 
      child: Container(
        width: width,
        height: 120, 
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.greyText,
              ),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.arrow_forward, color: AppColors.greyText),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Main Screen: Home Screen ---

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // 1. App Bar/Header Section (Location, Get Plus, Profile)
              _buildHeader(context),
              const SizedBox(height: 20),
              // 2. Search Bar
              _buildSearchBar(),
              const SizedBox(height: 24),
              // 3. Cashback Offer Card
              _buildCashbackCard(),
              const SizedBox(height: 16),
              // 4. Events & Sports Cards (Row)
              _buildEventCategoryRow(context),
              const SizedBox(height: 16),
              // 5. Club Events Card
              _buildClubEventsCard(context),
              const SizedBox(height: 32),
              // 6. Large Green Footer
              _buildLargeFooterCard(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Location Widget
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
        
        // "Get Plus" Button and Profile Icon
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGreen.withOpacity(0.1), 
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.lightGreen, width: 0.5),
              ),
              child: Row(
                children: const [
                  Icon(Icons.flash_on, color: AppColors.primaryGreen, size: 16),
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
            // Profile Icon placeholder
            const CircleAvatar(radius: 18, backgroundColor: AppColors.cardBackground),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
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
    );
  }

  Widget _buildCashbackCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assured Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Assured',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '10% cashback',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: AppColors.primaryGreen,
                ),
              ),
              const Text(
                'On every purchase\nwith Tixoo+',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkText,
                  height: 1.4,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward, color: AppColors.greyText),
        ],
      ),
    );
  }

  Widget _buildEventCategoryRow(BuildContext context) {
    // Calculate width for two cards minus padding/spacing
    final double totalPadding = 16 * 2; // Left and right padding for the whole screen
    final double spacing = 16; // Space between the two cards
    final double halfWidth = (MediaQuery.of(context).size.width - totalPadding - spacing) / 2;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CategoryCard(
          title: 'Events',
          subtitle: 'Browse all events',
          width: halfWidth,
          onTap: () {
            // Navigate to the Discovery Screen
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EventDiscoveryScreen()));
          },
        ),
        CategoryCard(
          title: 'Sports',
          subtitle: 'Browse all sports events',
          width: halfWidth,
        ),
      ],
    );
  }

  Widget _buildClubEventsCard(BuildContext context) {
    // Full width minus side padding
    final double fullWidth = MediaQuery.of(context).size.width - 32;
    return CategoryCard(
      title: 'Club Events',
      subtitle: 'Browse all Club events',
      width: fullWidth, 
    );
  }

  Widget _buildLargeFooterCard() {
    return Container(
      height: 200, 
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Everyday !',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          Text(
            'Created with 💚 in Lucknow, India',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}