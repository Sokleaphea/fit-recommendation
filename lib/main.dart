import 'package:flutter/material.dart';
import 'package:oshifit/controllers/app_controllers.dart';
import 'package:oshifit/models/favorite_model.dart';
import 'package:provider/provider.dart';
import 'package:oshifit/ui/screens/outfit_form.dart';

// void main() {
//   // runApp(const LocationScreen());
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       fontFamily: GoogleFonts.nunito().fontFamily,
//       textTheme:  GoogleFonts.nunitoSansTextTheme(),
//       scaffoldBackgroundColor: Color(0xFFFFF4E6)
//     ),
//     // home: OutfitBoardScreen()
//     // home: OutfitBoardScreen()
//     // home: HomeScreen(),
//     home: AppControllers(),
//     )
//   );
// }
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
    return const MaterialApp(home: OutfitForm());
  }
}
