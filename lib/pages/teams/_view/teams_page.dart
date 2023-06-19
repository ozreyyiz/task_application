import 'package:flutter/material.dart';
import 'package:task_list_app/common/extensions/string_extension.dart';
import 'package:task_list_app/common/lang/locale_keys.g.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // TODO: labels should be in app localization file
      child: Text(LocaleKeys.home_teams.locale),
    );
  }
}
