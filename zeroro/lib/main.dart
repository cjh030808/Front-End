import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zeroro/presentation/routes/router.dart';

import 'core/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // //Supabase
  // await Supabase.initialize(
  // );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
