import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'article.dart';
import 'news_tile.dart';
import 'news_tile_placeholder.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late ScrollController controller;
  String currentTime = DateTime.now()
      .subtract(const Duration(days: 1))
      .toUtc()
      .toIso8601String();
  List<Article> listOfArticles = [];

  void getData({required bool initial}) async {
    int linkPage = 1;
    List<Article> newList = [];
    if (initial == false) {
      linkPage = listOfArticles.length ~/ 5 + 1;
    }
    try {
      http.Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=android&from=2019-04-00&to=$currentTime&sortBy=publishedAt&apiKey=26eddb253e7840f988aec61f2ece2907&pageSize=5&page=$linkPage#'));
      if (response.statusCode == 200) {
        for (int i = 0; i < 5; i++) {
          newList
              .add(Article.fromJson(jsonDecode(response.body)['articles'][i]));
        }
        setState(() {
          listOfArticles.addAll(newList);
        });
      } else {
        print(response.body);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      getData(initial: false);
    }
  }

  @override
  void initState() {
    super.initState();
    getData(initial: true);
    controller = ScrollController();
    controller.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: listOfArticles.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: listOfArticles.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < listOfArticles.length) {
                        return NewsTile(article: listOfArticles[index]);
                      } else {
                        return const NewsTilePlaceholder();
                      }
                    },
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: const [
                NewsTilePlaceholder(),
                NewsTilePlaceholder(),
                NewsTilePlaceholder(),
              ],
            ),
    );
  }
}
