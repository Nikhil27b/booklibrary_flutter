import 'dart:convert';
import 'package:booklibrary/model/book_model.dart';
import 'package:http/http.dart' as http;

class BookApiService {
  static Future<List<Book>> fetchBooks() async {
    const url =
        'https://openlibrary.org/people/ScarTissue/books/already-read.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final readingLogEntries = data['reading_log_entries'] as List;
      final books = readingLogEntries
          .take(25)
          .map((entry) => Book.fromJson(entry))
          .toList();
      return books;
    } else {
      throw Exception('Failed to load books from API');
    }
  }
}
