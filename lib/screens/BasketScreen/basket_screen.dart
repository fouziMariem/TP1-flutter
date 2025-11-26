import 'package:flutter/material.dart';
import '../../services/book_service.dart';
import '../../services/user_service.dart';
import '../../models/book.dart';
import '../../models/user.dart';
import '../../widgets/home_cell.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  Future<List<Book>>? _basketList;
  final BookService _bookService = BookService();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    User? user = await _userService.getCurrentUser();
    if (user != null) {
      setState(() {
        _basketList = _bookService.fetchBasketBooks(user.email);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Basket")),
      body: _basketList == null
          ? const Center(child: Text("Please set up your profile"))
          : FutureBuilder<List<Book>>(
              future: _basketList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Empty Basket"));
                }

                final books = snapshot.data!;

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(books[index].id.toString()),
                      onDismissed: (direction) async {
                        await _bookService.deleteBook(books[index].id!);
                      },
                      background: Container(color: Colors.red),
                      child: HomeCell(books[index]),
                    );
                  },
                );
              },
            ),
    );
  }
}
