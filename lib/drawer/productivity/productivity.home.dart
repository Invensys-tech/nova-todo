import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/drawerpage.dart';
import 'package:flutter_application_1/drawer/productivity/productivity.view.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/services/streak.service.dart';

class ProductivityHome extends StatefulWidget {
  const ProductivityHome({super.key});

  @override
  State<ProductivityHome> createState() => _HomePageState();
}

class _HomePageState extends State<ProductivityHome> {
  List<Productivity> productivityList = [];
  final StreakService _streakService = StreakService(); // Add this line
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

  // Widget productivityCard(Productivity productivity) {
  //   IconData icon = Icons.work; // Default icon
  //   switch (productivity.title.toLowerCase()) {
  //     case 'sports and gym':
  //       icon = Icons.fitness_center;
  //       break;
  //     case 'books reading':
  //       icon = Icons.book;
  //       break;
  //     case 'self improvement':
  //       icon = Icons.self_improvement;
  //       break;
  //     case 'post on social media':
  //       icon = Icons.public;
  //       break;
  //   }

  //   final streakCount =
  //       productivityStreaks[productivity.id] ??
  //       0; // Get streak count, default to 0

  //   return Card(
  //     color: Colors.grey[900],
  //     margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     child: ListTile(
  //       leading: Icon(icon, color: Colors.white, size: 30),
  //       title: Text(
  //         productivity.title,
  //         style: const TextStyle(color: Colors.white, fontSize: 18),
  //       ),
  //       trailing: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Icon(
  //             Icons.local_fire_department,
  //             color: Colors.orange,
  //             size: 24,
  //           ),
  //           const SizedBox(width: 4),
  //           Text(
  //             streakCount.toString(),
  //             style: const TextStyle(color: Colors.white, fontSize: 18),
  //           ),
  //         ],
  //       ),
  //       onTap: () {
  //         // Handle tap action
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ProductivityViewPgae(id: productivity.id),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E20), // slightly different from icon bg
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
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    motivationText,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    frequencyText,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),

            // Right section: Icon in circular bg + chevron
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 4),
                Text(
                  "${productivity.streak_count}",
                  // productivity.streak_count as String,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    print("Current Route: $currentRoute");
    return Scaffold(
      backgroundColor: const Color(0xff2F2F2F),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2b2d30),
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
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "Productivity",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: productivityList.length,
        itemBuilder: (context, index) {
          return productivityCard(
            productivityList[index],
          ); // Static streak count for now
        },
      ),
    );
  }
}
