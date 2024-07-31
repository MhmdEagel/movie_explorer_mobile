import 'package:flutter/material.dart';
import 'package:movie_apps/screens/favorite.dart';
import 'package:movie_apps/screens/movies.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = const MoviesScreen();
    String titleScreen = _currentScreenIndex == 0 ? "Explore Movies & TV Series" : "Your Favorites";

    _currentScreenIndex == 1
        ? currentScreen = const Favorite()
        : currentScreen = const MoviesScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleScreen,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            _currentScreenIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
        ],
        currentIndex: _currentScreenIndex,
      ),
    );
  }
}
