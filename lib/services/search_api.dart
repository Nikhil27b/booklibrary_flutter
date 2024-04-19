import 'dart:convert';
import 'package:booklibrary/model/seach_book_model.dart';
import 'package:http/http.dart' as http;

class BookApiServices {
  static const String baseUrl = 'https://openlibrary.org/search.json';

  static Future<List<BookSearch>> searchBooks({required String query}) async {
    final url = Uri.parse('$baseUrl?title=$query'); // Modify URL based on query
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final books = data['docs']
          ?.map((bookData) => BookSearch.fromJson(bookData))
          .toList();

      return books ?? [];
    } else {
      throw Exception('Failed to load books');
    }
  }
}
