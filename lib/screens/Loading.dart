import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(152, 78, 51, 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.25,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/camelicon.png',
                    width: 330,
                    height: 150,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "جملي",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: height * 0.30,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    child: const CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
