import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/todopage/SingleToDoListViewpage.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoItem extends StatefulWidget {
  final String name;
  final String description;
  final bool isDone;
  final String date;

  const TodoItem({
    super.key,
    required this.name,
    required this.description,
    required this.isDone,
    required this.date,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Singletodolistviewpage()),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                    vertical: MediaQuery.of(context).size.height * .015,
                  ),
                  width: MediaQuery.of(context).size.width * .93,
                  decoration: BoxDecoration(
                    color: Color(0xff0d805e).withOpacity(.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.date,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .0125,
                      ),
                      Text(
                        widget.description,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(.8),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.lock_clock, size: 20, color: Colors.white),
                          Row(
                            children: [
                              Text(
                                "Status : ",
                                style: GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.isDone ? 'Done' : 'Waiting',
                                style: GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .02),
      ],
    );
  }
}
