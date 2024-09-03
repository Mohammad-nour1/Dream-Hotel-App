import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hotel1/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OurRoomsPage extends StatelessWidget {
  const OurRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    final rooms = [
      {
        'title': 'Luxury Suite',
        'description': 'A luxurious suite with a stunning view.',
        'imageUrl':
            'https://images.pexels.com/photos/210265/pexels-photo-210265.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'date': 'Available from August 27, 2024',
        'extraDetails':
            'Our Deluxe Twin/Large Double also provides views over landscaped gardens. It has a seating area, digital safe and mini fridge. This room can be configured with either 2 single beds or zip and linked to provide a large double bed.',
      },
      {
        'title': 'Double Room',
        'description': 'A comfortable room with two double beds.',
        'imageUrl':
            'https://images.pexels.com/photos/1743231/pexels-photo-1743231.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'date': 'Available from September 10, 2024',
        'extraDetails':
            'Our Deluxe king size room has a seating area, ample storage, digital safe and mini fridge. This room can also be configured with an extra roll-away bed for families of 3',
      },
      {
        'title': 'Single Room',
        'description': 'A cozy single room perfect for solo travelers.',
        'imageUrl':
            'https://images.pexels.com/photos/271639/pexels-photo-271639.jpeg',
        'date': 'Available from October 1, 2024',
        'extraDetails':
            'As our smallest budget rooms, the Compact bedrooms are suited for single occupancy or short-stay double occupancy as they have limited space and storage.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Rooms',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 26,
              shadows: const [
                Shadow(
                  color: Colors.black, // لون الظل
                  offset: Offset(1.0, 1.0), // إزاحة الظل
                  blurRadius: 35.0, // مدى ضبابية الظل
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: rooms.map((room) {
            return _buildRoomCard(
              context,
              room['title'] as String,
              room['description'] as String,
              room['imageUrl'] as String,
              room['date'] as String,
              room['extraDetails'] as String,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRoomCard(
    BuildContext context,
    String title,
    String description,
    String imageUrl,
    String date,
    String extraDetails,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: InkWell(
        onTap: () =>
            _showRoomDetails(context, title, imageUrl, date, extraDetails),
        child: Card(
          elevation: 5,
          color: isDarkTheme ? Colors.grey[850] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkTheme ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRoomDetails(BuildContext context, String title, String imageUrl,
      String date, String extraDetails) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkTheme ? Colors.grey[900] : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isDarkTheme ? Colors.grey : Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
              const SizedBox(height: 25),
              Text(
                date,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Details:',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                extraDetails,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5, // لضبط التباعد بين الأسطر داخل النص نفسه
                  color: isDarkTheme ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(
                  height: 20), // مسافة إضافية بين النصوص والحافة السفلى
            ],
          ),
        );
      },
    );
  }
}
