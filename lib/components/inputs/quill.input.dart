import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillInput extends StatefulWidget {
  void Function(dynamic writtenContent) onSave;
  dynamic previousContent;
  bool isUpdate;
  Widget? extraContent;
  QuillInput({
    super.key,
    this.previousContent,
    required this.onSave,
    this.isUpdate = false,
    this.extraContent,
  });

  @override
  State<QuillInput> createState() => _QuillInputState();
}

class _QuillInputState extends State<QuillInput> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _controller = QuillController(
        document: Document.fromJson(
          jsonDecode(jsonDecode(widget.previousContent)),
        ),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _controller = QuillController.basic();
    }
  }

  handleSave() {
    widget.onSave(_controller.document.toDelta().toJson());
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
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
              onPressed: handleSave,
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.extraContent ?? Container(),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  QuillSimpleToolbar(
                    controller: _controller,
                    config: QuillSimpleToolbarConfig(),
                  ),
                  Expanded(
                    child: QuillEditor.basic(
                      controller: _controller,
                      config: QuillEditorConfig(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
