import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui'; // لإضافة تأثير الضبابي
import 'package:hotel1/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  // رابط Google Maps لموقع الفندق
  final String googleMapsUrl =
      'https://www.google.com/maps/place/123+Dream+St,+Dream+City,+DR+12345';

  // دالة لفتح الرابط
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 26,
              shadows: [
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
      body: Stack(
        children: [
          // صورة الخلفية
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.pexels.com/photos/3651577/pexels-photo-3651577.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'About You',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildTextField(context, 'Name'),
                SizedBox(height: 16.0),
                _buildTextField(context, 'Email'),
                SizedBox(height: 16.0),
                _buildTextField(context, 'Phone Number'),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Message',
                    labelStyle: GoogleFonts.roboto(
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: isDarkTheme ? Colors.black54 : Colors.white,
                  ),
                  style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black),
                  maxLines: 4,
                ),
                SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // أضف الوظيفة التي تريدها هنا
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text(
                      'SEND',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  thickness: 6,
                  color: themeProvider.buttonColor,
                ),
                SizedBox(height: 16),
                _buildContactInfo(context, 'Address:',
                    '123 Dream St, Dream City, DR 12345', googleMapsUrl),
                SizedBox(height: 16),
                _buildContactInfo(context, 'Phone:', '+1 234 567 890'),
                SizedBox(height: 16),
                _buildContactInfo(context, 'Email:', 'info@dreamhotel.com'),
                SizedBox(height: 20),
                Text(
                  'Follow Us:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: isDarkTheme ? Colors.white : Colors.black,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.facebook_sharp),
                      color: isDarkTheme ? Colors.white : Colors.black,
                      onPressed: () {
                        // أضف رابط Facebook هنا
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.telegram_outlined),
                      color: isDarkTheme ? Colors.white : Colors.black,
                      onPressed: () {
                        // أضف رابط Telegram هنا
                      },
                    ),
                  ],
                ),
                SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: isDarkTheme ? Colors.black54 : Colors.white,
      ),
      style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
    );
  }

  Widget _buildContactInfo(BuildContext context, String title, String content,
      [String? url]) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: isDarkTheme ? Colors.white : Colors.black,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (url != null) {
              _launchURL(url);
            }
          },
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: isDarkTheme ? Colors.white : Colors.black,
              decoration: url != null ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}
