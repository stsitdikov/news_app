import 'package:flutter/material.dart';
import 'constants.dart';
import 'article.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: kTitleTextStyle,
            ),
            kSizedBoxText,
            Text(
              article.date,
              style: kDateTextStyle,
            ),
            kSizedBoxText,
            Text(article.description),
            kSizedBoxText,
            // SizedBox(
            //   child: article.urlToImage != ''
            //       ? Image.network(article.urlToImage)
            //       : Container(),
            //   height: article.urlToImage != '' ? 150.0 : 0.0,
            //   width: article.urlToImage != '' ? 150.0 : 0.0,
            // ),
            Image.network(
              article.urlToImage,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Icon(Icons.image_not_supported_rounded);
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Icon(Icons.image);
              },
              frameBuilder: (BuildContext context, Widget child, int? frame,
                  bool wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
