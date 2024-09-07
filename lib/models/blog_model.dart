class BlogPost {
  final int id;
  final String image;
  final String title;
  final String description;
  final String subTitle;

  BlogPost({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.subTitle,
  });

  // Factory constructor to create BlogPost from JSON
  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      subTitle: json['sub_title'], // Ensure the JSON key matches the field name
    );
  }

  // Method to convert BlogPost to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'sub_title': subTitle,
    };
  }
}
