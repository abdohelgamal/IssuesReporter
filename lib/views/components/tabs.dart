import 'package:flutter/material.dart';

///A component for Tabs widget
class TabsComponent extends StatelessWidget {
  const TabsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 75,
        child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(color: Colors.blue[700], fontSize: 20),
            unselectedLabelStyle:
                TextStyle(color: Colors.blue[300], fontSize: 15),
            labelColor: Colors.blue[700],
            unselectedLabelColor: Colors.blue[300],
            tabs: const [
              Tab(
                  icon: Icon(Icons.event),
                  height: 60,
                  child: Text('All Issues')),
              Tab(
                  icon: Icon(Icons.pending_actions_rounded),
                  child: Text('Open Issues')),
              Tab(icon: Icon(Icons.done_all), child: Text('Closed Issues'))
            ]));
  }
}
