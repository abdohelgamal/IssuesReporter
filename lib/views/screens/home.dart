import 'package:flutter/material.dart';
import 'package:issues_reporter/views/components/tabs.dart';
import 'package:issues_reporter/views/components/tabs_contents.dart';
import 'package:issues_reporter/views/screens/add_issue_page.dart';

///The home page on which the application lands upon launch
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 120, 82),
        appBar: AppBar(
            title: const Text('Products Issues'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 245, 120, 82)),
        body: SafeArea(
            child: DefaultTabController(
          length: 3,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)))),
            Column(
              children: const [TabsComponent(), Content()],
            ),
          ]),
        )),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text('Add new Issue', style: TextStyle(fontSize: 17)),
            elevation: 10,
            backgroundColor: const Color.fromARGB(255, 245, 120, 82),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddIssuePage()))));
  }
}
