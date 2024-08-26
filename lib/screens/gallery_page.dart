import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة ScreenUtil
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hotel1/providers/theme_provider.dart';

class GalleryPage extends StatelessWidget {
  final List<String> imageUrls = [
    'https://images.pexels.com/photos/1134176/pexels-photo-1134176.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2869215/pexels-photo-2869215.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2972890/pexels-photo-2972890.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/261102/pexels-photo-261102.jpeg?auto=compress&cs=tinysrgb&w=600'
  ];

  GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 27.sp, // استخدام وحدة sp لتحديد حجم النص
              shadows: [
                Shadow(
                  color: Colors.black, // لون الظل
                  offset: Offset(1.0, 1.0), // إزاحة الظل
                  blurRadius: 35.sp, // مدى ضبابية الظل باستخدام وحدة sp
                ),
              ],
            ),
          ),
        ),
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true, // Prevent GridView from expanding infinitely
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // استخدام عدد أعمدة يناسب الشاشات المختلفة
                childAspectRatio: 1.7, // نسبة العرض إلى الارتفاع للصور
                crossAxisSpacing:
                    8.w, // استخدام وحدة w لتحديد المسافة بين الأعمدة
                mainAxisSpacing:
                    8.h, // استخدام وحدة h لتحديد المسافة بين الصفوف
              ),
              padding: EdgeInsets.all(20.w), // استخدام وحدة w لتحديد الحشو
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
