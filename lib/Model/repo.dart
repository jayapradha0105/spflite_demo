import 'package:intl/intl.dart';

class Repo {
  String? id;
  String? title;
  String? description;
  String? username;
  String? avatar;
  String? rating;

  Repo(
      {this.id,
      this.title,
      this.description,
      this.username,
      this.avatar,
      this.rating,
      });

  factory Repo.fromJson(Map<String, dynamic> parsedJson) {
    NumberFormat numberFormat = new NumberFormat.compact();
    var star = numberFormat.format(parsedJson['stargazers_count']);
    return Repo(
      id: parsedJson['id'].toString(),
      title: parsedJson['name'],
      description: parsedJson['description'],
      username: parsedJson['owner']['login'],
      avatar: parsedJson['owner']['avatar_url'],
      rating: star,
    );
  }

   factory Repo.fromDBJson(Map<String, dynamic> parsedJson) {
  //  print(parsedJson);
    return Repo(
      id: parsedJson['id'].toString(),
      title: parsedJson['title'],
      description: parsedJson['description'],
      username: parsedJson['username'],
      avatar: parsedJson['avatar'],
      rating: parsedJson['rating'],
    );
  }


  Map<String, dynamic> toJson() => {
        "id": this.id,
        "title": this.title,
        "description": this.description,
        "username": this.username,
        "avatar": this.avatar,
        "rating" : this.rating
      };

}
