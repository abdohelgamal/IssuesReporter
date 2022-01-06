import 'package:facegraph_assessment/Controller/database.dart';
import 'package:facegraph_assessment/Models/bloc.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:facegraph_assessment/Views/bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BlocForIssues provider = BlocForIssues();
  @override
  void initState() {
    super.initState();
    // var db = Dbcontroller();
    // db.createDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Products Issues'))),
        body: SafeArea(
          child: BlocConsumer<BlocForIssues, List<Issue>>(
              listener: (context, issues) {},
              builder: (context, issues) {
                return ListView.builder(
                    itemCount: provider.issues.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        expandedAlignment: Alignment.topCenter,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.issues[index].title),
                          Text(provider.issues[index].description),
                          ListTile(
                            title: const Text('Date'),
                            trailing: Text(provider.issues[index].date),
                          ),
                          ListTile(
                            title: const Text('Status'),
                            trailing: Text(provider.issues[index].status),
                          )
                        ],
                        title: Text(provider.issues[index].title),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                iconSize: 25,
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {},
                                iconSize: 25,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )),
                          ],
                        ),
                      );
                    });

                //        ...images
                //       .map((element) => Row(children: [
                //             const Text('1'),
                //             const Text('title'),
                //             Image.file(
                //               File(element.path),
                //               height: 200,
                //               width: 150,
                //             ),
                //             const Text('Descr'),
                //             Text(DateTime.now().toString()),
                //             const Text('Open')
                //           ]))
                //       .toList()
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Center(child: Text('Add new Issue')),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            print(provider.issues.length);
            showModalBottomSheet(
                context: context,
                builder: (context) => BtmSheet()).then((issue) {
                  // provider.addNewIssue(issue);
            });
            setState(() {});
          },
        ));
  }
}
