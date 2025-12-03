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
                    final book = books[index];
                    return Dismissible(
                      key: Key('${book.name}_${book.id}'),
                      onDismissed: (direction) async {
                        User? user = await _userService.getCurrentUser();
                        if (user != null) {
                          await _bookService.decrementBookQuantity(
                            book.name,
                            user.email,
                          );
                          _loadData();
                        }
                      },
                      background: Container(color: Colors.red),
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  book.image,
                                  width: 100,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    book.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${book.price}TND",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Quantity: ${book.quantity}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
