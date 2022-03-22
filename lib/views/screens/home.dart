import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:issues_reporter/views/components/issue_card_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:issues_reporter/views/screens/add_issue_page.dart';

///The home page on which the application lands upon launch
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 120, 82),
        appBar: AppBar(
            title: const Text('Products Issues'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 245, 120, 82)),
        body: SafeArea(
            child: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50)))),
          BlocConsumer<BlocForIssues, List<Issue>>(
              listener: (context, state) {},
              builder: (context, state) {
                return bloc.issues.isEmpty
                    ? const Center(
                        child: Text('No issue has been added yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  child: SlideAnimation(
                                      horizontalOffset: 50.0,
                                      child: FadeInAnimation(
                                          child:
                                              IssueCard(bloc.issues[index]))));
                            },
                            itemCount: bloc.issues.length));
              })
        ])),
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
