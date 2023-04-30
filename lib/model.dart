

class NewsQueryModel {
  late String newsHead;
  late String newsDisc;
  late String newsImg;
  late String newsURL;

  NewsQueryModel(
      {this.newsHead = "NEWS HEADLINE",
      this.newsDisc = " NEWS DISCRIPTION",
      this.newsImg = "NEWS IMAGE",
      this.newsURL = "NEWS URL"});

  factory NewsQueryModel.fromMap(Map news) {
    return NewsQueryModel(
      newsHead: news["title"],
      newsDisc: news["description"],
      newsImg: news["urltoImage"],
      newsURL: news["url"]
    );
  }
}
