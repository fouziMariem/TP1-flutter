import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../models/book.dart';

class BookService {
  Future<void> insertBook(Book book, String userEmail) async {
    Database database = await DatabaseHelper().database;

    await database.transaction((txn) async {
      await txn.rawInsert(
        "INSERT INTO book(name, price, image, user_email) VALUES(?, ?, ?, ?)",
        [book.name, book.price, book.image, userEmail],
      );
    });
  }

  Future<List<Book>> fetchBasketBooks(String userEmail) async {
    Database database = await DatabaseHelper().database;
    List<Book> books = [];

    await database.transaction((txn) async {
      List<Map> list = await txn.rawQuery(
        "SELECT * FROM book WHERE user_email = ?",
        [userEmail],
      );

      for (var element in list) {
        books.add(
          Book(
            element['name'] as String,
            element['price'] as int,
            element['image'] as String,
            id: element['id'] as int,
          ),
        );
      }
    });

    return books;
  }

  Future<void> deleteBook(int id) async {
    Database database = await DatabaseHelper().database;
    await database.rawDelete('DELETE FROM book WHERE id = ?', [id]);
  }
}
