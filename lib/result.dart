import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:university_finder/home.dart';

class MyResult extends StatefulWidget {
  const MyResult({Key? key}) : super(key: key);

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  List<dynamic> universities = [];
  var country = '';
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    country = MyHome.country;
    getData();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      var url =
          Uri.parse('http://universities.hipolabs.com/search?country=$country');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          universities = data;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to fetch data from the API';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Universities in $country",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Raleway-Bold"),
        ),
        backgroundColor: Colors.blueAccent,
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.transparent,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : universities.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Image.asset('images/error.png', width: 300),
                          Text(
                            "OOPS!",
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: "Raleway-Bold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "You Lost in space.",
                            style:
                                TextStyle(fontSize: 20, fontFamily: "Raleway"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 5,
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              onPressed: () {
                                Navigator.pushNamed(context, 'home');
                              },
                              child: Text(
                                'Go Home',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Raleway-Bold",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ))
                    : ListView.builder(
                        itemCount: universities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              child: Card(
                                elevation: 2 ,
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        universities[index]['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Raleway-Bold",
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        universities[index]['country'],
                                        style: TextStyle(
                                          fontFamily: "Raleway",
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${universities[index]['web_pages'][0]}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontFamily: "Raleway"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
      ),
    );
  }
}
