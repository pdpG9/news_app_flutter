import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app_flutter/utils/colors.dart';
import '../../data/post_model.dart';

class InfoPage extends StatelessWidget {
  final PostModel model;

  // final double sizeWidth;

  const InfoPage(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _isFirstClick = true;
    final data = DateTime.fromMillisecondsSinceEpoch(model.publishedAt * 1000);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          model.categoryName,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Nunito',
              overflow: TextOverflow.ellipsis,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(model.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito',
                        color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              Image.network(
                model.image,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Html(
                    data: model.content,
                  )),
              Row(
                children: [
                  Expanded(child: Container()),
                  Text("${data.day}.${data.month}.${data.year}",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Nunito',
                          color: primaryTextColor),
                      textAlign: TextAlign.right),
                ],
              ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _isFirstClick?
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("This feature has not worked yet."),
              ],
            ),
          )
          ):{_isFirstClick = false};
        },
        backgroundColor: primaryColor,
        child:const Icon(CupertinoIcons.heart)
      ),
    );
  }
}
