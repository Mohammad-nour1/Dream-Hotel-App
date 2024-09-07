import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel1/screens/about_page.dart';
import 'package:hotel1/screens/blog_page.dart';
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

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

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
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _messageFocusNode.dispose();
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
              Image.asset('assets/icons/hotel-1880.png', height: 38.h),
              SizedBox(width: 12.w),
              Text(
                'Dream Hotel',
                style: GoogleFonts.merriweather(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton(
              icon: Image.asset(
                'assets/icons/brush_6873541.png',
                height: 28.h,
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
                      SizedBox(width: 10.w),
                      Text('Toggle Theme', style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'toggle_button_color',
                  child: Row(
                    children: [
                      Icon(Icons.color_lens, color: textColor),
                      SizedBox(width: 10.w),
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
                height: 24.h,
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
        body: RawScrollbar(
          thumbVisibility: true,
          thickness: 10,
          radius: const Radius.circular(20), // زوايا مدورة
          thumbColor: themeProvider.buttonColor,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // إلغاء التركيز عند النقر في أي مكان آخر
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 625.h,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: _images[index],
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 19.w, vertical: 19.h),
                          child: Card(
                            color: Colors.black.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'BOOK A ROOM',
                                    style: GoogleFonts.oswald(
                                      color: themeProvider.buttonColor,
                                      fontSize: 22
                                          .sp, // تصغير الخط ليتناسب مع المساحة
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  _buildDateField('Arrival', arrivalDate, true),
                                  SizedBox(height: 10.h),
                                  _buildDateField(
                                      'Departure', departureDate, false),
                                  SizedBox(height: 12.h),
                                  _buildTextField(
                                      context, 'Name', _nameFocusNode),
                                  SizedBox(
                                      height: 8.h), // تقليل المسافة بين الحقول
                                  _buildTextField(
                                      context, 'Email', _emailFocusNode),
                                  SizedBox(height: 8.h),
                                  _buildTextField(
                                      context, 'Phone Number', _phoneFocusNode),
                                  SizedBox(height: 8.h),
                                  _buildMessageField(context),
                                  SizedBox(height: 14.h),
                                  ElevatedButton(
                                    onPressed: () {
                                      // أضف الوظيفة التي تريدها هنا
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          themeProvider.buttonColor,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w, vertical: 12.h),

                                      textStyle: TextStyle(
                                          fontSize: 16.sp), // تقليل حجم النص
                                    ),
                                    child: Text(
                                      'SEND',
                                      style: GoogleFonts.merriweather(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
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
                      maxHeight: 755.h,
                      maxWidth: double.infinity,
                    ),
                    child: const AboutPage(),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 1325.h,
                      maxWidth: double.infinity,
                    ),
                    child: const OurRoomsPage(),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 1365.h,
                      maxWidth: double.infinity,
                    ),
                    child: const GalleryPage(),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 1460.h,
                      maxWidth: double.infinity,
                    ),
                    child: const BlogPage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // بناء حقل النص
  Widget _buildTextField(
      BuildContext context, String label, FocusNode focusNode) {
    return TextField(
      focusNode: focusNode,
      maxLines: 1,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        hintText: label,
        contentPadding: EdgeInsets.symmetric(
            vertical: 5.h, horizontal: 10.w), // تقليل التباعد الداخلي
        hintStyle: TextStyle(fontSize: 16.sp), // تقليل حجم النص
      ),
      onEditingComplete: () {
        // عند الانتهاء من الكتابة، إلغاء التركيز
        FocusScope.of(context).unfocus();
      },
    );
  }

  // بناء حقل الرسالة
  Widget _buildMessageField(BuildContext context) {
    return TextField(
      focusNode: _messageFocusNode,
      style: const TextStyle(color: Colors.black),
      maxLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        hintText: 'Message',
        contentPadding: EdgeInsets.symmetric(
            vertical: 12.h, horizontal: 10.w), // تقليل التباعد الداخلي
        hintStyle: TextStyle(fontSize: 16.sp), // تقليل حجم النص
      ),
      onEditingComplete: () {
        // عند الانتهاء من الكتابة، إلغاء التركيز
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget _buildDateField(String label, DateTime? date, bool isArrival) {
    return GestureDetector(
      onTap: () => _selectDate(context, isArrival),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 12.h, horizontal: 10.w), // تقليل التباعد الداخلي
        child: Row(
          children: [
            Text(
              date == null ? label : date.toLocal().toString().split(' ')[0],
              style: GoogleFonts.merriweather(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp, // تقليل حجم النص
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
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

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
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: !isDarkTheme
                          ? const Color.fromARGB(255, 190, 244, 140)
                              .withOpacity(0.8)
                          : Colors.transparent, // لون الدائرة الشفافة
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.wb_sunny, color: Colors.black),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleTheme(ThemeMode.dark);
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkTheme
                          ? const Color.fromARGB(255, 190, 244, 140)
                              .withOpacity(0.8)
                          : Colors.transparent, // لون الدائرة الشفافة
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.nights_stay, color: Colors.white),
                  ),
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
    Color currentButtonColor = themeProvider.buttonColor;

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
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: currentButtonColor == Colors.red
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.transparent,
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleButtonColor(Colors.blue);
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: currentButtonColor == Colors.blue
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.transparent,
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleButtonColor(Colors.green);
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: currentButtonColor == Colors.green
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.transparent,
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  themeProvider.toggleButtonColor(
                      const Color.fromARGB(255, 147, 11, 214));
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: currentButtonColor ==
                              const Color.fromARGB(255, 147, 11, 214)
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.transparent,
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 147, 11, 214),
                  ),
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
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          'Or Email us at info@dreamhotel.com',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      ],
    );
  }
}
