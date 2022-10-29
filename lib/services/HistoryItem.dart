import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class HistoryItem {
  int id;
  String breed;
  String date;
  String image;

  HistoryItem(
      {required this.id,
      required this.breed,
      required this.date,
      required this.image}) {
    id = this.id;
    breed = this.breed;
    date = this.date;
    image = this.image;
  }

  toJson() {
    return {"id": id, "breed": breed, "date": date, "image": image};
  }

  fromJson(jsonData) {
    return HistoryItem(
        id: jsonData['id'],
        breed: jsonData['breed'],
        date: jsonData['date'],
        image: jsonData['image']);
  }
}
