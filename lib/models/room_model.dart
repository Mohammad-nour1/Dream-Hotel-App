class Room {
  final int id;
  final String imageUrl;
  final String title;
  final String description;

  Room({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      imageUrl: json['image'],
      title: json['title'],
      description: json['description'],
    );
  }
}