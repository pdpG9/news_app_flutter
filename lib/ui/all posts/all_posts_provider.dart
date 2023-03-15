import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/data/api_client.dart';
import 'package:news_app_flutter/data/category_model.dart';
import 'package:news_app_flutter/data/post_model.dart';
import 'package:news_app_flutter/ui/di/di.dart';

enum PostState { initial, loading, success, fail }

class AllPostsProvider extends ChangeNotifier {
  final _newsClient = getIt.get<NewsClient>();
  PostState status = PostState.initial;
  final List<PostModel> allPosts = [];
  final List<CategoryModel> categories = [];

  Future loadAllPosts() async {
    status = PostState.loading;
    await loadAllCategories();
    categories.forEach((element) async {
      final result = await _newsClient.getPostsByCategory(element.id, 30);
      if (result.isSuccess) {
        allPosts.addAll((result.success));
        allPosts.shuffle();
        print(allPosts.length);
        status = PostState.success;
        notifyListeners();
      }
    });
  }

  Future loadAllCategories() async {
    final result = await _newsClient.getCategories();
    if (!result.isSuccess) {
      status = PostState.fail;
      return;
    } else {
      categories.addAll((result.success));
    }
  }
}
