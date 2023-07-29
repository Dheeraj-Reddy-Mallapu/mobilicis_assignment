import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilicis_assignment/const_colors.dart';
import 'package:mobilicis_assignment/data/objects/filter_object.dart';
import 'package:mobilicis_assignment/screens/home%20screen/widgets/filters_chip.dart';

class FiltersSheet extends StatefulWidget {
  const FiltersSheet({super.key, required this.filters});
  final Filters filters;

  @override
  State<FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<FiltersSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.25,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Clear Filter',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Text('Brand'),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.filters.make.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const FiltersChip(label: 'All', isSelected: true);
                          } else {
                            return FiltersChip(label: widget.filters.make[index - 1], isSelected: false);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('RAM'),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.filters.ram.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const FiltersChip(label: 'All', isSelected: true);
                          } else {
                            return FiltersChip(label: widget.filters.ram[index - 1], isSelected: false);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Storage'),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.filters.storage.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const FiltersChip(label: 'All', isSelected: true);
                          } else {
                            return FiltersChip(label: widget.filters.storage[index - 1], isSelected: false);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Condition'),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.filters.condition.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const FiltersChip(label: 'All', isSelected: true);
                          } else {
                            return FiltersChip(label: widget.filters.condition[index - 1], isSelected: false);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Location'),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.filters.location.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const FiltersChip(label: 'All', isSelected: true);
                          } else {
                            return FiltersChip(label: widget.filters.location[index - 1], isSelected: false);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: primaryColor),
                child: const Center(
                  child: Text(
                    'APPLY',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () => Get.back(),
            )
          ],
        ),
      ),
    );
  }
}
