import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/common/balance.dart';
import 'package:flutter_application_1/pages/goal/common/addgoal.dart';
import 'package:flutter_application_1/pages/goal/common/editgoal.dart';
import 'package:flutter_application_1/pages/goal/common/goal-stat.dart';
import 'package:flutter_application_1/pages/goal/common/goalwidget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoalPage extends StatefulWidget {
  final Datamanager datamanager;

  const GoalPage({super.key, required this.datamanager});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Goal>> _goalFuture;
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _loadGoals();

    _tabController = TabController(length: 3, vsync: this)..addListener(() {
      // only update when the animation stops
      if (!_tabController.indexIsChanging) {
        setState(() => _selectedTab = _tabController.index);
      }
    });
  }

  void _loadGoals() {
    _goalFuture = widget.datamanager.getGoals();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(translate("Vision Boards")),
            SizedBox(width: MediaQuery.of(context).size.width * .015),

            // Container(
            //     height: MediaQuery.of(context).size.height*.03,
            //     width: MediaQuery.of(context).size.width*.06,
            //     child: Image.asset('assets/Gif/Quotes.gif'))
          ],
        ),

        // centerTitle: true,
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.green),
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final newGoals = await Navigator.push<List<Goal>>(
            context,
            MaterialPageRoute(builder: (_) => AddGoal()),
          );
          if (newGoals != null) {
            setState(() => _goalFuture = Future.value(newGoals));
          }
        },
        child: const Icon(Icons.add, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              const SizedBox(height: 10),

              // ─── Filtered list ───
              FutureBuilder<List<Goal>>(
                future: _goalFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error loading goals:\n${snapshot.error}",
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }

                  final allGoals = snapshot.data!;
                  print(jsonEncode(allGoals[0].toJson()));

                  // apply tab‑based filtering
                  final filtered = <Goal>[
                    if (_selectedTab == 0) ...allGoals,
                    if (_selectedTab == 1)
                      ...allGoals.where((g) => g.term == 'short'),
                    if (_selectedTab == 2)
                      ...allGoals.where((g) => g.term == 'long'),
                  ];

                  if (filtered.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Goals Found",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final goal = filtered[i];
                      return Column(
                        children: [
                          Slidable(
                            key: ValueKey(goal.id),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {},
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: translate('Delete'),
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditGoal(goal: goal),
                                      ),
                                    );
                                  },
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: translate('Edit'),
                                ),
                              ],
                            ),
                            child: GoalWidget(
                              id: goal.id,
                              title: goal.name,
                              description: goal.description,
                              percentage: goal.getPercentage,
                              term: goal.term,
                              date: goal.deadline,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
