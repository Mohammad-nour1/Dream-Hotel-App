import 'dart:convert';
import 'package:hotel1/models/room_model.dart';
import 'package:hotel1/models/blog_model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://hotel.mastercoders.dev/api'; 

  Future<List<Room>> fetchRooms() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/room/index'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Room> rooms =
          data.map((roomJson) => Room.fromJson(roomJson)).toList();

      return rooms;
    } else {
      throw Exception('Failed to load rooms');
    }
  }

/////////////////////////////////////////////////////
  Future<List<BlogPost>> fetchBlogPosts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/blog/index'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      
      return jsonData.map((item) => BlogPost.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blog posts');
    }
  }

  //////////////////////////////////////////////////////////////
  Future<List<String>> fetchGalleryImages() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/gallery'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      return List<String>.from(jsonData);
    } else {
      throw Exception('Failed to load images');
    }
  }
}
