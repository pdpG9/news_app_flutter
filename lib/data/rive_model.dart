import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  // final RiveAnimationController _controller = OneShotAnimation('idle', autoplay: false,);

  RiveAsset(
      {
      required this.src,
        required this.artboard,
      required this.stateMachineName,
      required this.title,
      });
  // RiveAnimationController getController(bool isActive){
  //   _controller.isActive = isActive;
  //   return _controller;
  // }
}
