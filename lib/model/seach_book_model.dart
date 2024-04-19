class BookSearch {
  final String title;
  final List<String> authors;
  final String imageUrl;
  final int firstPublishYear;

  BookSearch({
    required this.title,
    required this.authors,
    required this.imageUrl,
    required this.firstPublishYear,
  });

  factory BookSearch.fromJson(Map<String, dynamic> json) {
    return BookSearch(
      title: json['title'] as String,
      authors: (json['author_name'] as List<dynamic>)
          .map((name) => name.toString())
          .toList(),
      imageUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
          : '',
      firstPublishYear: json['first_publish_year'] ?? 0,
    );
  }
}
