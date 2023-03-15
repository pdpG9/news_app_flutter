
import 'package:flutter/material.dart';
import 'package:news_app_flutter/utils/colors.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Favourites'),backgroundColor: Colors.black,),
      body: const Center(child:  Text('This list is empty!',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'Nunito',
              color: primaryTextColor),
          textAlign: TextAlign.right),),
    );
  }
}
