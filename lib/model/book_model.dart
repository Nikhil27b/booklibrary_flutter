class Book {
  final String title;
  final List<String> authors;
  final int firstPublishYear;
  final String imageUrl;

  Book({
    required this.title,
    required this.authors,
    required this.firstPublishYear,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final work = json['work'];
    final authorNames = work['author_names']?.cast<String>() ?? [];
    final coverId = work['cover_id'];
    final imageUrl = coverId != null
        ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
        : 'https://filetandvine.com/wp-content/uploads/2015/10/pix-vertical-placeholder.jpg';

    return Book(
      title: work['title'] as String,
      authors: authorNames,
      firstPublishYear: work['first_publish_year'] as int,
      imageUrl: imageUrl,
    );
  }
}
