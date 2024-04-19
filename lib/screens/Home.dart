import 'package:booklibrary/components/bookcard.dart';

import 'package:booklibrary/services/book_api.dart';

import 'package:flutter/material.dart';
import 'package:booklibrary/model/book_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> _books = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    try {
      final fetchedBooks = await BookApiService.fetchBooks();

      setState(() {
        _books = fetchedBooks;

        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator

          : _books.isEmpty
              ? Center(
                  child: Text('No books found')) // Handle empty list gracefully

              : ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];

                    return BookCard(
                      image: book.imageUrl,
                      title: book.title,
                      published_year: book.firstPublishYear.toString(),
                      author: book.authors.join(', '),
                    );
                  },
                ),
    );
  }
}
