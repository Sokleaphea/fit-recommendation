import 'package:flutter/material.dart';
import 'package:oshifit/controllers/app_controllers.dart';
import 'package:oshifit/models/favorite_model.dart';
import 'package:provider/provider.dart';
void main() {
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppControllers()
    );
  }
}
