import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewsTilePlaceholder extends StatelessWidget {
  const NewsTilePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: const SizedBox(
          child: Center(
            child: SpinKitFadingGrid(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
