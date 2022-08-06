import 'dart:convert';
import 'package:thiran_demo/Model/repo.dart';
import 'package:http/http.dart' as http;
import 'package:thiran_demo/Services/database.dart';

class RepoService {
  final dbHelper = DatabaseHelper.instance;
  Future<List<Repo>> getRepoList(int offset) async {
    try {
    List<Repo> repoList = [], tempList = [];
    var repoCount = await dbHelper.queryAllRows();
    int len = repoCount.length;
    print("this is len $len");

    if (len == 0) {
      final response = await http.get(Uri.parse(
          "https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc"));
      final data = json.decode(response.body);
      tempList = data['items']
          .map((tagJson) => Repo.fromJson(tagJson))
          .cast<Repo>()
          .toList();
      print(tempList.length);
      var temp = tempList.map((e) {
        print(e);
        dbHelper.insert(e);
      });
      print(temp);
      // print(data['items'].length);
      // var temp = data['items'].map((repo) {
      //   print(repo);
      //   //  dbHelper.insert(Repo.fromJson(repo));
      // });
      //   var repoCount = await dbHelper.queryAllRows();
      // int len = repoCount.length;
      // print("this is len $len");


    } 
      repoList = await queryLocal(offset);

    print("query $repoList");
    return repoList;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Repo>> queryLocal(offset) async {
    List<Repo> repos = await dbHelper.queryLimitRows(offset);
    return repos;
  }
}
