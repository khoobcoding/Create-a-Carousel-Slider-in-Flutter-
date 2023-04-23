  assets:
    - assets/
# Add this assets path in your pubspec.yaml 
# Add assets folder in your project
  
  
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
  int currentindex = 0;
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
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: assets.length,
                padEnds: false,
                pageSnapping: false,
                physics: BouncingScrollPhysics(),
                reverse: true,
                controller:
                    PageController(initialPage: 3, viewportFraction: 0.7),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        //  color: color[index],
                        borderRadius: BorderRadius.circular(25)),
                    child: Image.asset(
                      assets[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: assets.length,
                physics: BouncingScrollPhysics(),
                controller:
                    PageController(initialPage: 0, viewportFraction: 0.7),
                onPageChanged: (value) {
                  currentindex = value;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        //  color: color[index],
                        borderRadius: BorderRadius.circular(25)),
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
                  initialIndex: currentindex,
                  vsync: this),
              selectedColor: Colors.red,
              color: Colors.grey,
              borderStyle: BorderStyle.none,
            ),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller:
                    PageController(initialPage: 3, viewportFraction: 0.7),
                itemBuilder: (context, index) {
                  print(index % assets.length);
                  return Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        //  color: color[index],
                        borderRadius: BorderRadius.circular(25)),
                    child: Image.asset(
                      assets[index % assets.length],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ]),
        )));
  }
}
