import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hotel1/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
              color: isDarkTheme ? Colors.white : Colors.black,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 35.0,
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3),
            _buildBlogPost(
              context,
              'Bed Room 1',
              'If you are going to use a passage of Lorem Ipsum, you need to be sure there is not anything embarrassing hidden in the middle of text.',
              'https://images.pexels.com/photos/271619/pexels-photo-271619.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              'August 27, 2024',
              4,
            ),
            _buildBlogPost(
              context,
              'Bed Room 2',
              'If you are going to use a passage of Lorem Ipsum, you need to be sure there is not anything embarrassing hidden in the middle of text.',
              'https://images.pexels.com/photos/271643/pexels-photo-271643.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              'August 20, 2024',
              5,
            ),
            _buildBlogPost(
              context,
              'Bed Room 3',
              'If you are going to use a passage of Lorem Ipsum, you need to be sure there is not anything embarrassing hidden in the middle of text.',
              'https://images.pexels.com/photos/172872/pexels-photo-172872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              'August 15, 2024',
              3,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogPost(BuildContext context, String title, String description,
      String imageUrl, String date, int rating) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      child: Card(
        elevation: 5,
        color: isDarkTheme ? Colors.grey[850] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    date,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: isDarkTheme ? Colors.white54 : Colors.black54,
                      ),
                    ),
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
