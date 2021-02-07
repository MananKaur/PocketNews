import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_news/helper/data.dart';
import 'package:pocket_news/model/articleModel.dart';
import 'package:pocket_news/model/categoryModel.dart';
import 'package:pocket_news/helper/articles.dart';
import 'package:pocket_news/helper/tiles.dart';
import 'package:pocket_news/views/categoryNews.dart';

import 'article.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getBlogs();
  }

  getBlogs() async {
    Articles articleObj = Articles();
    await articleObj.getArticles();
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
            Text('News', style: TextStyle(color: Colors.pink))
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
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    //Categories
                    Container(
                      height: 70,
                      child: ListView.builder(
                          //scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(categories[index].categoryName,
                                categories[index].imageURL);
                          }),
                    ),

                    //Blogs
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
