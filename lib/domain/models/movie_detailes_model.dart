class MovieDetailesModel {
  String? id;
  String? reviewApiPath;
  String? imdb;
  String? contentType;
  String? title;
  String? image;
  String? plot;
  Rating? rating;
  String? contentRating;
  List<String>? genre;
  String? year;
  String? runtime;
  List<String>? actors;
  List<String>? directors;
  List<TopCredits>? topCredits;

  MovieDetailesModel(
      {this.id,
      this.reviewApiPath,
      this.imdb,
      this.contentType,
      this.title,
      this.image,
      this.plot,
      this.rating,
      this.contentRating,
      this.genre,
      this.year,
      this.runtime,
      this.actors,
      this.directors,
      this.topCredits});

  MovieDetailesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewApiPath = json['review_api_path'];
    imdb = json['imdb'];
    contentType = json['contentType'];
    title = json['title'];
    image = json['image'];
    plot = json['plot'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    contentRating = json['contentRating'];
    genre = json['genre'].cast<String>();
    year = json['year'];
    runtime = json['runtime'];
    actors = json['actors'].cast<String>();
    directors = json['directors'].cast<String>();
    if (json['top_credits'] != null) {
      topCredits = <TopCredits>[];
      json['top_credits'].forEach((v) {
        topCredits!.add(new TopCredits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review_api_path'] = this.reviewApiPath;
    data['imdb'] = this.imdb;
    data['contentType'] = this.contentType;
    data['title'] = this.title;
    data['image'] = this.image;
    data['plot'] = this.plot;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    data['contentRating'] = this.contentRating;
    data['genre'] = this.genre;
    data['year'] = this.year;
    data['runtime'] = this.runtime;
    data['actors'] = this.actors;
    data['directors'] = this.directors;
    if (this.topCredits != null) {
      data['top_credits'] = this.topCredits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rating {
  int? count;
  num? star;

  Rating({this.count, this.star});

  Rating.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['star'] = this.star;
    return data;
  }
}

class TopCredits {
  String? name;
  List<String>? value;

  TopCredits({this.name, this.value});

  TopCredits.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
