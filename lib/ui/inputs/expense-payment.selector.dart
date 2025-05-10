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
  @override
  void initState() {
    super.initState();

    selectedPaidBy =
        widget.paidByController.text.isNotEmpty
            ? widget.paidByController.text
            : null;

    if (selectedPaidBy != null && widget.onPaidByChanged != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        widget.onPaidByChanged!(selectedPaidBy!);
      });
    }

    final savedSpecific = widget.specificFromController.text;
    if (savedSpecific.isNotEmpty) {
      selectedSpecificFrom = savedSpecific;
    }

    widget.dataFuture.then((list) {
      if (selectedPaidBy == "Partner") {
        _buildPartnerMapping(list);
        if (!partnerMapping.containsValue(selectedSpecificFrom)) {
          selectedSpecificFrom = null;
        }
      } else if (selectedPaidBy == "Bank") {
        print("We inside the bank");
        print(selectedSpecificFrom);
        print(widget.specificFromController.text);
        print(widget.paidByController.text);
        final exists = list.any((b) => b.id.toString() == selectedSpecificFrom);
        if (!exists) {
          selectedSpecificFrom = null;
        }
      }
      setState(() {});
    });
  }

  // void initState() {
  //   super.initState();
  //   selectedPaidBy =
  //       widget.paidByController.text.isNotEmpty
  //           ? widget.paidByController.text
  //           : null;

  //   // Notify parent of the initial paidBy so they can set dataFuture
  //   if (selectedPaidBy != null && widget.onPaidByChanged != null) {
  //     WidgetsBinding.instance!.addPostFrameCallback((_) {
  //       widget.onPaidByChanged!(selectedPaidBy!);
  //     });
  //   }

  //   // **NEW**: Initialize selectedSpecificFrom for BOTH Partner *and* Bank
  //   final savedSpecific = widget.specificFromController.text;
  //   if (savedSpecific.isNotEmpty) {
  //     selectedSpecificFrom = savedSpecific;
  //   }

  //   // Build mapping or just trigger a rebuild once the data arrives
  //   widget.dataFuture.then((list) {
  //     if (selectedPaidBy == "Partner") {
  //       _buildPartnerMapping(list);
  //       // if you want to re-sync selectedSpecificFrom against mapping you can:
  //       if (!partnerMapping.containsValue(selectedSpecificFrom)) {
  //         selectedSpecificFrom = null;
  //       }
  //     } else {}
  //     setState(() {});
  //   });
  // }

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

                    items.addAll(
                      partnerMapping.entries.map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.key),
                        ),
                      ),
                    );

                    if (selectedSpecificFrom != null &&
                        selectedSpecificFrom!.endsWith('-addpartner')) {
                      items.insert(
                        0,
                        DropdownMenuItem(
                          value: selectedSpecificFrom,
                          child: Text(
                            selectedSpecificFrom!.replaceAll('-addpartner', ''),
                          ),
                        ),
                      );
                    }

                    items.add(
                      DropdownMenuItem(
                        value: "CONTACT_ADD",
                        child: Text(translate("Add from Contacts")),
                      ),
                    );
                  } else if (selectedPaidBy == "Bank" && snap.hasData) {
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
