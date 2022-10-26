import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromRGBO(137, 115, 88, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 300,
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
                height: 200,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: const CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
