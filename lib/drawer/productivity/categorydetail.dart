import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage/edit.productivity-habit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_application_1/entities/habit-list.dart';
import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
import 'package:flutter_application_1/repositories/habit-list.repositoty.dart';

class CategoryDetail extends StatefulWidget {
  final String title;
  final List<ProductivityHabit> habits;

  const CategoryDetail({Key? key, required this.title, required this.habits})
    : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff2F2F2F),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: widget.habits.length,
        itemBuilder: (context, i) {
          final p = widget.habits[i];
          return buildContainer(p);
        },
      ),
    );
  }

  Widget buildContainer(ProductivityHabit p) {
    return Slidable(
      key: ValueKey(p.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              ProductivityHabitRepository().deleteProductivityHabit(p.id);
              setState(() {
                widget.habits.remove(p);
              });
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              final changed = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => EditProductivityHabitForm(
                        habit: p,
                        productivityId: p.productivity_id,
                      ),
                ),
              );
              if (changed == true) {
                setState(() {
                  // refresh this single habit’s data
                  // simplest: refetch from repo
                  // ProductivityHabitRepository()
                  //     .getProductivityHabitById(p.id)
                  //     .then((fresh) {
                  //       final idx = widget.habits.indexWhere(
                  //         (h) => h.id == p.id,
                  //       );
                  //       if (idx != -1) {
                  //         setState(() => widget.habits[idx] = fresh);
                  //       }
                  //     });
                });
              }
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .015,
          horizontal: MediaQuery.of(context).size.width * .025,
        ),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .015,
          horizontal: MediaQuery.of(context).size.width * .045,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Color(0xFF18181B), Color(0xFF27272A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   color: Color(0xff626262).withOpacity(.5),
        //   border: Border.all(width: 1, color: Colors.white.withOpacity(.3)),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              p.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            ...?p.habitList?.map((e) => smallListBuilder(e)).toList() ?? [],
          ],
        ),
      ),
    );
  }

  Widget smallListBuilder(HabitList habit) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .025,
        vertical: MediaQuery.of(context).size.height * .005,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 14,
                color: Colors.white.withOpacity(.85),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .01),
              Text(
                habit.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            habit.time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
