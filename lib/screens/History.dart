import 'package:flutter/material.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  static List<HistoryItem> HistoryItmes = [];

  //temp
  void initState() {
    //adding item to list, you can add using json from network
    HistoryItmes.add(HistoryItem(
        id: 1,
        breed: "مجاهيم",
        date: "2022-10-22",
        image: "assets/images/2.jpg"));
    HistoryItmes.add(HistoryItem(
        id: 2,
        breed: "وضح",
        date: "2022-10-22",
        image: "assets/images/wedeh_icon.png"));
    HistoryItmes.add(HistoryItem(
        id: 3,
        breed: "مجاهيم",
        date: "2022-10-22",
        image: "assets/images/2.jpg"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      backgroundColor: Mainbeige,
      body: // show the history list
          ListView.builder(
        itemCount: HistoryItmes.length,
        shrinkWrap: false,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //the brown background container
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Mainbrown,
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                        "نوع الجمل: ${HistoryItmes[index].breed}",
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
                        'التاريخ: ${HistoryItmes[index].date}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'DINNextLTArabic',
                          fontWeight: FontWeight.w400,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                      //delete button
                      const SizedBox(height: 25),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 1),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
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
                                        fontFamily: 'DINNextLTArabic',
                                        fontWeight: FontWeight.w400,
                                        color: Mainbrown,
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'تأكيد',
                                      style: TextStyle(
                                        fontFamily: 'DINNextLTArabic',
                                        fontWeight: FontWeight.w400,
                                        color: Mainbrown,
                                      ),
                                    ),
                                    //delete the image from the History list
                                    onPressed: () {
                                      HistoryItmes.removeWhere((element) {
                                        return element.id ==
                                            HistoryItmes[index].id;
                                      });
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage(HistoryItmes[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 110,
                    height: 110,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryItem {
  final int id;
  final String breed, date, image;

  HistoryItem({
    required this.id,
    required this.breed,
    required this.date,
    required this.image,
  });
}
