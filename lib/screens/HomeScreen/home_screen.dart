import 'package:flutter/material.dart';
import '../../widgets/home_cell.dart';
import '../../models/book.dart';
import '../../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookData = [
      const Book("Moby Dick", 40, "assets/book1.png"),
      const Book("Atomic Habits", 30, "assets/book2.png"),
      const Book("The little prince", 25, "assets/book3.png"),
    ];
    return Scaffold(

      body: ListView.builder(
        itemCount: bookData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.details,
                arguments: bookData[index],
              );
            },
            child: HomeCell(bookData[index]),
          );
        },
      ),
    );
  }
}