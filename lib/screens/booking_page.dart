import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة ScreenUtil
import 'package:hotel1/screens/about_page.dart';
import 'package:hotel1/screens/blog_page.dart';
import 'package:hotel1/screens/contact_us_page.dart';
import 'package:hotel1/screens/gallery_page.dart';
import 'package:hotel1/screens/our_rooms_page.dart';
import 'package:provider/provider.dart';
import 'package:hotel1/providers/theme_provider.dart';
import 'menu_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? arrivalDate;
  DateTime? departureDate;
  final PageController _pageController = PageController();
  final List<String> _images = [
    'https://images.pexels.com/photos/1697076/pexels-photo-1697076.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9297005/pexels-photo-9297005.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load',
    'https://images.pexels.com/photos/2964163/pexels-photo-2964163.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/5563472/pexels-photo-5563472.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % _images.length;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInExpo,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future _selectDate(BuildContext context, bool isArrival) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isArrival) {
          arrivalDate = picked;
        } else {
          departureDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;
    Color textColor = isDarkTheme ? Colors.white : Colors.black;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkTheme ? Colors.black : Colors.white,
          iconTheme: IconThemeData(color: textColor),
          title: Row(
            children: [
              Image.asset('assets/icons/hotel-1880.png',
                  height: 38.h), // استخدام وحدة h
              SizedBox(width: 12.w), // استخدام وحدة w
              Text(
                'Dream Hotel',
                style: GoogleFonts.merriweather(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp, // استخدام وحدة sp
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton(
              icon: Image.asset(
                'assets/icons/brush_6873541.png',
                height: 28.h, // استخدام وحدة h
              ),
              onSelected: (String result) {
                if (result == 'theme') {
                  showThemeDialog(context);
                } else if (result == 'toggle_button_color') {
                  showColorDialog(context);
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'theme',
                  child: Row(
                    children: [
                      Icon(Icons.brightness_6, color: textColor),
                      SizedBox(width: 10.w), // استخدام وحدة w
                      Text('Toggle Theme', style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'toggle_button_color',
                  child: Row(
                    children: [
                      Icon(Icons.color_lens, color: textColor),
                      SizedBox(width: 10.w), // استخدام وحدة w
                      Text('Toggle Button Color',
                          style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/menu_12318497.png',
                height: 24.h, // استخدام وحدة h
                color: themeProvider.buttonColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 580.h, // استخدام وحدة h
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: _images[index],
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      },
                    ),
                    // البطاقة الأمامية لحجز الغرف
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 85.0, left: 19.0, right: 19.0, bottom: 19.0),
                      child: Card(
                        color: Colors.black.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.r), // استخدام وحدة r
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(22.w), // استخدام وحدة w
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'BOOK A ROOM',
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 24.sp, // استخدام وحدة sp
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.h), // استخدام وحدة h
                              _buildDateField('Arrival', arrivalDate, true),
                              SizedBox(height: 16.h), // استخدام وحدة h
                              _buildDateField(
                                  'Departure', departureDate, false),
                              SizedBox(height: 20.h), // استخدام وحدة h
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: themeProvider.buttonColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50.w, // استخدام وحدة w
                                      vertical: 15.h), // استخدام وحدة h
                                  textStyle: TextStyle(
                                      fontSize: 18.sp), // استخدام وحدة sp
                                ),
                                child: Text(
                                  'Book Now',
                                  style: GoogleFonts.merriweather(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h), // استخدام وحدة h
                              _ContactInfo(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 780.h,
                  maxWidth: double.infinity,
                ),
                child: const AboutPage(),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 1365.h,
                  maxWidth: double.infinity,
                ),
                child: GalleryPage(),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 1260.h,
                  maxWidth: double.infinity,
                ),
                child: const OurRoomsPage(),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 1601.h,
                  maxWidth: double.infinity,
                ),
                child: const BlogPage(),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 1150.h,
                  maxWidth: double.infinity,
                ),
                child: const ContactUsPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, bool isArrival) {
    return GestureDetector(
      onTap: () => _selectDate(context, isArrival),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r), // استخدام وحدة r
        ),
        padding: EdgeInsets.symmetric(
            vertical: 15.h, horizontal: 10.w), // استخدام وحدات h و w
        child: Row(
          children: [
            Text(
              date == null ? label : date.toLocal().toString().split(' ')[0],
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp, // استخدام وحدة sp
              ),
            ),
            const Spacer(),
            const Icon(Icons.calendar_today, color: Colors.black),
          ],
        ),
      ),
    );
  }

  void showThemeDialog(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Theme"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  themeProvider.toggleTheme(ThemeMode.light);
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.wb_sunny, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleTheme(ThemeMode.dark);
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.nights_stay, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showColorDialog(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Toggle Button Color"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  themeProvider.toggleButtonColor(Colors.red);
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleButtonColor(Colors.blue);
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleButtonColor(Colors.green);
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleButtonColor(
                      const Color.fromARGB(255, 147, 11, 214));
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 147, 11, 214),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'For assistance , call us at 0123-4567',
          style: TextStyle(
              color: Colors.white, fontSize: 16.sp), // استخدام وحدة sp
        ),
        SizedBox(height: 4.h), // استخدام وحدة h
        Text(
          'Or Email us at info@dreamhotel.com',
          style: TextStyle(
              color: Colors.white, fontSize: 16.sp), // استخدام وحدة sp
        ),
      ],
    );
  }
}
