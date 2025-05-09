// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_translate/flutter_translate.dart';

// class PaidByAndSpecificFromInput extends FormField<void> {
//   PaidByAndSpecificFromInput({
//     Key? key,
//     required TextEditingController paidByController,
//     required TextEditingController specificFromController,
//     TextEditingController? bankController,

//     required Future<List<dynamic>> dataFuture,
//     void Function(String newPaidBy)? onPaidByChanged,
//   }) : super(
//          key: key,
//          validator: (_) {
//            if (paidByController.text.isEmpty) {
//              return "Please select who paid";
//            }
//            if (specificFromController.text.isEmpty) {
//              return "Please select the specific source";
//            }
//            return null;
//          },
//          builder: (FormFieldState<void> field) {
//            return _PaidByAndSpecificFromInputContent(
//              paidByController: paidByController,
//              specificFromController: specificFromController,
//              dataFuture: dataFuture,
//              onPaidByChanged: onPaidByChanged,
//              showError: field.hasError,
//              errorText: field.errorText,
//            );
//          },
//        );
// }

// class _PaidByAndSpecificFromInputContent extends StatefulWidget {
//   final TextEditingController paidByController;
//   final TextEditingController specificFromController;
//   final Future<List<dynamic>> dataFuture;
//   final void Function(String newPaidBy)? onPaidByChanged;
//   final bool showError;
//   final String? errorText;

//   const _PaidByAndSpecificFromInputContent({
//     Key? key,
//     required this.paidByController,
//     required this.specificFromController,
//     required this.dataFuture,
//     this.onPaidByChanged,
//     required this.showError,
//     required this.errorText,
//   }) : super(key: key);

//   @override
//   State<_PaidByAndSpecificFromInputContent> createState() =>
//       _PaidByAndSpecificFromInputContentState();
// }

// class _PaidByAndSpecificFromInputContentState
//     extends State<_PaidByAndSpecificFromInputContent> {
//   String? selectedPaidBy;
//   String? selectedSpecificFrom;
//   Map<String, String> partnerMapping = {};

//   @override
//   void initState() {
//     super.initState();
//     selectedPaidBy =
//         widget.paidByController.text.isNotEmpty
//             ? widget.paidByController.text
//             : null;

//     if (selectedPaidBy != null && widget.onPaidByChanged != null) {
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         widget.onPaidByChanged!(selectedPaidBy!);
//       });
//     }

//     widget.dataFuture.then((list) {
//       if (selectedPaidBy == "Partner") {
//         partnerMapping.clear();
//         for (var loan in list) {
//           final key = '${loan.loanerName}-${loan.bank}-${loan.phoneNumber}';
//           partnerMapping[key] = loan.id;
//         }

//         final saved = widget.specificFromController.text;
//         if (saved.isNotEmpty && partnerMapping.containsKey(saved)) {
//           selectedSpecificFrom = saved;
//         }
//       } else if (selectedPaidBy == "Bank") {
//         final saved = widget.specificFromController.text;
//         if (saved.isNotEmpty) {
//           selectedSpecificFrom = saved;
//         }
//       }
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             /// Left dropdown
//             Container(
//               height: MediaQuery.of(context).size.height * .045,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 color:
//                     isDark ? const Color(0xff27272A) : const Color(0xffD4D4D8),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(5),
//                   bottomLeft: Radius.circular(5),
//                 ),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   dropdownColor:
//                       isDark
//                           ? const Color(0xff27272A)
//                           : const Color(0xffD4D4D8),
//                   value: selectedPaidBy,
//                   hint: Text(
//                     translate("Paid By"),
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   icon: const Icon(Icons.arrow_drop_down),
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Theme.of(context).primaryColorLight,
//                   ),
//                   items:
//                       ["Partner", "Bank"].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedPaidBy = value;
//                       widget.paidByController.text = value ?? '';
//                       selectedSpecificFrom = null;
//                       widget.specificFromController.clear();
//                     });
//                     if (value != null && widget.onPaidByChanged != null) {
//                       widget.onPaidByChanged!(value);
//                     }
//                   },
//                 ),
//               ),
//             ),

//             /// Right dropdown
//             Expanded(
//               child: FutureBuilder<List<dynamic>>(
//                 future: widget.dataFuture,
//                 builder: (context, snapshot) {
//                   List<Map<String, dynamic>> dynamicItems = [];

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Error: ${snapshot.error}",
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     );
//                   } else if (snapshot.hasData) {
//                     if (selectedPaidBy == "Partner") {
//                       partnerMapping.clear();

//                       for (var loan in snapshot.data as List) {
//                         if (loan.bank != "Expense") {
//                           final key =
//                               '${loan.loanerName}-${loan.bank}-${loan.phoneNumber}';
//                           partnerMapping[key] = loan.loanerName;
//                         }
//                       }
//                       print(partnerMapping);

//                       dynamicItems =
//                           partnerMapping.entries
//                               .map(
//                                 (partner) => {
//                                   "value": partner.value,
//                                   "label": partner.key,
//                                 },
//                               )
//                               .toList();
//                     } else if (selectedPaidBy == "Bank") {
//                       dynamicItems =
//                           (snapshot.data as List)
//                               .where((bank) => bank.accountBank != "Expense")
//                               .map(
//                                 (bank) => {
//                                   "value": bank.id,
//                                   "label":
//                                       "${bank.accountHolder}-${bank.accountBank}-${bank.accountNumber}",
//                                 },
//                               )
//                               .toList();
//                     }
//                   }

//                   return Container(
//                     height: MediaQuery.of(context).size.height * .045,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(5),
//                         bottomRight: Radius.circular(5),
//                       ),
//                       border: Border.all(
//                         color:
//                             isDark
//                                 ? const Color(0xff27272A)
//                                 : const Color(0xffD4D4D8),
//                         width: 1.0,
//                       ),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         dropdownColor:
//                             isDark
//                                 ? const Color(0xff27272A)
//                                 : const Color(0xffD4D4D8),
//                         isExpanded: true,
//                         value: selectedSpecificFrom,
//                         hint: Text(
//                           translate("Specific From"),
//                           style: TextStyle(fontSize: 12),
//                         ),
//                         icon: const Icon(Icons.arrow_drop_down),
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Theme.of(context).primaryColorLight,
//                         ),
//                         items:
//                             dynamicItems.map((value) {
//                               return DropdownMenuItem<String>(
//                                 value: value['value'].toString(),
//                                 child: Text(value['label']),
//                               );
//                             }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedSpecificFrom = value;
//                             widget.specificFromController.text = value ?? '';
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),

//         if (widget.showError)
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, top: 4.0),
//             child: Text(
//               widget.errorText ?? '',
//               style: TextStyle(color: Colors.red[700], fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

class PaidByAndSpecificFromInput extends FormField<void> {
  PaidByAndSpecificFromInput({
    Key? key,
    required TextEditingController paidByController,
    required TextEditingController specificFromController,
    TextEditingController? bankController,
    required Future<List<dynamic>> dataFuture,
    void Function(String newPaidBy)? onPaidByChanged,
  }) : super(
         key: key,
         validator: (_) {
           if (paidByController.text.isEmpty) {
             return translate("Please select who paid");
           }
           if (specificFromController.text.isEmpty) {
             return translate("Please select the specific source");
           }
           return null;
         },
         builder: (fieldState) {
           return _PaidByAndSpecificFromInputContent(
             paidByController: paidByController,
             specificFromController: specificFromController,
             dataFuture: dataFuture,
             onPaidByChanged: onPaidByChanged,
             showError: fieldState.hasError,
             errorText: fieldState.errorText,
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
  Map<String, String> partnerMapping = {};
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  @override
  void initState() {
    super.initState();
    selectedPaidBy =
        widget.paidByController.text.isNotEmpty
            ? widget.paidByController.text
            : null;

    // Propagate initial PaidBy
    if (selectedPaidBy != null && widget.onPaidByChanged != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        widget.onPaidByChanged!(selectedPaidBy!);
      });
    }

    // Preload partners if already selected
    widget.dataFuture.then((list) {
      if (selectedPaidBy == "Partner") {
        _buildPartnerMapping(list);
        final saved = widget.specificFromController.text;
        if (saved.isNotEmpty && partnerMapping.containsValue(saved)) {
          selectedSpecificFrom = saved;
        }
      }
      setState(() {});
    });
  }

  void _buildPartnerMapping(List<dynamic> list) {
    partnerMapping.clear();
    print("-------------------------------------");
    print(list);
    for (var loan in list) {
      final label = '${loan.name} – ${loan.phone_number}';
      partnerMapping[label] = loan.id.toString();
    }
  }

  Future<void> _pickContact() async {
    final Contact? contact = await _contactPicker.selectContact();
    if (contact != null) {
      final name = contact.fullName ?? '';
      final phones = contact.phoneNumbers ?? [];
      final combined = '$name–$phones-addpartner';

      setState(() {
        widget.specificFromController.text = combined;
        selectedSpecificFrom = widget.specificFromController.text;
      });
      debugPrint("Picked contact: $combined");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
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
                  hint: Text(
                    translate("Paid By"),
                    style: const TextStyle(fontSize: 12),
                  ),
                  items:
                      ["Partner", "Bank"]
                          .map(
                            (v) => DropdownMenuItem(value: v, child: Text(v)),
                          )
                          .toList(),
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

            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: widget.dataFuture,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snap.hasError) {
                    return Text(
                      "${translate("Error")}: ${snap.error}",
                      style: const TextStyle(color: Colors.red),
                    );
                  }

                  final items = <DropdownMenuItem<String>>[];

                  if (selectedPaidBy == "Partner" && snap.hasData) {
                    _buildPartnerMapping(snap.data!);

                    // 1) Insert all your saved partners:
                    items.addAll(
                      partnerMapping.entries.map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.key),
                        ),
                      ),
                    );

                    // 2) If the user has just picked a contact, include it as an item:
                    if (selectedSpecificFrom != null &&
                        selectedSpecificFrom!.endsWith('-addpartner')) {
                      items.insert(
                        0,
                        DropdownMenuItem(
                          value: selectedSpecificFrom,
                          child: Text(
                            // You can strip the “-addpartner” suffix if you like:
                            selectedSpecificFrom!.replaceAll('-addpartner', ''),
                          ),
                        ),
                      );
                    }

                    // 3) Finally, always include the “Add from Contacts” action:
                    items.add(
                      DropdownMenuItem(
                        value: "CONTACT_ADD",
                        child: Text(translate("Add from Contacts")),
                      ),
                    );
                  }
                  // if (selectedPaidBy == "Partner" && snap.hasData) {
                  //   _buildPartnerMapping(snap.data!);
                  //   items.addAll(
                  //     partnerMapping.entries.map(
                  //       (e) => DropdownMenuItem(
                  //         value: e.value,
                  //         child: Text(e.key),
                  //       ),
                  //     ),
                  //   );
                  //   items.add(
                  //     DropdownMenuItem(
                  //       value: "CONTACT_ADD",
                  //       child: Text(translate("Add from Contacts")),
                  //     ),
                  //   );
                  // }
                  else if (selectedPaidBy == "Bank" && snap.hasData) {
                    items.addAll(
                      (snap.data as List)
                          .where((b) => b.accountBank != "Expense")
                          .map(
                            (b) => DropdownMenuItem(
                              value: b.id.toString(),
                              child: Text(
                                "${b.accountHolder}-${b.accountBank}-${b.accountNumber}",
                              ),
                            ),
                          ),
                    );
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
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        dropdownColor:
                            isDark
                                ? const Color(0xff27272A)
                                : const Color(0xffD4D4D8),
                        value: selectedSpecificFrom,
                        hint: Text(
                          translate("Specific From"),
                          style: const TextStyle(fontSize: 12),
                        ),
                        items: items,
                        onChanged: (value) {
                          if (value == "CONTACT_ADD") {
                            _pickContact();
                          } else {
                            setState(() {
                              selectedSpecificFrom = value;
                              widget.specificFromController.text = value ?? '';
                            });
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        if (widget.showError)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),

        if (selectedSpecificFrom != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              "${translate("Selected")}: $selectedSpecificFrom",
              style: const TextStyle(fontSize: 13),
            ),
          ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
// import 'package:flutter_native_contact_picker/model/contact.dart';

// class PaidByAndSpecificFromInput extends FormField<void> {
//   PaidByAndSpecificFromInput({
//     Key? key,
//     required TextEditingController paidByController,
//     required TextEditingController specificFromController,
//     TextEditingController? bankController,
//     required Future<List<dynamic>> dataFuture,
//     void Function(String newPaidBy)? onPaidByChanged,
//   }) : super(
//          key: key,
//          validator: (_) {
//            if (paidByController.text.isEmpty) {
//              return translate("Please select who paid");
//            }
//            if (specificFromController.text.isEmpty) {
//              return translate("Please select the specific source");
//            }
//            return null;
//          },
//          builder: (fieldState) {
//            return _PaidByAndSpecificFromInputContent(
//              paidByController: paidByController,
//              specificFromController: specificFromController,
//              dataFuture: dataFuture,
//              onPaidByChanged: onPaidByChanged,
//              showError: fieldState.hasError,
//              errorText: fieldState.errorText,
//            );
//          },
//        );
// }

// class _PaidByAndSpecificFromInputContent extends StatefulWidget {
//   final TextEditingController paidByController;
//   final TextEditingController specificFromController;
//   final Future<List<dynamic>> dataFuture;
//   final void Function(String newPaidBy)? onPaidByChanged;
//   final bool showError;
//   final String? errorText;

//   const _PaidByAndSpecificFromInputContent({
//     Key? key,
//     required this.paidByController,
//     required this.specificFromController,
//     required this.dataFuture,
//     this.onPaidByChanged,
//     required this.showError,
//     required this.errorText,
//   }) : super(key: key);

//   @override
//   State<_PaidByAndSpecificFromInputContent> createState() =>
//       _PaidByAndSpecificFromInputContentState();
// }

// class _PaidByAndSpecificFromInputContentState
//     extends State<_PaidByAndSpecificFromInputContent> {
//   String? selectedPaidBy;
//   String? selectedSpecificFrom;
//   Map<String, String> partnerMapping = {};
//   final FlutterNativeContactPicker _contactPicker =
//       FlutterNativeContactPicker();

//   @override
//   void initState() {
//     super.initState();
//     selectedPaidBy =
//         widget.paidByController.text.isNotEmpty
//             ? widget.paidByController.text
//             : null;

//     // Propagate initial PaidBy
//     if (selectedPaidBy != null && widget.onPaidByChanged != null) {
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         widget.onPaidByChanged!(selectedPaidBy!);
//       });
//     }

//     // Preload partners if already selected
//     widget.dataFuture.then((list) {
//       if (selectedPaidBy == "Partner") {
//         _buildPartnerMapping(list);
//         final saved = widget.specificFromController.text;
//         if (saved.isNotEmpty && partnerMapping.containsValue(saved)) {
//           selectedSpecificFrom = saved;
//         }
//       }
//       setState(() {});
//     });
//   }

//   void _buildPartnerMapping(List<dynamic> list) {
//     partnerMapping.clear();
//     for (var loan in list) {
//       if (loan.bank != "Expense") {
//         final label = '${loan.loanerName} – ${loan.bank}';
//         partnerMapping[label] = loan.loanerName;
//       }
//     }
//   }

//   Future<void> _pickContact() async {
//     final Contact? contact = await _contactPicker.selectContact();
//     if (contact != null) {
//       final name = contact.fullName ?? '';
//       final phones = contact.phoneNumbers ?? [];
//       final phone = phones.isNotEmpty ? phones.first : '';
//       final combined = '$name – $phone';

//       setState(() {
//         selectedSpecificFrom = combined;
//         widget.specificFromController.text = combined;
//       });
//       debugPrint("Picked contact: $combined");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             // “Paid By” dropdown
//             Container(
//               height: MediaQuery.of(context).size.height * .045,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 color:
//                     isDark ? const Color(0xff27272A) : const Color(0xffD4D4D8),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(5),
//                   bottomLeft: Radius.circular(5),
//                 ),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   dropdownColor:
//                       isDark
//                           ? const Color(0xff27272A)
//                           : const Color(0xffD4D4D8),
//                   value: selectedPaidBy,
//                   hint: Text(
//                     translate("Paid By"),
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                   items:
//                       ["Partner", "Bank"]
//                           .map(
//                             (v) => DropdownMenuItem(value: v, child: Text(v)),
//                           )
//                           .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedPaidBy = value;
//                       widget.paidByController.text = value ?? '';
//                       selectedSpecificFrom = null;
//                       widget.specificFromController.clear();
//                     });
//                     if (value != null && widget.onPaidByChanged != null) {
//                       widget.onPaidByChanged!(value);
//                     }
//                   },
//                 ),
//               ),
//             ),

//             // “Specific From” dropdown (partners + Add from Contacts)
//             Expanded(
//               child: FutureBuilder<List<dynamic>>(
//                 future: widget.dataFuture,
//                 builder: (context, snap) {
//                   if (snap.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snap.hasError) {
//                     return Text(
//                       "${translate("Error")}: ${snap.error}",
//                       style: const TextStyle(color: Colors.red),
//                     );
//                   }

//                   // Build list items
//                   final items = <DropdownMenuItem<String>>[];

//                   if (selectedPaidBy == "Partner" && snap.hasData) {
//                     _buildPartnerMapping(snap.data!);
//                     // add each partner
//                     items.addAll(
//                       partnerMapping.entries.map(
//                         (e) => DropdownMenuItem(
//                           value: e.value,
//                           child: Text(e.key),
//                         ),
//                       ),
//                     );
//                     // finally, add contact option
//                     items.add(
//                       DropdownMenuItem(
//                         value: "CONTACT_ADD",
//                         child: Text(translate("Add from Contacts")),
//                       ),
//                     );
//                   } else if (selectedPaidBy == "Bank" && snap.hasData) {
//                     items.addAll(
//                       (snap.data as List)
//                           .where((b) => b.accountBank != "Expense")
//                           .map(
//                             (b) => DropdownMenuItem(
//                               value: b.id.toString(),
//                               child: Text(
//                                 "${b.accountHolder}-${b.accountBank}-${b.accountNumber}",
//                               ),
//                             ),
//                           ),
//                     );
//                   }

//                   return Container(
//                     height: MediaQuery.of(context).size.height * .045,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(5),
//                         bottomRight: Radius.circular(5),
//                       ),
//                       border: Border.all(
//                         color:
//                             isDark
//                                 ? const Color(0xff27272A)
//                                 : const Color(0xffD4D4D8),
//                       ),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         dropdownColor:
//                             isDark
//                                 ? const Color(0xff27272A)
//                                 : const Color(0xffD4D4D8),
//                         value: selectedSpecificFrom,
//                         hint: Text(
//                           translate("Specific From"),
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                         items: items,
//                         onChanged: (value) {
//                           if (value == "CONTACT_ADD") {
//                             _pickContact();
//                           } else {
//                             setState(() {
//                               selectedSpecificFrom = value;
//                               widget.specificFromController.text = value ?? '';
//                             });
//                           }
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),

//         // validation error
//         if (widget.showError)
//           Padding(
//             padding: const EdgeInsets.only(left: 8, top: 4),
//             child: Text(
//               widget.errorText!,
//               style: TextStyle(color: Colors.red[700], fontSize: 12),
//             ),
//           ),

//         // optionally show current selection
//         if (selectedSpecificFrom != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Text(
//               "${translate("Selected")}: $selectedSpecificFrom",
//               style: const TextStyle(fontSize: 13),
//             ),
//           ),
//       ],
//     );
//   }
// }
