import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';

class PartnerSelector extends StatefulWidget {
  final List<Map<String, dynamic>> suggestions;
  final Widget Function(String) suggestionBuilder;
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final void Function(String)? onSelect;
  final bool isFromEdit;
  final String? Function(String?)? validator;

  const PartnerSelector({
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
  State<PartnerSelector> createState() => _AutoCompleteTextState();
}

class _AutoCompleteTextState extends State<PartnerSelector> {
  late bool _showPlainField;

  @override
  void initState() {
    super.initState();
    _showPlainField = widget.isFromEdit && widget.controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
                      ? TextField(
                        controller: widget.controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(widget.icon),
                          hintText: widget.hintText,
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          setState(() {
                            _showPlainField = false;
                          });
                        },
                        onChanged: (v) {
                          field.didChange(v);
                        },
                      )
                      : AdvancedSearch(
                        searchItems:
                            widget.suggestions
                                .map((e) => e['label'] as String)
                                .toList(),
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
                        searchItemsWidget:
                            (label) => widget.suggestionBuilder(label),
                        onItemTap: (idx, label) {
                          final value =
                              widget.suggestions
                                  .firstWhere(
                                    (item) => item['label'] == label,
                                  )['value']
                                  .toString();
                          widget.controller.text = value;
                          field.didChange(value);
                          widget.onSelect?.call(value);
                        },
                        onSearchClear: () {
                          widget.controller.clear();
                          field.didChange('');
                        },

                        onSubmitted: (val, _) {
                          final match = widget.suggestions.firstWhere(
                            (item) => item['label'] == val,
                            // orElse: () => {},
                          );
                          if (match.isNotEmpty) {
                            print("Jeles is Empty");
                            final value = match['value'].toString();
                            widget.controller.text = value;
                            field.didChange(value);
                          }
                        },
                        onEditingProgress: (val, _) {
                          setState(() {
                            widget.controller.text = val;
                          });
                          print(val);
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
