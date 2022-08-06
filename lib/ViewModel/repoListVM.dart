import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thiran_demo/Model/repo.dart';
import 'package:thiran_demo/Services/database.dart';
import 'package:thiran_demo/Services/repoService.dart';

class RepoListVM extends ChangeNotifier {
  BuildContext context;
  bool isLoading = false;
  List<Repo> repoList = [];
  final dbHelper = DatabaseHelper.instance;
  int offset = 0;

  RepoListVM(this.context) {
    getRepoList();
  }

  Future<void> getRepoList() async {
    isLoading = true;
    repoList = await RepoService().getRepoList(offset);
    isLoading = false;
    notifyListeners();
  }

  void prev() async {
    if (offset >0) {
      isLoading = true;
      offset -= 10;
      repoList = await RepoService().queryLocal(offset);
      isLoading = false;
      notifyListeners();
    }
  }

  void next() async {
    if (offset < 20) {
      isLoading = true;
      offset += 10;
      repoList = await RepoService().queryLocal(offset);
      isLoading = false;
      notifyListeners();
    }
  }
}
