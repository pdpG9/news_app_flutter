import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/navigation/directions.dart';
import 'package:news_app_flutter/ui/all%20posts/all_posts_provider.dart';
import 'package:news_app_flutter/ui/widgets/search_view.dart';
import 'package:shimmer/shimmer.dart';

class AllPostsPage extends StatefulWidget {
  const AllPostsPage({Key? key}) : super(key: key);

  @override
  State<AllPostsPage> createState() => _AllPostsPageState();
}

class _AllPostsPageState extends State<AllPostsPage> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SearchView(hint: "Kategoriya bo`yicha izlash", controller: _searchController,isEnable: true),
        ),
        Builder(builder: (context) {
          if (context.watch<AllPostsProvider>().status==PostState.fail) {
            return SliverToBoxAdapter(
              child: CachedNetworkImage(
                imageUrl:
                "https://media.tenor.com/Wv6zVQPZFtcAAAAd/error.gif",
              ),
            );
          }
          if (context.watch<AllPostsProvider>().status==PostState.loading) {
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
                return Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      toInfoScreen(context, context.watch<AllPostsProvider>().allPosts[index]);
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
                                  context.watch<AllPostsProvider>().allPosts[index].image,
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
                                      context.watch<AllPostsProvider>().allPosts[index].title,
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
                                            context.watch<AllPostsProvider>().allPosts[index].categoryName,
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
                                            context.watch<AllPostsProvider>().allPosts[index].postModified,
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
              });
            }, childCount: context.watch<AllPostsProvider>().allPosts.length),
          );
        }),
      ],
    );
  }
}
