import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel1/providers/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 

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
              fontSize: 26.sp, 
            ),
          ),
        ),
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24.w, vertical: 18.h), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Our Hotel',
                style: TextStyle(
                  fontSize: 17.sp, 
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  height: 0.1,
                ),
              ),
              SizedBox(height: 10.h), 
              Text(
                "The hotel was opened in 2014 and is a modern and elegant 4-star hotel overlooking the sea. It is ideal for a romantic and enchanting holiday, in the enchanting atmosphere of Taormina and the Ionian Sea."
                "If you want perfect rooms, the rooms at our hotel are new, well-lit and attractive."
                'Our reception staff will be happy to assist you during your stay at our hotel, suggesting itineraries, guided visits and some good restaurants.',
                style: TextStyle(
                  fontSize: 18.sp, 
                  height: 1.6,
                ),
              ),
              SizedBox(height: 20.h), 
              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.buttonColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: 25.w, vertical: 15.h), 
                  textStyle: TextStyle(fontSize: 15.sp),
                ),
                child: const Text(
                  'Read More',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 40.h), 
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
