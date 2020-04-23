import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/models/category_model.dart';
import 'package:news_app_flutter/src/services/news_service.dart';
import 'package:news_app_flutter/src/theme/custom_theme.dart';
import 'package:news_app_flutter/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);
    newsService.getArticlesByCategory(newsService.selectedCategory);
    final articles = newsService.articlesBySelectedCategory;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _CategoryList(),
            Expanded(
              child: (articles.length == 0)
                  ? Center(child: CircularProgressIndicator())
                  : NewsList(articles),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, i) {
          String categoryName = categories[i].name;
          categoryName =
              '${categoryName[0].toUpperCase()}${categoryName.substring(1)}';
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _CategoryIcon(categories[i]),
                SizedBox(height: 5.0),
                Text(categoryName)
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final Category category;

  const _CategoryIcon(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (category.name == newsService.selectedCategory)
              ? customTheme.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
