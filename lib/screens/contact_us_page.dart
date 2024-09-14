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

  const ContactUsPage({super.key});

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

    return GestureDetector(
      onTap: () {
        // Dismiss keyboard and unfocus text fields when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact Us',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 26,
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
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'For Contact',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: isDarkTheme ? Colors.white : Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // حقول النموذج
                  _buildTextField(context, 'Name', 'Enter your name'),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Email', 'Enter your email'),
                  const SizedBox(height: 16),
                  _buildTextField(
                      context, 'Phone Number', 'Enter your phone number'),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Message', 'Enter your message',
                      maxLines: 4),
                  const SizedBox(height: 16),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        onTap: () {
                          _launchURL(googleMapsUrl);
                        },
                        child: Image.asset(
                          'assets/images/p17.png',
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 230,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactInfo(context, 'Address:',
                      '123 Dream St, Dream City, DR 12345', googleMapsUrl),
                  const SizedBox(height: 16),
                  _buildContactInfo(context, 'Phone:', '+1 234 567 890'),
                  const SizedBox(height: 16),
                  _buildContactInfo(context, 'Email:', 'info@dreamhotel.com'),
                  const SizedBox(height: 20),
                  Text(
                    'Follow Us:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: isDarkTheme ? Colors.white : Colors.black,
                      shadows: const [
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
                        icon: const Icon(Icons.facebook_sharp),
                        color: isDarkTheme ? Colors.white : Colors.black,
                        onPressed: () async {
                          const String facebookUrl =
                              'https://www.facebook.com/profile.php?id=61563804418873&mibextid=e8SNworyyy6rbT9t';
                          if (await canLaunch(facebookUrl)) {
                            await launch(facebookUrl);
                          } else {
                            throw 'Could not launch $facebookUrl';
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 135),
                ],
              ),
            ),
          ],
        ),
      ),
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
            shadows: const [
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

  Widget _buildTextField(BuildContext context, String label, String hint,
      {int maxLines = 1}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        hintStyle: TextStyle(
          color: isDarkTheme ? Colors.grey[600] : Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkTheme ? Colors.white70 : Colors.black45,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkTheme ? Colors.white70 : Colors.black45,
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold, // Make text bold while typing
      ),
      maxLines: maxLines,
    );
  }
}
