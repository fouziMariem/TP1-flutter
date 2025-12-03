import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../models/book.dart';

class BookService {
  Future<void> insertBook(Book book, String userEmail) async {
    Database database = await DatabaseHelper().database;

    await database.transaction((txn) async {
      // Check if book already exists for this user
      List<Map> existing = await txn.rawQuery(
        "SELECT * FROM book WHERE name = ? AND user_email = ?",
        [book.name, userEmail],
      );

      if (existing.isNotEmpty) {
        // Book exists, increment quantity
        int currentQuantity = existing[0]['quantity'] as int? ?? 1;
        await txn.rawUpdate(
          "UPDATE book SET quantity = ? WHERE name = ? AND user_email = ?",
          [currentQuantity + 1, book.name, userEmail],
        );
      } else {
        // Book doesn't exist, insert new row
        await txn.rawInsert(
          "INSERT INTO book(name, price, image, user_email, quantity) VALUES(?, ?, ?, ?, 1)",
          [book.name, book.price, book.image, userEmail],
        );
      }
    });
  }

  Future<List<Book>> fetchBasketBooks(String userEmail) async {
    Database database = await DatabaseHelper().database;
    List<Book> books = [];

    try {
      await database.transaction((txn) async {
        // Group by name and sum quantities, get the first id and other fields
        List<Map> list = await txn.rawQuery(
          "SELECT MIN(id) as id, name, price, image, SUM(quantity) as quantity "
          "FROM book WHERE user_email = ? "
          "GROUP BY name, price, image",
          [userEmail],
        );

        for (var element in list) {
          books.add(
            Book(
              element['name'] as String,
              element['price'] as int,
              element['image'] as String,
              id: element['id'] as int,
              quantity: element['quantity'] as int? ?? 1,
            ),
          );
        }
      });
    } catch (e) {
      // If quantity column doesn't exist, ensure it's added and retry
      if (e.toString().contains('no such column: quantity')) {
        DatabaseHelper dbHelper = DatabaseHelper();
        await dbHelper.resetDatabaseCache();
        database = await dbHelper.database;
        // The database getter will ensure the column exists now
        
        // Retry the original query
        await database.transaction((txn) async {
          List<Map> list = await txn.rawQuery(
            "SELECT MIN(id) as id, name, price, image, SUM(quantity) as quantity "
            "FROM book WHERE user_email = ? "
            "GROUP BY name, price, image",
            [userEmail],
          );

          for (var element in list) {
            books.add(
              Book(
                element['name'] as String,
                element['price'] as int,
                element['image'] as String,
                id: element['id'] as int,
                quantity: element['quantity'] as int? ?? 1,
              ),
            );
          }
        });
      } else {
        rethrow;
      }
    }

    return books;
  }

  Future<void> deleteBook(int id) async {
    Database database = await DatabaseHelper().database;
    await database.rawDelete('DELETE FROM book WHERE id = ?', [id]);
  }

  Future<void> decrementBookQuantity(String bookName, String userEmail) async {
    Database database = await DatabaseHelper().database;
    await database.transaction((txn) async {
      // Get current quantity
      List<Map> existing = await txn.rawQuery(
        "SELECT id, quantity FROM book WHERE name = ? AND user_email = ? LIMIT 1",
        [bookName, userEmail],
      );

      if (existing.isNotEmpty) {
        int currentQuantity = existing[0]['quantity'] as int? ?? 1;
        int bookId = existing[0]['id'] as int;

        if (currentQuantity > 1) {
          // Decrement quantity
          await txn.rawUpdate(
            "UPDATE book SET quantity = ? WHERE id = ?",
            [currentQuantity - 1, bookId],
          );
        } else {
          // Delete if quantity is 1
          await txn.rawDelete('DELETE FROM book WHERE id = ?', [bookId]);
        }
      }
    });
  }
}
