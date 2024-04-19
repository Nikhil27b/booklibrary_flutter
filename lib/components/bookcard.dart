import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard({
    Key? key,
    required this.image,
    required this.title,
    required this.published_year,
    required this.author,
  }) : super(key: key);

  final String image;
  final String title;
  final String published_year;
  final String author;

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isRead = false;

  void onPress() {
    setState(() {
      isRead = !isRead;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.7,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(vertical: 12.0),
                    child: Text(
                      widget.author,
                      style: const TextStyle(
                          color: Color(0xff61656A), fontSize: 13),
                    ),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'Publish Year: ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: widget.published_year,
                                style:
                                    const TextStyle(color: Color(0xff1867FF))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextButton(
                      onPressed: onPress,
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isRead ? Colors.green : Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 4.0),
                        child: Text(
                          isRead ? 'Read' : 'Unread',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.network(
            widget.image,
            height: 200,
            width: 130,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
