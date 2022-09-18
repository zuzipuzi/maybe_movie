import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/screens/favorites/favorites_screen.dart';
import 'package:maybe_movie/src/presentation/screens/home/home_screen.dart';
import 'package:maybe_movie/src/presentation/screens/profile/profile_screen.dart';
import 'package:maybe_movie/src/presentation/screens/search/search_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomBarItem(
              context,
              HomeScreen.screenName,
              "assets/images/tape.svg",
              0,
              LocaleKeys.tape,
              false,
            ),
            _buildBottomBarItem(
              context,
              SearchScreen.screenName,
              "assets/images/search.svg",
              1,
              LocaleKeys.search,
              false,
            ),
            _buildBottomBarItem(
              context,
              FavoritesScreen.screenName,
              "assets/images/favorites.svg",
              2,
              LocaleKeys.favorites,
              true,
            ),
            _buildBottomBarItem(
              context,
              ProfileScreen.screenName,
              "assets/images/profile.svg",
              3,
              LocaleKeys.profile,
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBarItem(
    BuildContext context,
    String screenName,
    String image,
    int index,
    String title,
    bool favorites,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Beamer.of(context).beamToNamed(
          screenName,
          transitionDelegate: const NoAnimationTransitionDelegate(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Column(
          children: [
            SvgPicture.asset(
              favorites
                  ? index == currentIndex
                      ? "assets/images/favorites_full.svg"
                      : image
                  : image,
              width: 26,
              height: 26,
              color: index == currentIndex
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.primary,
            ),
            Text(
              title.toLowerCase(),
              style: theme.textTheme.subtitle2!.copyWith(
                color: index == currentIndex
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
