import 'package:flutter/material.dart';
import 'package:university_finder/result.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  static String country = '';

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('images/University.png', width: 200),
                      SizedBox(height: 10),
                      Text(
                        "Find The Best",
                        style: TextStyle(fontSize: 30, fontFamily: "Raleway"),
                      ),
                      Text(
                        "Universities",
                        style:
                            TextStyle(fontSize: 40, fontFamily: "Raleway-Bold"),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        onChanged: (data) {
                          MyHome.country = data;
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Material(
                        elevation: 5,
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          onPressed: () {
                            Navigator.pushNamed(context, 'result');
                          },
                          child: Text(
                            'Search',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Raleway-Bold",
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
