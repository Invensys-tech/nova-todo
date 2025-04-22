import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/daily-journal.repository.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyJournalQuill extends StatefulWidget {
  final String date;
  final dynamic content;
  const DailyJournalQuill({super.key, required this.date, this.content});

  @override
  State<DailyJournalQuill> createState() => _DailyJournalQuillState();
}

class _DailyJournalQuillState extends State<DailyJournalQuill> {
  late QuillController controller;

  @override
  void initState() {
    super.initState();
    if (widget.content != null) {
      controller = QuillController(
        document: Document.fromJson(widget.content),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      controller = QuillController.basic();
    }
  }

  saveJournal() async {
    // controller.document.from;
    Map<String, dynamic> dailyJournalMap = {
      'content': controller.document.toDelta().toJson(),
      'date': widget.date,
    };
    DailyJournalRepository().upsertFromMap(dailyJournalMap);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: FaIcon(FontAwesomeIcons.chevronLeft,size: 20, color: Color(0xff006045),),
        ),
        title: const Text(
          "Add Daily Journal",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed:
                  saveJournal, // widget.journal != "" ? updateJournal : saveJournal,
              // onPressed: saveJournal,
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05),
                child: Text(
                  "Journal On ${widget.date}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width*1,
                      child: QuillSimpleToolbar(
                        controller: controller,

                        config: QuillSimpleToolbarConfig(
                          toolbarIconAlignment: WrapAlignment.start,
                          toolbarRunSpacing: 0,
                            showUndo:
                            false, // Set this to false to remove the undo button
                            showRedo: false,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),

                            showStrikeThrough: false,
                            showInlineCode: false,
                            showClearFormat: false,
                            showCodeBlock: false,
                            showSearchButton: false,
                            showLink: false,
                            showCenterAlignment: false,
                            showQuote: false,
                            showRightAlignment: false,
                            showListCheck: false,
                            showListBullets: false,
                            showListNumbers: false,
                            showSmallButton: false,
                            showLeftAlignment: false,
                            showJustifyAlignment: false,
                            showAlignmentButtons: false,
                            showLineHeightButton: false,
                            showIndent: false,
                            headerStyleType: HeaderStyleType.original,
                            axis: Axis.horizontal
                        ),
                      ),
                    ),
                    Expanded(
                      child: QuillEditor.basic(
                        controller: controller,
                        config: QuillEditorConfig(
                          scrollable: true,
                        ),
                      ),
                    ),
                    QuillSimpleToolbar(
                      controller: controller,
                      config: QuillSimpleToolbarConfig(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),

                          showUndo:
                          false, // Set this to false to remove the undo button
                          showRedo: false,
                          showStrikeThrough: false,
                          showInlineCode: false,
                          showClearFormat: false,
                          showCodeBlock: false,
                          showSearchButton: false,
                          showLink: false,
                          showBackgroundColorButton: false,
                          showColorButton: false,
                          showFontSize: false,
                          showFontFamily: false,
                          showBoldButton: false,
                          showItalicButton: false,
                          showUnderLineButton: false,
                          showSubscript: false,
                          showSuperscript: false,
                          showHeaderStyle: false,
                          headerStyleType: HeaderStyleType.original,
                          axis: Axis.horizontal
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
