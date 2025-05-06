import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/drawerpage.dart';
import 'package:flutter_application_1/drawer/productivity/productivity.view.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/pages/homepage/edit.productivity.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/services/streak.service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

class ProductivityHome extends StatefulWidget {
  const ProductivityHome({super.key});

  @override
  State<ProductivityHome> createState() => _HomePageState();
}

class _HomePageState extends State<ProductivityHome> {
  List<Productivity> productivityList = [];
  final StreakService _streakService = StreakService();
  Map<int, int> productivityStreaks = {};

  @override
  void initState() {
    super.initState();
    fetchProductivity();
  }

  Future<void> fetchProductivity() async {
    List<Productivity> productivity =
        await ProductivityRepository().getProductivity();
    setState(() {
      productivityList = productivity;
      productivityStreaks.clear(); // Clear previous streaks
    });

    for (final productivityItem in productivityList) {
      int maxStreak = 0;
      if (productivityItem.productivityHabits != null) {
        for (final habit in productivityItem.productivityHabits!) {
          final streaks = await _streakService.getStreaksForProductivityHabit(
            habit.id,
          );
          if (streaks.isNotEmpty) {
            final currentStreakCount = streaks.last['count'] as int? ?? 0;
            if (currentStreakCount > maxStreak) {
              maxStreak = currentStreakCount;
            }
          }
        }
      }
      // Update the streak count in the map
      setState(() {
        productivityStreaks[productivityItem.id] = maxStreak;
      });
    }
  }

  Widget productivityCard(Productivity productivity) {
    IconData iconData = Icons.work;
    String frequencyText = "Every Day";
    switch (productivity.title.toLowerCase()) {
      case 'sports and gym':
        iconData = Icons.fitness_center;
        frequencyText = "Once a Week";
        break;
      case 'books and music':
        iconData = Icons.library_music;
        frequencyText = "Every Day";
        break;
      case 'self improvement':
        iconData = Icons.self_improvement;
        frequencyText = "Every Day";
        break;
      case 'social medial influence':
        iconData = Icons.public;
        frequencyText = "Twice a Week";
        break;
    }

    const String motivationText = "Motivation Here";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductivityViewPgae(id: productivity.id),
          ),
        );
      },
      child: Slidable(
        key: ValueKey(productivity.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                ProductivityRepository().deleteProductivity(productivity.id);
                setState(() {
                  productivityList.remove(productivity);
                });
              },
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
                    builder:
                        (context) =>
                            EditProductivity(productivity: productivity),
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
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey.withOpacity(.3),
            ), // slightly different from icon bg
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Left section: text info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productivity.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(motivationText, style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(frequencyText, style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),

              // Right section: Icon in circular bg + chevron
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Lottie.asset(
                      productivity.streak_count.toString() == "1"
                          ? 'assets/LottieAnimations/FirstStreak.json'
                          : productivity.streak_count.toString() == "2"
                          ? 'assets/LottieAnimations/Scond2Streak.json'
                          : productivity.streak_count.toString() == "3"
                          ? 'assets/LottieAnimations/ThirdStreak.json'
                          : productivity.streak_count.toString() == "4"
                          ? 'assets/LottieAnimations/FourthStreak.json'
                          : productivity.streak_count.toString() == "5"
                          ? 'assets/LottieAnimations/LastStreak.json'
                          : 'assets/LottieAnimations/ZeroStreak.json',
                      // height: widget.habit.streak.toString() == "1" ? 40:
                      // widget.habit.streak.toString() == "2" ? 45:
                      // widget.habit.streak.toString() == "3" ? 50:
                      // widget.habit.streak.toString() == "4" ? 55:
                      // widget.habit.streak.toString() == "5" ? 60:40,
                      // width: widget.habit.streak.toString() == "1" ? 35:
                      // widget.habit.streak.toString() == "2" ? 40:
                      // widget.habit.streak.toString() == "3" ? 45:
                      // widget.habit.streak.toString() == "4" ? 50:
                      // widget.habit.streak.toString() == "5" ? 55:35,
                      height: 45,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${productivity.streak_count}",
                    // productivity.streak_count as String,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    print("Current Route: $currentRoute");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductivityForm()),
          );
          fetchProductivity(); // Refresh after returning
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Text(translate("Productivity")),
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
      body: LiquidPullToRefresh(
        onRefresh: () async {
          await fetchProductivity();
        },
        child: ListView.builder(
          itemCount: productivityList.length,
          itemBuilder: (context, index) {
            return productivityCard(productivityList[index]);
          },
        ),
      ),
    );
  }
}
