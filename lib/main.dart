import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/dependency_injection.dart' as di;

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.injectDependencies();
  runApp(const App());
}
