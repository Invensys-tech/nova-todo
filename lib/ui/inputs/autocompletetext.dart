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

import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';

class AutoCompleteText extends StatelessWidget {
  final List<String> suggestions;
  final Widget Function(String) suggestionBuilder;
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final void Function(String value)? onSelect;

  /// Optional validator function (just like TextFormField)
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
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
              child: Row(
                children: [
                  Expanded(
                    child: AdvancedSearch(
                      searchItems: suggestions,
                      maxElementsToDisplay: 10,
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      hintText: hintText,
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
                      searchItemsWidget: suggestionBuilder,

                      onItemTap: (index, value) {
                        controller.text = value;
                        field.didChange(value);
                        onSelect?.call(value);
                      },
                      onSearchClear: () {
                        controller.clear();
                        field.didChange('');
                      },
                      onSubmitted: (value, _) {
                        controller.text = value;
                        field.didChange(value);
                      },
                      onEditingProgress: (value, _) {
                        controller.text = value;
                        field.didChange(value);
                      },
                    ),
                  ),
                ],
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
