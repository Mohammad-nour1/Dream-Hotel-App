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

    // قائمة تحتوي على تفاصيل كل بوست
    final posts = [
      {
        'title': 'Bed Room 1',
        'description': 'A beautiful and relaxing bedroom.',
        'imageUrl':
            'https://images.pexels.com/photos/271619/pexels-photo-271619.jpeg',
        'date': 'August 27, 2024',
        'rating': 4,
        'price': '20 Eur',
        'comments': [
          {'name': '-John Doe ', 'comment': 'Amazing room, very comfortable!'},
          {'name': '-Jane Smith ', 'comment': 'Loved the decor and the view.'},
          {'name': '-Alice Johnson ', 'comment': 'A perfect place to relax.'},
          {'name': '-Bob Brown ', 'comment': 'Would definitely stay again!'},
        ],
      },
      {
        'title': 'Bed Room 2',
        'description': 'A cozy and stylish bedroom.',
        'imageUrl':
            'https://images.pexels.com/photos/271643/pexels-photo-271643.jpeg',
        'date': 'August 20, 2024',
        'rating': 5,
        'price': '25 Eur',
        'comments': [
          {
            'name': '-Sarah Parker ',
            'comment': 'Beautiful room with great amenities.'
          },
          {
            'name': '-Michael Lee ',
            'comment': 'Super comfortable bed and nice design.'
          },
          {'name': '-Emma Davis ', 'comment': 'Had a wonderful stay here!'},
          {
            'name': '-Chris Miller ',
            'comment': 'Excellent service and cozy room.'
          },
        ],
      },
      {
        'title': 'Bed Room 3',
        'description': 'A spacious and modern bedroom.',
        'imageUrl':
            'https://images.pexels.com/photos/172872/pexels-photo-172872.jpeg',
        'date': 'August 15, 2024',
        'rating': 3,
        'price': '18 Eur',
        'comments': [
          {
            'name': '-Laura Wilson ',
            'comment': 'Spacious room with great lighting.'
          },
          {
            'name': '-James Taylor ',
            'comment': 'The room was clean and modern.'
          },
          {
            'name': '-Olivia Harris ',
            'comment': 'Had everything we needed for a comfortable stay.'
          },
          {
            'name': '-David Clark ',
            'comment': 'Would recommend to friends and family.'
          },
        ],
      },
    ];

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
          children: posts.map((post) {
            return _buildBlogPost(
              context,
              post['title']! as String,
              post['description']! as String,
              post['imageUrl']! as String,
              post['date']! as String,
              post['rating'] as int,
              post['price']! as String,
              post['comments'] as List<Map<String, String>>,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBlogPost(
      BuildContext context,
      String title,
      String description,
      String imageUrl,
      String date,
      int rating,
      String price,
      List<Map<String, String>> comments) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: InkWell(
        onTap: () => _showPostDetails(
            context, title, imageUrl, date, rating, price, comments),
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
                      price,
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
      ),
    );
  }

  void _showPostDetails(
      BuildContext context,
      String title,
      String imageUrl,
      String date,
      int rating,
      String price,
      List<Map<String, String>> comments) {
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
                  date,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 30),
                Text(
                  'Price: $price per night',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Some Comments:',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: comments.map((comment) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${comment['name']}: ${comment['comment']}',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 16,
                            height: 1.5, // لضبط التباعد بين الأسطر داخل النص
                            color:
                                isDarkTheme ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20), // مسافة إضافية في أسفل الـ Modal
              ],
            ),
          ),
        );
      },
    );
  }
}
