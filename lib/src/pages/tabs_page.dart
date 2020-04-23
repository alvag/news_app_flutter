import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';
import 'package:news_app_flutter/src/pages/tab1_page.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _BottomNavigationBar(),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text('Para ti'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          title: Text('Encabezados'),
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageCtrl,
      physics: BouncingScrollPhysics(),
      onPageChanged: (i) => navigationModel.currentPage = i,
      children: <Widget>[Tab1Page(), Tab2Page()],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageCtrl = new PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    _pageCtrl.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageCtrl => _pageCtrl;
}
