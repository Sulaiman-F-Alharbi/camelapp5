import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camelapp/services/HistoryItem.dart';
import 'dart:math';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

// const Mainbrown = Color.fromRGBO(204, 123, 76, 1);
// const Mainbrown = Color.fromRGBO(137, 115, 88, 1);
const Mainbrown = const Color.fromRGBO(142, 99, 83, 0.7);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class History extends StatefulWidget {
  const History({super.key});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late SharedPreferences prefs;
  List HistoryItems = [];

  setupHistory() async {
    prefs = await SharedPreferences.getInstance();
    String? stringHistroy = prefs.getString('HistoryI');
    List HistoryList = jsonDecode(stringHistroy!);
    for (var HistoryI in HistoryList) {
      setState(() {
        HistoryItems.add(HistoryItem(breed: '', date: '', id: 0, image: '')
            .fromJson(HistoryI));
      });
    }
  }

  void saveHistory() {
    List items = HistoryItems.map((e) => e.toJson()).toList();
    prefs.setString('HistoryI', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupHistory();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      body: Container(
        //Background Image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment(0.9, 0),
              child: Container(
                height: 40,
                width: 125,
                decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 68, 166, 231),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Align(
                        alignment: Alignment(0, 0.3),
                        child: Icon(
                          Icons.history,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        ":السجل",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'DINNextLTArabic',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // show the history list
              child: ListView.builder(
                itemCount: HistoryItems.length,
                shrinkWrap: false,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent.withOpacity(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    //the brown background container
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Mainbrown,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                textDirection: TextDirection.rtl,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //the text for the camel type
                                  Text(
                                    "نوع الجمل: ${HistoryItems[index].breed}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'DINNextLTArabic',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'التاريخ: ${HistoryItems[index].date}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'DINNextLTArabic',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                  //delete button
                                  const SizedBox(height: 45),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 1),
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        height: 20,
                                        width: 40,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                              'تأكيد حذف الصورة؟',
                                              style: TextStyle(
                                                fontFamily: 'DINNextLTArabic',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textDirection: TextDirection.rtl,
                                            ),
                                            //popup view to make sure the user wants to delete
                                            actions: [
                                              TextButton(
                                                child: const Text(
                                                  'إلغاء',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'DINNextLTArabic',
                                                    fontWeight: FontWeight.w400,
                                                    color: Mainbrown,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                              TextButton(
                                                child: const Text(
                                                  'تأكيد',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'DINNextLTArabic',
                                                    fontWeight: FontWeight.w400,
                                                    color: Mainbrown,
                                                  ),
                                                ),
                                                //delete the image from the History list
                                                onPressed: () {
                                                  HistoryItems.removeWhere(
                                                      (element) {
                                                    return element.id ==
                                                        HistoryItems[index].id;
                                                  });
                                                  saveHistory();
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              //the Image
                              FutureBuilder<dynamic>(
                                  future: loadImage(HistoryItems[index].image),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        width: 150,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            image: FileImage(snapshot.data),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadImage(String fileName) async {
    final String path = (await getApplicationDocumentsDirectory()).path;

    if (File('$path/$fileName').existsSync()) {
      print("Image exists. Loading it...");

      File image = File('$path/$fileName');
      return image;
    }
  }
}
