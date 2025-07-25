import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel1/screens/Contact_Us_Page.dart';
import 'package:hotel1/screens/about_page.dart';
import 'package:hotel1/screens/blog_page.dart';
import 'package:hotel1/screens/our_rooms_page.dart';
import 'package:provider/provider.dart';
import 'package:hotel1/providers/theme_provider.dart';
import 'secondary_page.dart';
import 'gallery_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;
    Color dividerColor = themeProvider.buttonColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu',
            style: GoogleFonts.roboto(
              color: isDarkTheme ? Colors.white : Colors.black,
            )),
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.pexels.com/photos/2096983/pexels-photo-2096983.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            child: ListView(
              children: <Widget>[
                _buildMenuItem('Contact Us', Icons.contact_mail, context),
                _buildDivider(dividerColor),
                _buildMenuItem('Gallery', Icons.photo_album, context),
                _buildDivider(dividerColor),
                _buildMenuItem('Our Rooms', Icons.hotel, context),
                _buildDivider(dividerColor),
                _buildMenuItem('Blog', Icons.article, context),
                _buildDivider(dividerColor),
                _buildMenuItem('About', Icons.info, context),
                _buildDivider(dividerColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: () {
        if (title == 'About') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutPage(),
            ),
          );
        } else if (title == 'Contact Us') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactUsPage(),
            ),
          );
        } else if (title == 'Gallery') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GalleryPage(),
            ),
          );
        } else if (title == 'Blog') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BlogPage(),
            ),
          );
        } else if (title == 'Our Rooms') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OurRoomsPage(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondaryPage(title: title),
            ),
          );
        }
      },
    );
  }

  Widget _buildDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        color: color,
        thickness: 2,
      ),
    );
  }
}
