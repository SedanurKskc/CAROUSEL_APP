import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<String>> products = [
    [
      "assets/images/watch-1.jpg",
      "Hugo Boss Oxygen",
      "100\$",
    ],
    [
      "assets/images/watch-2.jpg",
      "Hugo Boss Signature",
      "120\$",
    ],
    [
      "assets/images/watch-3.jpg",
      "Casio G-Shock Premium",
      "80\$",
    ],
  ];
  int currentIndex = 0;
  void _next() {
    setState(() {
      if (currentIndex < products.length - 1) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _preve() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _preve();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _next();
                }
              },
              child: Container(
                width: double.infinity,
                height: 550,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(products[currentIndex][0]),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                    Color.fromARGB(255, 97, 97, 97).withOpacity(.9),
                    Colors.grey.withOpacity(.0),
                  ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 60),
                        width: 90,
                        child: Row(
                          children: _buildIndicator(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -40),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[currentIndex][1],
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            products[currentIndex][2],
                            style: TextStyle(
                                color: Colors.yellow[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow[700],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("(4.2/70 reviews)",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            "ADD TO CART",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ))
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

//indicator sayfa geçiş belirteci
  Widget _indicator(bool isActive) {
    return Expanded(
        child: Container(
      height: 4,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isActive ? Colors.grey[800] : Colors.white),
    ));
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < products.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
