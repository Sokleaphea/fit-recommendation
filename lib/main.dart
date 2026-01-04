import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oshifit/controllers/app_controllers.dart';
import 'package:oshifit/models/favorite_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FavoriteModel())],
      child: const Oshifit(),
    ),
  );
}

class Oshifit extends StatelessWidget {
  const Oshifit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)),
      home: const AppControllers(),
    );
  }
}
