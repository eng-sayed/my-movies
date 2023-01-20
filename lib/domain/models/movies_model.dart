class MoviesModel {
  String? id;
  String? title;
  int? year;
  String? type;
  String? image;
  String? imageLarge;
  String? apiPath;
  String? imdb;

  MoviesModel(
      {this.id,
      this.title,
      this.year,
      this.type,
      this.image,
      this.imageLarge,
      this.apiPath,
      this.imdb});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    type = json['type'];
    image = json['image'];
    imageLarge = json['image_large'];
    apiPath = json['api_path'];
    imdb = json['imdb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['year'] = this.year;
    data['type'] = this.type;
    data['image'] = this.image;
    data['image_large'] = this.imageLarge;
    data['api_path'] = this.apiPath;
    data['imdb'] = this.imdb;
    return data;
  }
}
