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
    return const BottomNavBar();
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> pages = [
    const HomePage(),
    const LibraryPage(),
    const BasketPage(),
  ];

  var mCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[mCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mCurrentIndex,
        onTap: (value) {
          setState(() {
            mCurrentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Basket",
          ),
        ],
      ),
    );
  }
}
