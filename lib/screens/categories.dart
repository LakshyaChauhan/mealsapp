import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          titleTextStyle: GoogleFonts.aldrich(fontSize: 20),
          title: const Text('Meals App'),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: const [
            Text(
              '1',
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              '2',
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              '2',
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              '4',
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              '5',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ));
  }
}
