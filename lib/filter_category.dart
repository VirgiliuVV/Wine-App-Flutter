import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> categories;
  final Map<String, List<Filter>> categoryFilters;
  final Function(String) onCategorySelected; // Callback for category selection
  final Function(Filter) onFilterSelected; // Callback for filter selection

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.categoryFilters,
    required this.onCategorySelected,
    required this.onFilterSelected,
  });

  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String? selectedCategory;
  Filter? selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedCategory =
        widget.categories.isNotEmpty ? widget.categories[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    final filters = widget.categoryFilters[selectedCategory] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(1),
          child: Wrap(
            spacing: 10.0,
            children: widget.categories.map((category) {
              return ChoiceChip(
                showCheckmark: false,
                backgroundColor: HexColor("#D1D9E6"),
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (bool selected) {
                  setState(() {
                    selectedCategory = category;
                    selectedFilter = null; // Reset filter on category change
                    widget.onCategorySelected(
                        category); // Notify parent of the category change
                  });
                },
                selectedColor: HexColor('#F5DFE5').withOpacity(0.5),
                labelStyle: TextStyle(
                  color: selectedCategory == category
                      ? HexColor('#BE2C55')
                      : HexColor('#475467'),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: selectedCategory == category
                        ? HexColor('#BE2C55')
                        : HexColor('#475467'),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                avatar: null,
              );
            }).toList(),
          ),
        ),
        filters.isNotEmpty
            ? SizedBox(
                height: 330,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    final isSelected = selectedFilter == filter;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                            widget.onFilterSelected(
                                filter); // Notify parent of the filter selection
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: isSelected
                                ? BorderSide(
                                    color: HexColor('#BE2C55'),
                                    width: 2,
                                  )
                                : BorderSide.none,
                          ),
                          child: SizedBox(
                            width: 175,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        filter.imageLink,
                                        height: 250,
                                        width: 360,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: HexColor('#BE2C55'),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          filter.count.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  filter.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? HexColor('#BE2C55')
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Center(
                child: Text("No filters available for this category")),
      ],
    );
  }
}

class Filter {
  final String name;
  final String imageLink;
  final int count;

  Filter({
    required this.name,
    required this.imageLink,
    required this.count,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final otherFilter = other as Filter;
    return name == otherFilter.name &&
        imageLink == otherFilter.imageLink &&
        count == otherFilter.count;
  }

  @override
  int get hashCode => Object.hash(name, imageLink, count);
}
