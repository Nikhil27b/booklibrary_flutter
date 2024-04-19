import 'package:booklibrary/model/seach_book_model.dart';
import 'package:booklibrary/services/search_api.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(List<BookSearch>) onSearch; // Define the onSearch parameter

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchTextController = TextEditingController();

  void _handleSearch(String query) async {
    try {
      final results = await BookApiServices.searchBooks(query: query);
      widget.onSearch(results);
    } catch (e) {
      // Handle error
      print('Error searching books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchTextController,
        decoration: InputDecoration(
          hintText: 'Search for books...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {
              _searchTextController.clear();
            },
            icon: const Icon(Icons.clear),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onSubmitted: _handleSearch,
      ),
    );
  }
}

class BookSearchScreen extends StatefulWidget {
  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  List<BookSearch> searchResults = [];

  void _onSearch(List<BookSearch> results) {
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Column(
        children: [
          SearchBar(onSearch: _onSearch),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final book = searchResults[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(', ')),
                  // You can customize how you want to display the search results here
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
