import 'package:flutter/material.dart';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scr_flutter_technical_test_opcion_b_app/config/router/app_router.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/config/theme/app_theme.dart';
import 'package:scr_flutter_technical_test_opcion_b_app/env/env.dart';

void main() {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;
  // Ref providers in riverpod
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppThemeCustom().getTheme(),
    );
  }
}
