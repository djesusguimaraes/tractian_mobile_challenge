import 'package:flutter/material.dart';

import 'ui/features/assets/assets.page.dart';
import 'ui/features/home/home.page.dart';
import 'ui/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) => MaterialApp(
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        title: 'TRACTIAN Mobile Challenge',
        routes: {AssetsPage.route: (_) => const AssetsPage()},
        home: const HomePage(),
      );
}
