import 'package:flutter/material.dart';
import 'package:pocket_news/helper/articles.dart';
import 'package:pocket_news/helper/tiles.dart';
import 'package:pocket_news/model/articleModel.dart';

class CategoryNews extends StatefulWidget {
  String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBlogs();
  }

  getBlogs() async {
    CategoryArticles articleObj = CategoryArticles();
    await articleObj.getArticles(widget.category);
    articles = articleObj.articles;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pocket'),
            Text('News', style: TextStyle(color: Colors.pink)),
            SizedBox(width: 40)
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                                imageURL: articles[index].urlImage,
                                desc: articles[index].description,
                                title: articles[index].title,
                                url: articles[index].url);
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
