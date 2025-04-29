// import 'package:flutter/material.dart';

// import '../../main.dart';

// /// This widget shows two dropdowns in one row.
// /// The left dropdown ("Paid By") is static (choices: "Partner", "Bank").
// /// The right dropdown ("Specific From") uses a FutureBuilder to load its items from the database.
// /// When the “Paid By” selection changes, it calls the onPaidByChanged callback (if provided).
// class PaidByAndSpecificFromInput extends StatefulWidget {
//   final TextEditingController paidByController;
//   final TextEditingController specificFromController;
//   final Future<List<dynamic>> dataFuture;
//   final void Function(String newPaidBy)? onPaidByChanged;

//   const PaidByAndSpecificFromInput({
//     Key? key,
//     required this.paidByController,
//     required this.specificFromController,
//     required this.dataFuture,
//     this.onPaidByChanged,
//   }) : super(key: key);

//   @override
//   _PaidByAndSpecificFromInputState createState() =>
//       _PaidByAndSpecificFromInputState();
// }

// class _PaidByAndSpecificFromInputState
//     extends State<PaidByAndSpecificFromInput> {
//   String? selectedPaidBy;
//   String? selectedSpecificFrom;

//   // Used for the Partner option: mapping partner names to their id.
//   Map<String, int> partnerMapping = {};

//   @override
//   void initState() {
//     super.initState();
//     selectedPaidBy =
//         widget.paidByController.text.isNotEmpty
//             ? widget.paidByController.text
//             : null;
//     selectedSpecificFrom =
//         widget.specificFromController.text.isNotEmpty
//             ? widget.specificFromController.text
//             : null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Left Dropdown: "Paid By"
//         Container(
//           height: MediaQuery.of(context).size.height*.045,
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           decoration:  BoxDecoration(
//             color: isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(5),
//               bottomLeft: Radius.circular(5),
//             ),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               dropdownColor:isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
//               value: selectedPaidBy,
//               hint:  Text(
//                 "Paid By",
//                 style: TextStyle(fontSize: 12),
//               ),
//               icon: const Icon(Icons.arrow_drop_down, ),
//               style:  TextStyle( fontSize: 13,color: Theme.of(context).primaryColorLight),
//               items:
//                   ["Partner", "Bank"].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedPaidBy = value;
//                   widget.paidByController.text = value ?? '';
//                   // Clear specific field when Paid By changes
//                   selectedSpecificFrom = null;
//                   widget.specificFromController.clear();
//                 });
//                 // Notify parent so it can update the future.
//                 if (value != null && widget.onPaidByChanged != null) {
//                   widget.onPaidByChanged!(value);
//                 }
//               },
//             ),
//           ),
//         ),
//         // Right Dropdown: "Specific From"
//         Expanded(
//           child: FutureBuilder<List<dynamic>>(
//             future: widget.dataFuture,
//             builder: (context, snapshot) {
//               List<String> dynamicItems = [];
//               if (selectedPaidBy == "Partner") {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Error: ${snapshot.error}",
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 } else if (snapshot.hasData) {
//                   partnerMapping.clear();
//                   // Assume each data item is a Loan with loanerName and id.
//                   for (var loan in snapshot.data as List) {
//                     partnerMapping[loan.loanerName] = loan.id;
//                   }
//                   dynamicItems = partnerMapping.keys.toList();
//                 }
//               } else if (selectedPaidBy == "Bank") {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Error: ${snapshot.error}",
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 } else if (snapshot.hasData) {
//                   // Assume each data item is a Bank with an accountHolder property.
//                   dynamicItems =
//                       (snapshot.data as List)
//                           .map((bank) => bank.accountHolder as String)
//                           .toList();
//                 }
//               }

//               return Container(
//                 height: MediaQuery.of(context).size.height*.045,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   borderRadius:  BorderRadius.only(
//                     topRight: Radius.circular(5),
//                     bottomRight: Radius.circular(5),
//                   ),
//                   border: Border.all(
//                     color: isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
//                     width: 1.0,
//                   ),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     dropdownColor: isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
//                     isExpanded: true,
//                     value: selectedSpecificFrom,
//                     hint: const Text(
//                       "Specific From",
//                       style: TextStyle( fontSize: 12),
//                     ),
//                     icon: const Icon(
//                       Icons.arrow_drop_down,
//                     ),
//                     style: const TextStyle( fontSize: 13),
//                     items:
//                         dynamicItems.map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSpecificFrom = value;
//                         widget.specificFromController.text = value ?? '';
//                       });
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_translate/flutter_translate.dart';

class PaidByAndSpecificFromInput extends FormField<void> {
  PaidByAndSpecificFromInput({
    Key? key,
    required TextEditingController paidByController,
    required TextEditingController specificFromController,
    required Future<List<dynamic>> dataFuture,
    void Function(String newPaidBy)? onPaidByChanged,
  }) : super(
         key: key,
         validator: (_) {
           if (paidByController.text.isEmpty) {
             return "Please select who paid";
           }
           if (specificFromController.text.isEmpty) {
             return "Please select the specific source";
           }
           return null;
         },
         builder: (FormFieldState<void> field) {
           return _PaidByAndSpecificFromInputContent(
             paidByController: paidByController,
             specificFromController: specificFromController,
             dataFuture: dataFuture,
             onPaidByChanged: onPaidByChanged,
             showError: field.hasError,
             errorText: field.errorText,
           );
         },
       );
}

class _PaidByAndSpecificFromInputContent extends StatefulWidget {
  final TextEditingController paidByController;
  final TextEditingController specificFromController;
  final Future<List<dynamic>> dataFuture;
  final void Function(String newPaidBy)? onPaidByChanged;
  final bool showError;
  final String? errorText;

  const _PaidByAndSpecificFromInputContent({
    Key? key,
    required this.paidByController,
    required this.specificFromController,
    required this.dataFuture,
    this.onPaidByChanged,
    required this.showError,
    required this.errorText,
  }) : super(key: key);

  @override
  State<_PaidByAndSpecificFromInputContent> createState() =>
      _PaidByAndSpecificFromInputContentState();
}

class _PaidByAndSpecificFromInputContentState
    extends State<_PaidByAndSpecificFromInputContent> {
  String? selectedPaidBy;
  String? selectedSpecificFrom;
  Map<String, int> partnerMapping = {};

  @override
  void initState() {
    super.initState();
    selectedPaidBy =
        widget.paidByController.text.isNotEmpty
            ? widget.paidByController.text
            : null;
    selectedSpecificFrom =
        widget.specificFromController.text.isNotEmpty
            ? widget.specificFromController.text
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            /// Left dropdown
            Container(
              height: MediaQuery.of(context).size.height * .045,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xff27272A) : const Color(0xffD4D4D8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor:
                      isDark
                          ? const Color(0xff27272A)
                          : const Color(0xffD4D4D8),
                  value: selectedPaidBy,
                  hint:  Text(translate("Paid By"), style: TextStyle(fontSize: 12)),
                  icon: const Icon(Icons.arrow_drop_down),
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  items:
                      ["Partner", "Bank"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPaidBy = value;
                      widget.paidByController.text = value ?? '';
                      selectedSpecificFrom = null;
                      widget.specificFromController.clear();
                    });
                    if (value != null && widget.onPaidByChanged != null) {
                      widget.onPaidByChanged!(value);
                    }
                  },
                ),
              ),
            ),

            /// Right dropdown
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: widget.dataFuture,
                builder: (context, snapshot) {
                  List<String> dynamicItems = [];

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    if (selectedPaidBy == "Partner") {
                      partnerMapping.clear();
                      for (var loan in snapshot.data as List) {
                        partnerMapping[loan.loanerName] = loan.id;
                      }
                      dynamicItems = partnerMapping.keys.toList();
                    } else if (selectedPaidBy == "Bank") {
                      dynamicItems =
                          (snapshot.data as List)
                              .map((bank) => bank.accountHolder as String)
                              .toList();
                    }
                  }

                  return Container(
                    height: MediaQuery.of(context).size.height * .045,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      border: Border.all(
                        color:
                            isDark
                                ? const Color(0xff27272A)
                                : const Color(0xffD4D4D8),
                        width: 1.0,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor:
                            isDark
                                ? const Color(0xff27272A)
                                : const Color(0xffD4D4D8),
                        isExpanded: true,
                        value: selectedSpecificFrom,
                        hint:  Text(
                          translate("Specific From"),
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        style:  TextStyle(fontSize: 13,color: Theme.of(context).primaryColorLight),
                        items:
                            dynamicItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSpecificFrom = value;
                            widget.specificFromController.text = value ?? '';
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        /// Error message
        if (widget.showError)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              widget.errorText ?? '',
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
      ],
    );
  }
}
