import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app_flutter/src/pages/tabs_page.dart';
import 'package:news_app_flutter/src/services/news_service.dart';
import 'package:news_app_flutter/src/theme/custom_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: customTheme,
        home: TabsPage(),
      ),
    );
  }
}
