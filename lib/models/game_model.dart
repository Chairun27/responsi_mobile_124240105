class GameModel {
  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final String description;
  final List<String> screenshots;

  GameModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.description,
    required this.screenshots,
  });

  // Mengubah JSON dari API menjadi objek GameModel
  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      thumbnail: json['thumbnail'] ?? '',
      genre: json['genre'] ?? 'Unknown',
      platform: json['platform'] ?? 'Unknown',
      publisher: json['publisher'] ?? '-',
      developer: json['developer'] ?? '-',
      releaseDate: json['release_date'] ?? '-',
      description: json['description'] ?? 'Tidak ada deskripsi.',
      
      // Handling screenshots 
      screenshots: json['screenshots'] != null
        ? List<String>.from(json['screenshots'].map((x) => x['image']))
        : [],
    );
  }

  // Mengubah objek menjadi Map (untuk disimpan ke Hive Library)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'release_date': releaseDate,
      'description': description,
      'screenshots': screenshots.map((url) => {'image': url}).toList(),
    };
  }
}