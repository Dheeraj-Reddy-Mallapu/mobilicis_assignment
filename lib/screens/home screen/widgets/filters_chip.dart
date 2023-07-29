import 'package:flutter/material.dart';

class FiltersChip extends StatefulWidget {
  const FiltersChip({super.key, required this.label, required this.isSelected});
  final String label;
  final bool isSelected;

  @override
  State<FiltersChip> createState() => _FiltersChipState();
}

class _FiltersChipState extends State<FiltersChip> {
  late bool isSelected;
  int dummy = 0;
  @override
  Widget build(BuildContext context) {
    if (dummy == 0) {
      isSelected = widget.isSelected;
      dummy++;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 6.0, top: 6.0, bottom: 6.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? Colors.grey.shade400 : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Text(
                widget.label,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
        onTap: () => setState(() {
          isSelected = !isSelected;
        }),
      ),
    );
  }
}
