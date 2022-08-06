import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thiran_demo/ViewModel/repoListVM.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RepoListVM>(
        create: (BuildContext context) => RepoListVM(context),
        child: Consumer<RepoListVM>(builder: (context, vm, _) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: const Text("Most Starred GitHub Repos"),
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: vm.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ))
                      : vm.repoList.length == 0
                          ? Center(child: Text("No data found"))
                          : Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () => vm.prev(),
                                        icon: Icon(Icons.arrow_back_ios)),
                                        Text("Rows ${vm.offset + 1} - ${vm.offset + 10}"),
                                    IconButton(
                                        onPressed: () => vm.next(),
                                        icon: Icon(Icons.arrow_forward_ios))
                                  ]),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: vm.repoList.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            margin: EdgeInsets.only(
                                                top: index == 0 ? 30 : 5,
                                                bottom: 15,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    blurRadius: 5.0,
                                                  ),
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage:
                                                        NetworkImage(vm
                                                                .repoList[index]
                                                                .avatar ??
                                                            ""),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    vm.repoList[index]
                                                            .username ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.deepPurple),
                                                  ),
                                                ]),
                                                const SizedBox(height: 10),
                                                Text(
                                                  vm.repoList[index].title ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.deepPurple),
                                                ),
                                                SizedBox(height: 7),
                                                Text(
                                                  vm.repoList[index]
                                                          .description ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      height: 1.5,
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(height: 10),
                                                Row(children: [
                                                  Icon(Icons.star,
                                                      size: 22,
                                                      color: Colors.amber),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xffE6E6FA)),
                                                    child: Center(
                                                      child: Text(vm
                                                              .repoList[index]
                                                              .rating ??
                                                          ""),
                                                    ),
                                                  )
                                                ])
                                              ],
                                            ));
                                      }))
                            ])));
        }));
  }
}
