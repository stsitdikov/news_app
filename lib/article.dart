class Article {
  final String title;
  final String urlToImage;
  final String description;
  final String date;

  const Article(
      {required this.title,
      required this.urlToImage,
      required this.description,
      required this.date});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Ошибка',
      urlToImage: json['urlToImage'] ?? '',
      description: json['description'] ?? 'Ошибка',
      date: json['publishedAt'] ?? 'Ошибка',
    );
  }
}
