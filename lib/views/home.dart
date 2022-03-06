import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:issues_reporter/views/add_issue_page.dart';
import 'package:issues_reporter/views/issue_card_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Products Issues'))),
        body: SafeArea(
            child: BlocConsumer<BlocForIssues, List<Issue>>(
                listener: (context, state) {},
                builder: (context, state) {
                  return bloc.issues.isEmpty
                      ? const Center(
                          child: Text(
                            'No issue has been added yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                        child: IssueCard(bloc.issues[index]))));
                          },
                          itemCount: bloc.issues.length,
                        );
                })),
        floatingActionButton: FloatingActionButton.extended(
          label: const Center(child: Text('Add new Issue')),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddIssuePage()));
          },
        ));
  }
}
