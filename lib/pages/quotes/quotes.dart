import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habits-list.dart';
import 'package:flutter_application_1/pages/habit/form.habit.dart';
import 'package:flutter_application_1/pages/quotes/components/quotes-list.dart';
import 'package:flutter_application_1/pages/quotes/form.quotes.dart';
import 'package:flutter_application_1/repositories/quote.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  DateTime now = DateTime.now();

  late Future<List<Quote>> quotes;

  @override
  void initState() {
    super.initState();
    quotes = QuoteRepository().fetchAll();
    loabThemeApp();
  }

 bool isDarkB = true;
  Future<void> loabThemeApp() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkB = prefs.getBool('ThemeOfApp')!;
    });
  }
  void newQuote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuoteForm(refetch: refetchData)),
    );
  }

  void refetchData() {
    quotes = QuoteRepository().fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: newQuote,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Text("Habits"),
            SizedBox(width: MediaQuery.of(context).size.width*.015,),
            Container(
                height: MediaQuery.of(context).size.height*.03,
                width: MediaQuery.of(context).size.width*.06,
                child: Image.asset('assets/Gif/Quotes.gif'))

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
              icon:  FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.green),
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: FutureBuilder(
          future: quotes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return QuotesList(quotes: snapshot.data!);
            } else {
              if (snapshot.hasError) {
                return Text('Error fetching quotes!');
              }
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        // child: QuotesList(
        //   quotes: [
        //     Quote(
        //       author: 'Abebe Bikila',
        //       text: 'The best way to predict the future is to create it.',
        //       source: 'Abraham Lincoln',
        //       category: 'Motivation',
        //     ),
        //     Quote(
        //       author: 'Kenenisa Bekele',
        //       text: 'The best way to predict the future is to create it.',
        //       source: 'Abraham Lincoln',
        //       category: 'Motivation',
        //     ),
        //     Quote(
        //       author: 'Adane Girma',
        //       text: 'The best way to predict the future is to create it.',
        //       source: 'Abraham Lincoln',
        //       category: 'Motivation',
        //     ),
        //     Quote(
        //       author: 'Addis Hntsa',
        //       text: 'The best way to predict the future is to create it.',
        //       source: 'Abraham Lincoln',
        //       category: 'Motivation',
        //     ),
        //     Quote(
        //       author: 'Asrat Megersa',
        //       text: 'The best way to predict the future is to create it.',
        //       source: 'Abraham Lincoln',
        //       category: 'Motivation',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
