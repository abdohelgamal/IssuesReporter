import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:issues_reporter/views/components/issue_card_component.dart';

///A component for the content in each tab
class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return Expanded(
        child: BlocConsumer<BlocForIssues, List<Issue>>(
            listener: (context, state) {},
            builder: (context, state) {
              return TabBarView(children: [
// All Issues Tab

                ListView.builder(
                    itemCount: bloc.allIssues.length,
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemBuilder: (context, index) {
                      if (bloc.allIssues.isEmpty) {
                        return const Center(
                          child: Text('No issue has been added yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                        );
                      } else {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 600),
                            child: SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                    child: IssueCard(bloc.allIssues[index]))));
                      }
                    }),

// Open Issues Tab

                bloc.openIssues.isEmpty
                    ? const Center(
                        child: Text('No Open Issues',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                      )
                    : ListView.builder(
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
                                          IssueCard(bloc.openIssues[index]))));
                        },
                        itemCount: bloc.openIssues.length),

// Closed Issues Tab

                bloc.closedIssues.isEmpty
                    ? const Center(
                        child: Text('No Closed Issues',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)))
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              child: SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                      child: IssueCard(
                                          bloc.closedIssues[index]))));
                        },
                        itemCount: bloc.closedIssues.length)
              ]);
            }));
  }
}
