import 'package:flutter/material.dart';
import 'package:news_app_flutter/navigation/directions.dart';
import 'package:news_app_flutter/ui/all%20posts/all_posts.dart';
import 'package:news_app_flutter/ui/all%20posts/all_posts_provider.dart';
import 'package:news_app_flutter/ui/favourite_page.dart';
import 'package:news_app_flutter/ui/home_page.dart';
import 'package:news_app_flutter/ui/main/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: context.watch<MainProvider>().index,
          children:  [const HomePage(), const FavouritePage(),
            ChangeNotifierProvider(create: (context)=>AllPostsProvider()..loadAllPosts(),child: const AllPostsPage(),)],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<MainProvider>().index,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: (value) {
            context.read<MainProvider>().onChangeTab(value);
          },
          items: [
            ...List.generate(
                bottomNavs.length,
                (index) => BottomNavigationBarItem(
                        icon: SizedBox(
                          width: 36,
                          height: 36,
                          child: RiveAnimation.asset(
                      bottomNavs[index].src,
                      artboard: bottomNavs[index]
                            .artboard,
                      controllers: [
                          getController(context.watch<MainProvider>().index,
                              context.watch<MainProvider>().oldSelected, index)
                      ],
                    ),
                        ),label:bottomNavs[context.watch<MainProvider>().index].artboard )
            )
          ],
        ),
      ),
    );
  }

  RiveAnimationController getController(int selected, int old, int index) {
    if (index == selected) {
      return SimpleAnimation('active');
    } else {
      if (old != selected) {
        return SimpleAnimation('unactive');
      } else {
        return SimpleAnimation('idle');
      }
    }
  }
}
