import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel1/providers/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة ScreenUtil

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 26.sp, // استخدام وحدة sp
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
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24.w, vertical: 18.h), // استخدام وحدات w و h
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Our Hotel',
                style: TextStyle(
                  fontSize: 17.sp, // استخدام وحدة sp
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  height: 0.1,
                ),
              ),
              SizedBox(height: 10.h), // استخدام وحدة h
              Text(
                'Our Hotel is a modern, elegant 4-star hotel overlooking the sea, perfect for a romantic, charming vacation, in the enchanting setting of Taormina and the Ionian Sea.'
                'The rooms at the Our Hotel are new, well-lit and inviting.'
                'Our reception staff will be happy to help you during your stay in Taormina, suggesting itineraries, guided visits and some good restaurants in the historic centre.',
                style: TextStyle(
                  fontSize: 18.sp, // استخدام وحدة sp
                  height: 1.6,
                ),
              ),
              SizedBox(height: 20.h), // استخدام وحدة h
              ElevatedButton(
                onPressed: () {
                  // Action for "Read More"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.buttonColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: 25.w, vertical: 15.h), // استخدام وحدات w و h
                  textStyle: TextStyle(fontSize: 15.sp), // استخدام وحدة sp
                ),
                child: const Text(
                  'Read More',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 40.h), // استخدام وحدة h
              CachedNetworkImage(
                imageUrl:
                    'https://images.pexels.com/photos/14024019/pexels-photo-14024019.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1/image.jpg',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
