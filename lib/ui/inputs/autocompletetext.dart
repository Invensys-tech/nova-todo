// import 'package:flutter/material.dart';
// import 'package:advanced_search/advanced_search.dart';

// class AutoCompleteText extends StatelessWidget {
//   /// List of suggestions to search from.
//   final List<String> suggestions;

//   /// Function to build each suggestion widget.
//   final Widget Function(String) suggestionBuilder;

//   /// Hint text for the search field.
//   final String hintText;

//   /// Text editing controller.
//   final TextEditingController controller;

//   /// Icon to display on the left side.
//   final IconData icon;

//   final void Function(String value)? onSelect;

//   const AutoCompleteText({
//     Key? key,
//     required this.suggestions,
//     required this.suggestionBuilder,
//     required this.hintText,
//     required this.controller,
//     required this.icon,
//     this.onSelect,
//     Null Function(dynamic selectedName)? onSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // Outer container mimics the TextFields style,
//       decoration: BoxDecoration(
//         border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(5),
//           bottomLeft: Radius.circular(5),
//         ),

//         // border: Border.all(color: Colors.green, width: 2),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: AdvancedSearch(
//               searchItems: suggestions,
//               maxElementsToDisplay: 10,
//               // Remove AdvancedSearch's own border/background so that our container styling is used
//               borderColor: Colors.transparent,
//               borderRadius: 0.0,
//               hintText: hintText,
//               cursorColor: Colors.blueGrey,
//               autoCorrect: false,
//               focusedBorderColor: Colors.transparent,
//               disabledBorderColor: Colors.transparent,
//               enabledBorderColor: Colors.transparent,
//               enabled: true,
//               caseSensitive: false,
//               // Make the text field transparent to show the container’s background
//               inputTextFieldBgColor: Colors.transparent,
//               clearSearchEnabled: true,
//               itemsShownAtStart: 10,
//               searchMode: SearchMode.CONTAINS,
//               showListOfResults: true,
//               // Set suggestions list text color to white
//               verticalPadding: 0,
//               horizontalPadding: 10,
//               hideHintOnTextInputFocus: true,
//               // Use the suggestion builder passed from the caller
//               searchItemsWidget: suggestionBuilder,
//               onItemTap: (index, value) {
//                 print("Selected item Index is $index");
//                 // Capture the selected value
//                 controller.text = value;
//                 if (onSelect != null) {
//                   onSelect!(value);
//                 }
//               },
//               onSearchClear: () {
//                 print("Cleared Search");
//                 controller.clear();
//               },
//               onSubmitted: (value, value2) {
//                 print("Submitted: $value");
//                 controller.text = value;
//               },
//               onEditingProgress: (value, value2) {
//                 print("Text Edited: $value");
//                 controller.text = value;
//                 print("LENGTH: ${value2.length}");
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:advanced_search/advanced_search.dart';
// import 'package:flutter/material.dart';

// class AutoCompleteText extends StatelessWidget {
//   final List<String> suggestions;
//   final Widget Function(String) suggestionBuilder;
//   final String hintText;
//   final TextEditingController controller;
//   final IconData icon;
//   final void Function(String value)? onSelect;
//   final bool? isFromEdit;

//   final String? Function(String?)? validator;

//   const AutoCompleteText({
//     Key? key,
//     required this.suggestions,
//     required this.suggestionBuilder,
//     required this.hintText,
//     required this.controller,
//     required this.icon,
//     this.onSelect,
//     this.validator,
//     this.isFromEdit = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FormField<String>(
//       validator: validator,
//       builder: (field) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 1,
//                   color:
//                       field.hasError ? Colors.red : Colors.grey.withOpacity(.4),
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(5),
//                   bottomLeft: Radius.circular(5),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: AdvancedSearch(
//                       searchItems: suggestions,

//                       maxElementsToDisplay: 10,
//                       borderColor: Colors.transparent,
//                       borderRadius: 0.0,
//                       hintText: hintText,
//                       cursorColor: Colors.blueGrey,
//                       autoCorrect: false,
//                       focusedBorderColor: Colors.transparent,
//                       disabledBorderColor: Colors.transparent,
//                       enabledBorderColor: Colors.transparent,
//                       enabled: true,
//                       caseSensitive: false,
//                       inputTextFieldBgColor: Colors.transparent,
//                       clearSearchEnabled: true,
//                       itemsShownAtStart: 10,
//                       searchMode: SearchMode.CONTAINS,
//                       showListOfResults: true,
//                       verticalPadding: 0,
//                       horizontalPadding: 10,
//                       hideHintOnTextInputFocus: true,
//                       searchItemsWidget: suggestionBuilder,

//                       onItemTap: (index, value) {
//                         controller.text = value;
//                         field.didChange(value);
//                         onSelect?.call(value);
//                       },
//                       onSearchClear: () {
//                         controller.clear();
//                         field.didChange('');
//                       },
//                       onSubmitted: (value, _) {
//                         controller.text = value;
//                         field.didChange(value);
//                       },
//                       onEditingProgress: (value, _) {
//                         controller.text = value;
//                         field.didChange(value);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (field.hasError)
//               Padding(
//                 padding: const EdgeInsets.only(top: 4, left: 8),
//                 child: Text(
//                   field.errorText!,
//                   style: TextStyle(color: Colors.red[700], fontSize: 12),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';

class AutoCompleteText extends StatefulWidget {
  final List<String> suggestions;
  final Widget Function(String) suggestionBuilder;
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final void Function(String)? onSelect;
  final bool isFromEdit;
  final String? Function(String?)? validator;

  const AutoCompleteText({
    Key? key,
    required this.suggestions,
    required this.suggestionBuilder,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.onSelect,
    this.validator,
    this.isFromEdit = false,
  }) : super(key: key);

  @override
  State<AutoCompleteText> createState() => _AutoCompleteTextState();
}

class _AutoCompleteTextState extends State<AutoCompleteText> {
  /// When true, show the simple TextField with the “initial” value.
  /// After user taps, we flip it off and show AdvancedSearch.
  late bool _showPlainField;

  @override
  void initState() {
    super.initState();
    // if we're coming from edit, and there's already text, show the plain one first
    _showPlainField = widget.isFromEdit && widget.controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // Wrap in a FormField just to keep validation styling:
    return FormField<String>(
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color:
                      field.hasError ? Colors.red : Colors.grey.withOpacity(.4),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child:
                  _showPlainField
                      // 1) The “fake” plain field that shows the old value
                      ? TextField(
                        controller: widget.controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(widget.icon),
                          hintText: widget.hintText,
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          // user wants to actually search now
                          setState(() {
                            _showPlainField = false;
                          });
                        },
                        onChanged: (v) {
                          field.didChange(v);
                        },
                      )
                      // 2) The real advanced search
                      : AdvancedSearch(
                        searchItems: widget.suggestions,
                        maxElementsToDisplay: 10,
                        borderColor: Colors.transparent,
                        borderRadius: 0.0,
                        hintText: widget.hintText,
                        cursorColor: Colors.blueGrey,
                        autoCorrect: false,
                        focusedBorderColor: Colors.transparent,
                        disabledBorderColor: Colors.transparent,
                        enabledBorderColor: Colors.transparent,
                        enabled: true,
                        caseSensitive: false,
                        inputTextFieldBgColor: Colors.transparent,
                        clearSearchEnabled: true,
                        itemsShownAtStart: 10,
                        searchMode: SearchMode.CONTAINS,
                        showListOfResults: true,
                        verticalPadding: 0,
                        horizontalPadding: 10,
                        hideHintOnTextInputFocus: true,
                        searchItemsWidget: widget.suggestionBuilder,
                        onItemTap: (idx, val) {
                          widget.controller.text = val;
                          field.didChange(val);
                          widget.onSelect?.call(val);
                        },
                        onSearchClear: () {
                          widget.controller.clear();
                          field.didChange('');
                        },
                        onSubmitted: (val, _) {
                          widget.controller.text = val;
                          field.didChange(val);
                        },
                        onEditingProgress: (val, _) {
                          widget.controller.text = val;
                          field.didChange(val);
                        },
                      ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(color: Colors.red[700], fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
