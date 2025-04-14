import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> options;
  final String label;
  final String selectedValue;
  final void Function(String value) onChange;
  const CategorySelector({
    super.key,
    required this.options,
    required this.label,
    required this.selectedValue,
    required this.onChange,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: MediaQuery.of(context).size.height * 0.012,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              ...widget.options.map(
                (option) => IntrinsicWidth(
                  child: GestureDetector(
                    onTap: () => widget.onChange(option),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              option == widget.selectedValue
                                  ? Color(0xFF00D492)
                                  : Color(0xFFE4E4E7),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          spacing: MediaQuery.of(context).size.width * 0.02,
                          children: [
                            option == widget.selectedValue
                                ? Icon(
                                  Icons.circle,
                                  color: Color(0xFF00D492),
                                  size: 18,
                                )
                                : Icon(
                                  Icons.circle_outlined,
                                  color: Color(0xFFE4E4E7),
                                  size: 18,
                                ),
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
