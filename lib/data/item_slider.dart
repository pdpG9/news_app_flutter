import 'package:flutter/material.dart';
import 'package:news_app_flutter/data/post_model.dart';

import '../navigation/directions.dart';
import 'post_model.dart';

class PostSliderItem extends StatelessWidget {
  final PostModel postModel;

  const PostSliderItem(this.postModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toInfoScreen(context, postModel);
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black87.withOpacity(0.5), BlendMode.darken),
              child: Image.network(
                postModel.image,
                fit: BoxFit.fill,
                height: double.infinity,
              ),
            ),
            SizedBox(
              height: 240,
              child: Column(
                children: [
                  const Expanded(flex:1,child: SizedBox()),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16),
                    child: Text(
                      postModel.categoryName,
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16),
                    child: Text(
                      postModel.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(height: 23),
                  SizedBox(
                    child:Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16),
                        child: Text(
                          postModel.excerpt,
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                        ),
                      ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
