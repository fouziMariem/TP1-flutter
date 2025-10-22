import 'package:flutter/material.dart';
import '../../widgets/home_cell.dart';
import '../../models/book.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        title: const Text(
          "Store INSAT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children:[
          HomeCell(Book("Moby Dick",40,"assets/book1.png")),
          HomeCell(Book("Atomic Habits",30,"assets/book2.png")),
          HomeCell(Book("The little prince",25,"assets/book3.png")),

        ],
      ),
    );
  }
}
