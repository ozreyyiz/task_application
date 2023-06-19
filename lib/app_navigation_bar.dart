import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:task_list_app/common/extensions/string_extension.dart';
import 'package:task_list_app/common/lang/locale_keys.g.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppStyle.darkBlue,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 64),
        itemCount: navigationBarItems.length,
        itemBuilder: (context, index) => _NavigationBarListItem(
          item: navigationBarItems[index],
        ),
        separatorBuilder: (context, index) => Divider(
          color: AppStyle.mediumBlue,
          height: 1,
          endIndent: 16,
          indent: 16,
        ),
      ),
    );
  }
}

class _NavigationBarListItem extends StatefulWidget {
  const _NavigationBarListItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final NavigationBarItem item;

  @override
  State<_NavigationBarListItem> createState() => _NavigationBarListItemState();
}

class _NavigationBarListItemState extends State<_NavigationBarListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/${widget.item.url}");
     
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          widget.item.name,
          style: TextStyle(
            color: AppStyle.lightTextColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

final navigationBarItems = [
  // TODO: labels should be in app localization file
  NavigationBarItem(name: LocaleKeys.home_tasks.locale, url: 'tasks'),
  NavigationBarItem(name: LocaleKeys.home_projects.locale, url: 'projects'),
  NavigationBarItem(name: LocaleKeys.home_teams.locale, url: 'teams'),
];

class NavigationBarItem {
  final String name;
  final String url;

  NavigationBarItem({required this.name, required this.url});
}
