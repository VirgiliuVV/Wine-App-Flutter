import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchingBar extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;

  const SearchingBar({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: HexColor('#475467')),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onQueryChanged,
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 25,
            width: 2,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: HexColor('#909599')),
            ),
          ),
          const SizedBox(width: 5),
          Icon(Icons.mic, color: HexColor('#475467')),
        ],
      ),
    );
  }
}
