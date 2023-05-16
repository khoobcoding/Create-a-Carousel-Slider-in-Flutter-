// Carousel Slider ( Part 2 )

import 'dart:async';
import 'package:flutter/material.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider>
    with TickerProviderStateMixin {
  List<String> assets = [
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png'
  ];
  final color = [
    Colors.red,
    Colors.amber,
    Colors.teal,
    Colors.blueGrey,
    Colors.blue,
  ];

  int myfirstcurrentindex = 0;
  PageController myfirstpagecontroller =
      PageController(initialPage: 0, viewportFraction: 0.8);
  bool isreverse = false;

  myfirstfunction() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (myfirstcurrentindex == 4) {
        isreverse = true;
      } else if (myfirstcurrentindex == 0) {
        isreverse = false;
      }
      isreverse ? myfirstcurrentindex-- : myfirstcurrentindex++;
      myfirstpagecontroller.animateToPage(myfirstcurrentindex,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  int secondecurrentindex = 3;
  PageController mysecondcontroller =
      PageController(initialPage: 3, viewportFraction: 0.7);
  mysecondfunction() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      secondecurrentindex++;
      mysecondcontroller.animateToPage(secondecurrentindex,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }

  int thirdcurrentindex = 3;
  PageController mythirdcontroller =
      PageController(initialPage: 3, viewportFraction: 0.7);
  bool isstop = false;
  mythirdfunction() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      isstop ? 0 : thirdcurrentindex++;
      mythirdcontroller.animateToPage(thirdcurrentindex,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }

  @override
  void initState() {
    super.initState();
    myfirstfunction();
    mysecondfunction();
    mythirdfunction();
  }

  @override
  void dispose() {
    super.dispose();
    myfirstpagecontroller.dispose();
    mysecondcontroller.dispose();
    mythirdcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: const Text("Carousel Slider",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(children: [
            //% AutoPlay Carousel Slider with Page indicator Foreward and Backward

            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: assets.length,
                physics: const BouncingScrollPhysics(),
                controller: myfirstpagecontroller,
                onPageChanged: (value) {
                  myfirstcurrentindex = value;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      assets[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            TabPageSelector(
              controller: TabController(
                  length: assets.length,
                  vsync: this,
                  initialIndex: myfirstcurrentindex),
            ),

            //% Infinite Autoplay Carousel Slider With Page indicator

            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                physics:
                    const BouncingScrollPhysics(), //for not scrollable NeverScrollableScrollPhysics()
                controller: mysecondcontroller,
                onPageChanged: (value) {
                  secondecurrentindex = value;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      assets[index % assets.length],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            TabPageSelector(
              controller: TabController(
                  length: assets.length,
                  vsync: this,
                  initialIndex: secondecurrentindex % assets.length),
            ),
            //% Infinite Autoplay Carousel Slider With Page indicator
            //% Pause & Stop on long press

            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                physics:
                    const BouncingScrollPhysics(), //for not scrollable NeverScrollableScrollPhysics()
                controller: mythirdcontroller,
                pageSnapping: false,
                onPageChanged: (value) {
                  thirdcurrentindex = value;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      isstop = true;
                      setState(() {});
                    },
                    onLongPressEnd: (details) {
                      isstop = false;
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset(
                        assets[index % assets.length],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            TabPageSelector(
              controller: TabController(length:
              assets.length, vsync: this,initialIndex: thirdcurrentindex%assets.length),
            )
          ]),
        )));
  }
}
