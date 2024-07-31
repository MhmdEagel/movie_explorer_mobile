import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_apps/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xff222831),
    secondary: const Color.fromARGB(255, 0, 85, 90)
  ),
  textTheme: GoogleFonts.montserratTextTheme(),
);

const String apiKey = '5e33d1e946697b6fa2f1aa36f86f1445';

void main() {
  runApp(
    const ProviderScope(child: MyApp())
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const Tabs(),
    );
  }
}
