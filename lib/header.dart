import 'dart:convert'; // To decode the JSON data

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Header extends StatefulWidget {
  final Function(String)
      onPlaceSelected; // Add a callback function to notify the parent widget

  const Header({super.key, required this.onPlaceSelected});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  List<Map<String, dynamic>> addressOptions = [];
  Map<String, dynamic>? selectedOption;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String data = await rootBundle.loadString('lib/address.json');
    setState(() {
      // Corrected to use Map<String, dynamic> to safely decode JSON
      addressOptions = List<Map<String, dynamic>>.from(json.decode(data));
      // Set initial selection
      selectedOption = addressOptions[0];
      widget.onPlaceSelected(selectedOption?['title']
          as String); // Notify the parent of the initial selection
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedOption == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.black),
                    const SizedBox(width: 2),
                    DropdownButton<Map<String, dynamic>>(
                      value: selectedOption,
                      items: addressOptions.map((Map<String, dynamic> option) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: option,
                          child: Text(
                            option['title'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedOption = newValue;
                          widget.onPlaceSelected(newValue?['title']
                              as String); // Notify the parent of the new selection
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  selectedOption?['address'] as String? ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: HexColor('#98A2B3'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 25),
          const NotificationIcon(),
        ],
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: HexColor('#98A2B3')),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.notifications,
            size: 30,
            color: HexColor('#475467'),
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: HexColor('#BE2C55'),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '22',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
