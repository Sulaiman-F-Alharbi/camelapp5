import 'dart:convert';

import 'package:flutter/material.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class SQLiteDB {
  Future getTotal(String breed) async {
    var url = 'http://ec2-44-201-201-139.compute-1.amazonaws.com/get' +
        breed +
        '.php';
    http.Response response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    print("=========" + data.toString() + "=========");
    return data;
  }

  Future insertImageDB(
      String Image_id, String breed, String date, String UserID) async {
    var url =
        'http://ec2-44-201-201-139.compute-1.amazonaws.com/insert_image.php';
    var res = await http.post(Uri.parse(url), body: {
      "Image_id": Image_id,
      "Breed": breed,
      "Date": date,
      "User_id": UserID,
    });
    print('body: [${res.body}]');
  }
}
