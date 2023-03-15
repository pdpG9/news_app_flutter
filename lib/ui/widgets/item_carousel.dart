
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/data/item_slider.dart';
import 'package:news_app_flutter/data/post_model.dart';
import 'package:shimmer/shimmer.dart';

class ItemCarousel extends StatelessWidget {
  final List<PostModel> posts;
  final bool isLoading;
  const ItemCarousel({Key? key, required this.posts, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return SizedBox(
          width: double.infinity,
          height: 240,
          child: Shimmer.fromColors(
            baseColor: Colors.blueGrey,
            highlightColor: Colors.white30,
            child: const SizedBox(
              height: 240,
              width: double.infinity,
            ),
          ),);
    }
    return SizedBox(
        width: double.infinity,
        height: 240,
        child: CarouselSlider(
        options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true),
    items: posts
        .map((item) => Builder(builder: (context) {
    return PostSliderItem(item);
    }))
        .toList(), //news
     ));
  }
}
