import 'package:flutter/material.dart';

class ListItems {
  String imageURL;
  String imageName;

  ListItems({required this.imageURL, required this.imageName});

  Map<String, dynamic> toMap() {
    return {'imageURL': imageURL, 'imageName': imageName};
  }

  String toString() {
    return '{imageURL :$imageURL , imageName :$imageName}';
  }
}
