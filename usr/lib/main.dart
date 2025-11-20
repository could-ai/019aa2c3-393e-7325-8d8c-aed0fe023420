import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/audio_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SavageEarsApp());
}

class SavageEarsApp extends StatelessWidget {
  const SavageEarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: MaterialApp(
        title: 'Savage Ears',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF121212), // Spotify-like dark background
          primaryColor: const Color(0xFF1DB954), // Spotify Green-ish
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF1DB954),
            secondary: const Color(0xFFBB86FC),
            surface: const Color(0xFF121212),
            background: const Color(0xFF121212),
          ),
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.dark().textTheme,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
