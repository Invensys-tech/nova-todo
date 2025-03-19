// import 'package:flutter/material.dart';
// import 'package:advanced_search/advanced_search.dart';

// class AutoCompleteText extends StatelessWidget {
//   const AutoCompleteText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> searchableList = [
//       "Orange",
//       "Apple",
//       "Banana",
//       "Mango Orange",
//       "Carrot Apple",
//       "Yellow Watermelon",
//       "Zhe Fruit",
//       "White Oats",
//       "Dates",
//       "Raspberry Blue",
//       "Green Grapes",
//       "Red Grapes",
//       "Dragon Fruit",
//     ];
//     return SafeArea(
//       child: Container(
//         margin: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
//         child: AdvancedSearch(
//           searchItems: searchableList,
//           maxElementsToDisplay: 10,
//           singleItemHeight: 50,
//           borderColor: Colors.grey,
//           minLettersForSearch: 0,
//           selectedTextColor: Color(0xFF3363D9),
//           fontSize: 14,
//           borderRadius: 12.0,
//           hintText: 'Search Me',
//           cursorColor: Colors.blueGrey,
//           autoCorrect: false,
//           focusedBorderColor: Colors.blue,
//           searchResultsBgColor: Color(0xFAFAFA),
//           disabledBorderColor: Colors.cyan,
//           enabledBorderColor: Colors.black,
//           enabled: true,
//           caseSensitive: false,
//           inputTextFieldBgColor: Colors.white10,
//           clearSearchEnabled: true,
//           itemsShownAtStart: 10,
//           searchMode: SearchMode.CONTAINS,
//           showListOfResults: true,
//           unSelectedTextColor: Colors.black54,
//           verticalPadding: 10,
//           horizontalPadding: 10,
//           hideHintOnTextInputFocus: true,
//           hintTextColor: Colors.grey,
//           searchItemsWidget: searchWidget,
//           onItemTap: (index, value) {
//             print("selected item Index is $index");
//           },
//           onSearchClear: () {
//             print("Cleared Search");
//           },
//           onSubmitted: (value, value2) {
//             print("Submitted: " + value);
//           },
//           onEditingProgress: (value, value2) {
//             print("TextEdited: " + value);
//             print("LENGTH: " + value2.length.toString());
//           },
//         ),
//       ),
//     );
//   }
// }

// Widget searchWidget(String text) {
//   return ListTile(
//     title: Text(
//       text.length > 3 ? text.substring(0, 3) : text,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 16,
//         color: Colors.indigoAccent,
//       ),
//     ),
//     subtitle: Text(
//       text,
//       maxLines: 1,
//       overflow: TextOverflow.ellipsis,
//       style: TextStyle(
//         fontWeight: FontWeight.normal,
//         fontSize: 12,
//         color: Colors.black26,
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:advanced_search/advanced_search.dart';

class AutoCompleteText extends StatelessWidget {
  /// List of suggestions to search from.
  final List<String> suggestions;

  /// Function to build each suggestion widget.
  final Widget Function(String) suggestionBuilder;

  /// Hint text for the search field.
  final String hintText;

  /// Text editing controller.
  final TextEditingController controller;

  /// Icon to display on the left side.
  final IconData icon;

  const AutoCompleteText({
    Key? key,
    required this.suggestions,
    required this.suggestionBuilder,
    required this.hintText,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Outer container mimics the TextFields style
      decoration: BoxDecoration(
        color: Colors.black87.withOpacity(.3),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Row(
        children: [
          // Prefix icon with a vertical separator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              // color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.white54, width: 1.0),
              ),
            ),
            child: Icon(icon, color: Colors.white70),
          ),
          // The autocomplete field occupies the remaining space
          Expanded(
            child: AdvancedSearch(
              searchItems: suggestions,
              maxElementsToDisplay: 10,
              singleItemHeight: 50,
              // Remove AdvancedSearch's own border/background so that our container styling is used
              borderColor: Colors.transparent,
              borderRadius: 0.0,
              selectedTextColor: Colors.white70,
              hintText: hintText,
              hintTextColor: Colors.white,
              cursorColor: Colors.blueGrey,
              autoCorrect: false,
              focusedBorderColor: Colors.transparent,
              disabledBorderColor: Colors.transparent,
              enabledBorderColor: Colors.transparent,
              enabled: true,

              searchResultsBgColor: Colors.white,
              caseSensitive: false,
              // Make the text field transparent to show the container’s background
              inputTextFieldBgColor: Colors.transparent,
              clearSearchEnabled: true,
              itemsShownAtStart: 10,
              searchMode: SearchMode.CONTAINS,
              showListOfResults: true,
              // Set suggestions list text color to white
              unSelectedTextColor: Colors.white,
              verticalPadding: 10,
              horizontalPadding: 10,
              hideHintOnTextInputFocus: true,
              // Use the suggestion builder passed from the caller
              searchItemsWidget: suggestionBuilder,
              onItemTap: (index, value) {
                print("Selected item Index is $index");
              },
              onSearchClear: () {
                print("Cleared Search");
              },
              onSubmitted: (value, value2) {
                print("Submitted: $value");
              },
              onEditingProgress: (value, value2) {
                print("Text Edited: $value");
                print("LENGTH: ${value2.length}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
