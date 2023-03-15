import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/data/post_model.dart';
import 'package:news_app_flutter/ui/widgets/item_carousel.dart';
import 'package:news_app_flutter/ui/widgets/search_view.dart';
import 'package:shimmer/shimmer.dart';
import '../data/api_client.dart';
import '../data/category_model.dart';
import '../navigation/directions.dart';
import '../utils/colors.dart';
import 'di/di.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;
  final _searchController = TextEditingController();
  final newsClient = getIt.get<NewsClient>();
  var latestPosts = <PostModel>[];
  var categories = <CategoryModel>[];
  var selectedCategoryId = 0;
  var mainPosts = <PostModel>[];
  var error = false;
  var loading = true;
  var loadingCategory = true;

  _HomePageState();

  @override
  void initState() {
    loadCategory();
    loadLatestPosts();
    loadPosts(0, 30);
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SearchView(hint: "Kategoriya bo`yicha izlash", controller: _searchController,isEnable: true),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    "So`ngi yangiliklar",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'New York',
                        color: Colors.black),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Row(
                      children: const [
                        Text(
                          "Barchasi",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Nunito',
                              color: secondaryColor),
                        ),
                        SizedBox(width: 16),
                        Icon(
                          CupertinoIcons.arrow_right,
                          color: secondaryColor,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Builder(builder: (context) {
            return  ItemCarousel(posts: latestPosts, isLoading: loadingCategory);
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedCategoryId = categories[index].id;
                        loadPosts(categories[index].id, 30);
                        setState(() {});
                      },
                      child:Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: categories[index].id == selectedCategoryId
                                ? primaryColor
                                : Colors.white),
                        child: Center(
                          child: Text(
                            categories[index].name,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito',
                                color:
                                    categories[index].id == selectedCategoryId
                                        ? Colors.white
                                        : primaryTextColor),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Builder(builder: (context) {
            if (error) {
              return SliverToBoxAdapter(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://media.tenor.com/Wv6zVQPZFtcAAAAd/error.gif",
                ),
              );
            }
            if (loading) {
              return SliverToBoxAdapter(
                child: Shimmer.fromColors(
                    baseColor: Colors.blueGrey,
                    highlightColor: Colors.white30,
                    child: const SizedBox(
                      height: 170,
                      width: double.infinity,
                    ),
                  )
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      toInfoScreen(context, mainPosts[index]);
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4), BlendMode.darken),
                                child: Image.network(
                                  mainPosts[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 170,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      mainPosts[index].title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  const Expanded(flex:1,child: SizedBox()),
                                  SizedBox(
                                    child:Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            mainPosts[index].categoryName,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                          ),
                                          const Expanded(flex:1,child: SizedBox()),
                                          Text(
                                            mainPosts[index].postModified,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
                });
              }, childCount: mainPosts.length),
            );
          }),
        ],
      ),
    ));
  }

  Future<void> loadCategory() async {
    loadingCategory = true;
    var result = await newsClient.getCategories();
    error = result.isFailure;
    if (result.isSuccess) {
      categories = result.success;
      loadingCategory = false;
    } else {
      error = true;
    }
    setState(() {});
  }

  Future<void> loadPosts(int categoryId, int limit) async {
    loading = true;
    var result = await newsClient.getPostsByCategory(categoryId, limit);
    error = result.isFailure;
    if (result.isSuccess) {
      mainPosts = result.success;
      loading = false;
    }
    setState(() {});
  }

  Future<void> loadLatestPosts() async {
    var result = await newsClient.getPostsByCategory(0, 10);

    error = result.isFailure;
    if (result.isSuccess) {
      latestPosts = result.success;
    } else {
      error = true;
    }
    setState(() {});
  }
}
