class Movie {
  int id = 0;
  String title = "";
  String posterPath = "";

  Movie(this.id, this.title, this.posterPath);

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['poster_path'] = posterPath;
    return data;
  }
}
