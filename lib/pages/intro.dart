import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/finance.dart';
import 'package:flutter_application_1/pages/goal/goal.dart';
import 'package:flutter_application_1/pages/Home%20Page%20/home.dart';
import 'package:flutter_application_1/pages/Notes%20page/notes.dart';
import 'package:flutter_application_1/pages/ToDo%20page/todo.dart';

class IntorPage extends StatefulWidget {
  const IntorPage({super.key});

  @override
  State<IntorPage> createState() => _IntorPageState();
}

class _IntorPageState extends State<IntorPage> {
  var datamanger = Datamanager();
  int selectedIndex = 1;

  Widget currentPage = HomePage(datamanager: Datamanager());

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        currentPage = HomePage(datamanager: datamanger);
        break;
      case 1:
        currentPage = FinanceUi(datamanager: datamanger);
        break;
      case 2:
        currentPage = GoalPage();
        break;
      case 3:
        currentPage = TodoPage();
        break;
      case 4:
        currentPage = NotesPage();
        break;

      default:
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Removes the AppBar space
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.green, width: 1), // Green top border
          ),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: "Finance",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ads_click),
              label: "Goals",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_add),
              label: "Assignment",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: "Notes",
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          },
        ),
      ),
      body: currentPage,
    );
  }
}
