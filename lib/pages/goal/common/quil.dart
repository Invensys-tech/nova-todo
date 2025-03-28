import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuilExample extends StatefulWidget {
  const QuilExample({super.key});

  @override
  State<QuilExample> createState() => _QuilExampleState();
}

class _QuilExampleState extends State<QuilExample> {
  QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(),
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              config: const QuillEditorConfig(),
            ),
          ),
        ],
      ),
    );
  }
}
