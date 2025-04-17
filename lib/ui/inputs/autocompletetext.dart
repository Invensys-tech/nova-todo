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

  final void Function(String value)? onSelect;

  const AutoCompleteText({
    Key? key,
    required this.suggestions,
    required this.suggestionBuilder,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.onSelect,
    Null Function(dynamic selectedName)? onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Outer container mimics the TextFields style
      decoration: BoxDecoration(
        color: Colors.black87.withOpacity(.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),

        // border: Border.all(color: Colors.green, width: 2),
      ),
      child: Row(
        children: [
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
                // Capture the selected value
                controller.text = value;
                if (onSelect != null) {
                  onSelect!(value);
                }
              },
              onSearchClear: () {
                print("Cleared Search");
                controller.clear();
              },
              onSubmitted: (value, value2) {
                print("Submitted: $value");
                controller.text = value;
              },
              onEditingProgress: (value, value2) {
                print("Text Edited: $value");
                controller.text = value;
                print("LENGTH: ${value2.length}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
