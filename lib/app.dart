import 'package:flutter/material.dart';

import 'ui/features/assets/assets.page.dart';
import 'ui/features/home/home.page.dart';
import 'ui/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) => MaterialApp(
        title: 'TRACTIAN Mobile Challenge',
        debugShowCheckedModeBanner: false,
        routes: {AssetsPage.route: (_) => const AssetsPage()},
        home: const HomePage(),
        theme: AppTheme.light,
      );
}
