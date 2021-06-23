import 'package:flutter/material.dart';
import 'pending_tab.dart';
import 'done_tab.dart';
import 'undone_tab.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //DefaultTabController for creating TabBar with 3 Tabs.
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              'Planner',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Pending',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Tab(
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Tab(
                  child: Text(
                    'Undone',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PendingTab(),
              DoneTab(),
              UndoneTab(),
            ],
          ),
        ),
      ),
    );
  }
}
