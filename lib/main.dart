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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store App',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      initialRoute: AppRoutes.main,
      routes: {
        AppRoutes.main: (context) => MainPage(
              onToggleTheme: () {
                setState(() => isDark = !isDark);
              },
            ),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.library: (context) => const LibraryPage(),
        AppRoutes.basket: (context) => const BasketPage(),
        AppRoutes.details: (context) => const DetailsPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MainPage({required this.onToggleTheme, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  bool useTabBar = true;
  int bottomNavIndex = 0;
  late TabController tabController;

  final List<Widget> pages = const [
    HomePage(),
    LibraryPage(),
    BasketPage(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        useTabBar: useTabBar,
        onToggle: () {
          setState(() {
            useTabBar = !useTabBar;
          });
        },
      ),
      appBar: AppBar(
        title: const Text("Store INSAT"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
        bottom: useTabBar
            ? TabBar(
                controller: tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.home_outlined), text: "Home"),
                  Tab(icon: Icon(Icons.bookmark_outline), text: "Library"),
                  Tab(icon: Icon(Icons.shopping_bag), text: "Basket"),
                ],
              )
            : null,
      ),
body: useTabBar ? TabBarView( controller: tabController, children: pages, ) : pages[bottomNavIndex],      bottomNavigationBar: useTabBar
          ? null
          : BottomNavigationBar(
              currentIndex: bottomNavIndex,
              onTap: (index) {
                setState(() {
                  bottomNavIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark_outline), label: "Library"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket), label: "Basket"),
              ],
            ),
    );
  }
}


class CustomDrawer extends StatelessWidget {
  final bool useTabBar;
  final VoidCallback onToggle;

  const CustomDrawer({required this.useTabBar, required this.onToggle, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: Text(useTabBar ? 'Switch to Bottom Navigation' : 'Switch to Tab Bar'),
              onTap: onToggle,
            ),

            const Divider(),

          ],
        ),
      ),
    );
  }
}


class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late final TabController tabController;

  final List<Widget> pages = const [
    HomePage(),
    LibraryPage(),
    BasketPage(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined), text: "Home"),
            Tab(icon: Icon(Icons.bookmark_outline), text: "Library"),
            Tab(icon: Icon(Icons.shopping_bag), text: "Basket"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: pages,
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> pages = const [
    HomePage(),
    LibraryPage(),
    BasketPage(),
  ];

  var mCurrentIndex = 0;

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
