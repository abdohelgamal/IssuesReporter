import 'package:facegraph_assessment/Models/bloc.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:facegraph_assessment/Views/bottomSheet.dart';
import 'package:facegraph_assessment/Views/issueCard_Component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Products Issues'))),
        body: SafeArea(
          child: BlocConsumer<BlocForIssues, List<Issue>>(
              listener: (context, state) {},
              builder: (context, state) {
                return ListView(
                    children: bloc.issues.map((issue) {
                  return IssueCard(issue);
                }).toList());
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Center(child: Text('Add new Issue')),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            print(bloc.issues.length);
            showModalBottomSheet(
                context: context, builder: (context) => BtmSheet());
          },
        ));
  }
}
