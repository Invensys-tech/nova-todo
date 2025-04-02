import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';

class HomePage extends StatefulWidget {
  final Datamanager datamanager;
  const HomePage({super.key, required this.datamanager});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Productivity> productivityList = [];

  @override
  void initState() {
    super.initState();
    fetchProductivity();
  }

  void fetchProductivity() async {
    List<Productivity> productivity =
        await ProductivityRepository().getProductivity();
    setState(() {
      productivityList = productivity;
    });
  }

  Widget productivityCard(Productivity productivity, int streakCount) {
    IconData icon = Icons.work; // Default icon
    switch (productivity.title.toLowerCase()) {
      case 'sports and gym':
        icon = Icons.fitness_center;
        break;
      case 'books reading':
        icon = Icons.book;
        break;
      case 'self improvement':
        icon = Icons.self_improvement;
        break;
      case 'post on social media':
        icon = Icons.public;
        break;
    }

    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 30),
        title: Text(
          productivity.title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.local_fire_department,
              color: Colors.orange,
              size: 24,
            ),
            const SizedBox(width: 4),
            Text(
              streakCount.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        onTap: () {
          // Handle tap action
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            10,
          ); // Static streak count for now
        },
      ),
    );
  }
}
