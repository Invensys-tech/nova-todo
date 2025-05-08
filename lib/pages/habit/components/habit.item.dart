import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habit.view.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

class HabitItem extends StatefulWidget {
  final Habit habit;
  final bool hasActions;

  const HabitItem({super.key, required this.habit, this.hasActions = true});

  @override
  State<HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  late Habit habit;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    habit = widget.habit;
  }

  changeSavingState(bool savingState) {
    setState(() {
      isSaving = savingState;
    });
  }

  extendStreak() {
    changeSavingState(true);
    HabitsRepository()
        .extendHabitStreak(widget.habit, DateTime.now())
        .then((value) {
          if (value) {
            setState(() {
              widget.habit.extendStreak(DateTime.now());
            });
            // changeSavingState(false);
          }
          changeSavingState(false);
        })
        .catchError((error) {
          changeSavingState(false);
        });
  }

  removeTerm() {
    changeSavingState(true);
    HabitsRepository()
        .removeTerm(widget.habit, DateTime.now())
        .then((value) {
          if (value) {
            setState(() {
              widget.habit.removeTerm(DateTime.now());
            });
          }
          changeSavingState(false);
        })
        .catchError((error) {
          changeSavingState(false);
        });
    ;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hasActions) {
      return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            // SlidableAction(
            //   onPressed: (context) => extendStreak(),
            //   backgroundColor: Color(0xFF1D9402),
            //   foregroundColor: Colors.white,
            //   icon: Icons.sentiment_satisfied,
            //   label: 'Done',
            // ),
            Expanded(
              flex: 1,
              child: Container(
                color:
                    widget.habit.isNotStartedToday
                        ? Colors.grey.shade200
                        : Color(0xFFEC003F),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isSaving || habit.isNotStartedToday) {
                        return;
                      }

                      removeTerm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(.4),
                    ),
                    child:
                        isSaving
                            ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.grey.shade300,
                              ),
                            )
                            : Text(
                              '😔 I didn\'t',
                              style: TextStyle(
                                color:
                                    habit.isNotStartedToday
                                        ? Colors.grey
                                        : Color(0xFFF4F4F5),
                              ),
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // SlidableAction(
            //   onPressed: (context) => removeTerm(),
            //   backgroundColor: Color(0xFFFE4A49),
            //   foregroundColor: Colors.white,
            //   icon: Icons.sentiment_dissatisfied,
            //   label: 'Not Done',
            // ),
            Expanded(
              flex: 1,
              child: Container(
                color:
                    widget.habit.isDoneToday
                        ? Colors.grey.shade200
                        : Color(0xFF009966),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isSaving || habit.isDoneToday) {
                        return;
                      }
                      extendStreak();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                    ),
                    child:
                        isSaving
                            ? SizedBox(
                              width: 16,
                              height: 16,
                              child:  Container(
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                child: Lottie.asset(
                                      'assets/LottieAnimations/HabitLoading.json',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                            : Text(
                              '🙂 I did it!',
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HabitView(habit: habit)),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .025,
            ),
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                // color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: Colors.grey.withOpacity(.5),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    spacing: MediaQuery.of(context).size.width * 0.01,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon(Icons.book),
                      Text(
                        widget.habit.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.habit.type,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.habit.frequencyPhrase,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: MediaQuery.of(context).size.width * 0.01,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icon(Icons.local_fire_department, color: Colors.orange),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Lottie.asset(
                              widget.habit.streak.toString() == "1"
                                  ? 'assets/LottieAnimations/FirstStreak.json'
                                  : widget.habit.streak.toString() == "2"
                                  ? 'assets/LottieAnimations/Scond2Streak.json'
                                  : widget.habit.streak.toString() == "3"
                                  ? 'assets/LottieAnimations/ThirdStreak.json'
                                  : widget.habit.streak.toString() == "4"
                                  ? 'assets/LottieAnimations/FourthStreak.json'
                                  : widget.habit.streak.toString() == "5"
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
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                          Text(
                            widget.habit.streak.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          // Text(
                          //   widget.habit.miniStreak.toString(),
                          //   style: TextStyle(fontSize: 10),
                          // ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color(0xFF009966),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HabitView(habit: habit)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .025,
          vertical: MediaQuery.of(context).size.height * .01,
        ),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          decoration: BoxDecoration(
            // color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.grey.withOpacity(.5), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                spacing: MediaQuery.of(context).size.width * 0.01,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(Icons.book),
                  Text(
                    widget.habit.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.habit.type,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    widget.habit.frequencyPhrase,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Row(
                spacing: MediaQuery.of(context).size.width * 0.01,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon(Icons.local_fire_department, color: Colors.orange),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Lottie.asset(
                          widget.habit.streak.toString() == "1"
                              ? 'assets/LottieAnimations/FirstStreak.json'
                              : widget.habit.streak.toString() == "2"
                              ? 'assets/LottieAnimations/Scond2Streak.json'
                              : widget.habit.streak.toString() == "3"
                              ? 'assets/LottieAnimations/ThirdStreak.json'
                              : widget.habit.streak.toString() == "4"
                              ? 'assets/LottieAnimations/FourthStreak.json'
                              : widget.habit.streak.toString() == "5"
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
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Text(
                        widget.habit.streak.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      // Text(
                      //   widget.habit.miniStreak.toString(),
                      //   style: TextStyle(fontSize: 10),
                      // ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Color(0xFF009966),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
