import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/models/news_models.dart';
import 'package:news_app_flutter/src/theme/custom_theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> articles;

  const NewsList(this.articles);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.articles.length,
      itemBuilder: (context, i) {
        return _News(
          article: articles[i],
          index: i,
        );
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article article;
  final int index;

  const _News({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TopBarCard(article: article, index: index),
        _CardTitle(article),
        _CardImage(article.urlToImage),
        _NewsBody(article),
        SizedBox(height: 10.0),
        Divider(),
        _CardButtons()
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article article;
  final int index;

  const _TopBarCard({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: customTheme.accentColor),
          ),
          Text(
            '${article.source.name}. ',
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article article;

  const _CardTitle(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        article.title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String newsImage;

  const _CardImage(this.newsImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        child: Container(
          child: FadeInImage(
            placeholder: AssetImage('assets/images/giphy.gif'),
            image: (newsImage != null)
                ? NetworkImage(newsImage)
                : AssetImage('assets/images/no-image.png'),
          ),
        ),
      ),
    );
  }
}

class _NewsBody extends StatelessWidget {
  final Article article;

  const _NewsBody(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text((article.description != null) ? article.description : ''),
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            child: Icon(Icons.star_border),
            fillColor: customTheme.accentColor,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
          SizedBox(width: 10.0),
          RawMaterialButton(
            child: Icon(Icons.more),
            fillColor: Colors.blue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
        ],
      ),
    );
  }
}
