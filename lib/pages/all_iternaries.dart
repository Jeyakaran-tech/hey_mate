import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllItinerariesPage extends StatefulWidget {
  const AllItinerariesPage({Key? key}) : super(key: key);

  @override
  _AllItinerariesPageState createState() => _AllItinerariesPageState();
}

class _AllItinerariesPageState extends State<AllItinerariesPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late List<DocumentSnapshot> itineraries = [];

  @override
  void initState() {
    super.initState();
    fetchItineraries();
  }

  Future<void> fetchItineraries() async {
    QuerySnapshot snapshot =
        await firestore.collection('myIternary').get();
    setState(() {
      itineraries = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Itineraries'),
      ),
      body: itineraries == List.empty()
          ? Center(child: CircularProgressIndicator())
          : CarouselSlider.builder(
              itemCount: itineraries.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   itineraries[index]['title'],
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      // SizedBox(height: 10),
                      Text(itineraries[index]['FirstName']),
                      SizedBox(height: 10),
                      Text(itineraries[index]['LastName']),
                      SizedBox(height: 10),
                      Text(itineraries[index]['Date of Departure'].toDate().toString()),
                    ],
                  ),
              
                );
              },
              options: CarouselOptions(
                height: 500,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  print(index);
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
    );
  }
}
