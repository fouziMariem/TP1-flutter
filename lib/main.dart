import 'package:flutter/material.dart';
import 'screens/HomeScreen/home_screen.dart';
import 'screens/LibraryScreen/library_screen.dart';
import 'screens/DetailsScreen/details_screen.dart';
import 'screens/BasketScreen/basket_screen.dart';

class AppRoutes {
  static const String main = '/';
  static const String home = '/home';
  static const String library = '/library';
  static const String basket = '/basket';
  static const String details = '/details';
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.main,
      routes: {
        AppRoutes.main: (context) => const MainPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.library: (context) => const LibraryPage(),
        AppRoutes.basket: (context) => const BasketPage(),
        AppRoutes.details: (context) => const DetailsPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyTabBar();
  }
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,  // Number of tabs
      child: Scaffold(
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
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home_outlined), text: "Home"),
              Tab(icon: Icon(Icons.bookmark_outline), text: "Library"),
              Tab(icon: Icon(Icons.shopping_bag), text: "Basket"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            LibraryPage(),
            BasketPage(),
          ],
        ),
      ),
    );
  }
}
