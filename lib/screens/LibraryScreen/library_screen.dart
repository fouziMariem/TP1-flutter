import 'package:flutter/material.dart';
import '../../widgets/library_cell.dart';
import '../../models/book.dart';
import '../DetailsScreen/details_screen.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      const Book("Moby Dick", 40, "assets/book1.png"),
      const Book("Atomic Habits", 30, "assets/book2.png"),
      const Book("The little prince", 25, "assets/book3.png"),
      const Book("1984", 35, "assets/book1.png"),
      const Book("To Kill a Mockingbird", 45, "assets/book2.png"),
      const Book("Pride and Prejudice", 38, "assets/book3.png"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        centerTitle: true,
        title: const Text(
          "Library",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(book: books[index]),
                ),
              );
            },
            child: LibraryCell(books[index]),
          );
        },
      ),
    );
  }
}
