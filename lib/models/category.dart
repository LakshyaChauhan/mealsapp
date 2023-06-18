import 'package:flutter/material.dart';

class Category {
  Category({required this.id, required this.title, this.color = Colors.orange});

  String id;
  String title;
  Color color;
}
