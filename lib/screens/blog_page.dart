import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hotel1/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel1/api/api_service.dart'; 
import 'package:hotel1/models/blog_model.dart'; 

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
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: FutureBuilder<List<BlogPost>>(
        future: ApiService().fetchBlogPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load blog posts'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          final posts = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: posts.map((post) {
                return _buildBlogPost(
                  context,
                  post.title,
                  post.description,
                  post.image,
                  post.subTitle,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBlogPost(
    BuildContext context,
    String title,
    String description,
    String imageUrl,
    String subTitle,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: InkWell(
        onTap: () => _showPostDetails(
          context,
          title,
          imageUrl,
          subTitle,
          description,
        ),
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
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subTitle,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkTheme ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
      ),
    );
  }

  void _showPostDetails(
    BuildContext context,
    String title,
    String imageUrl,
    String subTitle,
    String description,
  ) {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
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
                const SizedBox(height: 20),
                Text(
                  subTitle,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
        );
      },
    );
  }
}
