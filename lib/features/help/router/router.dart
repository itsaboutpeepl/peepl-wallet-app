import 'package:auto_route/auto_route.dart';
import 'package:peepl/features/screens/help.dart';

const helpTab = AutoRoute(
  path: 'help',
  name: 'helpTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      initial: true,
      page: HelpScreen,
    ),
  ],
);
