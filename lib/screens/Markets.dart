import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Drawer.dart';
import '../Items.dart';
import '../search.dart';
import 'package:news/backend/news.dart';
class Markets extends StatefulWidget {
  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  var newslist;
  bool _loading = true;
  void getNews() async {
    News news = News();
    await news.getnews();
    newslist = news.news;
    setState(() {
       _loading = false;
    });
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();


    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawers(),
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.black,
        title: Center(child: new Text("Weather Report")),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ArticleSearch());
            },
          ),
        ],
      ),
      body:_loading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.builder(
                itemCount: newslist.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Item(
                    imgUrl: newslist[index].urlToImage ?? "",
                    title: newslist[index].title ?? "",
                    desc: newslist[index].description ?? "",
                    content: newslist[index].content ?? "",
                    posturl: newslist[index].articleUrl ?? "",
                  );
                }),
          ),
        ),
      )
    );
  }
}




