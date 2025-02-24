class Actu {
  final String title;
  final String description;
  final String image;
  final String date;

  Actu({
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  factory Actu.fromJson(Map<String, dynamic> json) {
    return Actu(
      title: json['title'],
      description: json['description'],
      image: json['picture_url'],
      date: json['published_at'],
    );
  }
}
