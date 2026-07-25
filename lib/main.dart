import 'dart:ui';

import 'package:book_adder_2/v_pages/project_v/va_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: const Locale("fa", "IR"),
      supportedLocales: const [Locale("fa", "IR"), Locale("en", "US")],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
        // appBarTheme: appBarTheme(color: Colors.blue),
        scaffoldBackgroundColor: Color(0xfffcfcfc),
        fontFamily: 'Pinar',
        textTheme: TextTheme(
          titleSmall: const TextStyle(fontWeight: .bold),
          titleMedium: const TextStyle(fontWeight: .bold),
          titleLarge: const TextStyle(fontWeight: .bold),
        ),
      ),
      home: ProjectV(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
