import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/model.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<String> navbarItem = [
    "Top News",
    "India",
    "International",
    "Finance",
    "Health",
    "Technology"
  ];
  bool isLoading = true;
  getNewsQuery(String query) async {
    String url =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=dc690aae91c64a80b655976c389fda78";
    //"https://newsapi.org/v2/everything?q=$query&from=2023-04-28&sortBy=publishedAt&apiKey=dc690aae91c64a80b655976c389fda78";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STUDY NEWS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: navbarItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 21),
                      child: Text(
                        navbarItem[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: CarouselSlider(
                  items: newsModelList.map((instance) {
                    return Builder(builder: (BuildContext constext) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.network(
                                instance.newsImg,
                                fit: BoxFit.fill,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 20, bottom: 7),
                                  child: const Text(
                                    "NEWS HEADLINES",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    });
                  }).toList(),
                  options: CarouselOptions(
                      height: 180, autoPlay: true, enlargeCenterPage: true)),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 17, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "LATEST NEWS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)),
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(17),
                                child: Image.network(
                                    newsModelList[index].newsImg)),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 20, bottom: 7),
                                  child: Column(
                                    children: [
                                      Text(
                                        newsModelList[index].newsHead,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        newsModelList[index].newsDisc.length >
                                                50
                                            ? "${newsModelList[index].newsDisc.substring(0, 20)}..."
                                            : newsModelList[index].newsDisc,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: const Text("SHOW MORE"))
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  final List items = [
    Colors.orange,
    Colors.blue,
    Colors.yellowAccent,
    Colors.green
  ];
}
