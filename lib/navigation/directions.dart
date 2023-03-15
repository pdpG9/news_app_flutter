import 'package:flutter/material.dart';
import 'package:news_app_flutter/data/post_model.dart';
import 'package:news_app_flutter/data/rive_model.dart';
import 'package:news_app_flutter/ui/info/info_page.dart';

void toInfoScreen(BuildContext context, PostModel postModel){
  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(postModel)));
}

List<RiveAsset> bottomNavs = [
  RiveAsset(src: "assets/rive_icons/animated_icons.riv", artboard: "home", stateMachineName: "State Machine 1", title: "Home"),
  RiveAsset(src: "assets/rive_icons/animated_icons.riv", artboard: "favorite V3", stateMachineName: "State Machine 1", title: "Favourite"),
  RiveAsset(src: "assets/rive_icons/animated_icons.riv", artboard: "list", stateMachineName: "State Machine 1", title: "List"),
];