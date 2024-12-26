// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomMultiSelectDropdown extends StatefulWidget {
  const CustomMultiSelectDropdown({
    super.key,
    this.width,
    this.height,
    required this.options,
    required this.excludeList,
    required this.onSelectionChanged,
    required this.hintText,
  });

  final double? width;
  final double? height;
  final List<UserRecord> options; // List of UserRecord objects from Firebase
  final List<DocumentReference>
      excludeList; // List of DocumentReferences to exclude
  final Future Function(List<UserRecord>? selectedOptions)
      onSelectionChanged; // Callback for selected options
  final String hintText; // Placeholder text

  @override
  State<CustomMultiSelectDropdown> createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  List<UserRecord> _selectedItems = []; // Store selected UserRecord objects
  String _searchText = ""; // Search text for filtering options

  // Toggle selection of a user
  void _toggleSelection(UserRecord item) {
    setState(() {
      // Toggle item presence in _selectedItems
      if (_selectedItems
          .any((selected) => selected.reference == item.reference)) {
        _selectedItems
            .removeWhere((selected) => selected.reference == item.reference);
      } else {
        _selectedItems.add(item);
      }
    });

    // Trigger callback with updated selections
    widget.onSelectionChanged(List<UserRecord>.from(_selectedItems));
  }

  @override
  Widget build(BuildContext context) {
    // Filter options based on search text and excludeList
    List<UserRecord> filteredOptions = widget.options
        .where((option) =>
            option.displayName != null &&
            option.displayName!
                .toLowerCase()
                .contains(_searchText.toLowerCase()) &&
            !widget.excludeList.contains(option.reference))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected items displayed as tags
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _selectedItems
              .map((item) => Chip(
                    label: Text(item.displayName ?? "Unknown"),
                    deleteIcon: Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() {
                        _selectedItems.removeWhere(
                            (selected) => selected.reference == item.reference);
                      });
                      widget.onSelectionChanged(
                          List<UserRecord>.from(_selectedItems));
                    },
                  ))
              .toList(),
        ),
        SizedBox(height: 8.0),

        // Dropdown container with text-based clear button
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: SizedBox(
                        height: 250,
                        child: Column(
                          children: [
                            // Search input with reduced width
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 250, // Adjust this width as needed
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _searchText = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            // List of selectable options
                            Expanded(
                              child: ListView.builder(
                                itemCount: filteredOptions.length,
                                itemBuilder: (context, index) {
                                  final option = filteredOptions[index];
                                  return ListTile(
                                    title:
                                        Text(option.displayName ?? "Unknown"),
                                    trailing:
                                        null, // Hide the trailing checkbox
                                    onTap: () {
                                      _toggleSelection(
                                          option); // Handle selection on tap
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                child: Container(
                  width: widget.width ?? double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedItems.isEmpty
                            ? widget.hintText
                            : 'Edit Selection',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            ),
            // Clear button as TextButton
            TextButton(
              onPressed: _selectedItems.isNotEmpty
                  ? () {
                      setState(() {
                        _selectedItems.clear();
                      });
                      widget.onSelectionChanged(
                          List<UserRecord>.from(_selectedItems));
                    }
                  : null,
              child: Text(
                'Clear',
                style: TextStyle(
                  color: _selectedItems.isNotEmpty
                      ? Colors.blue
                      : Colors.grey, // Disabled state color
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
