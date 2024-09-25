import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lab2/wine_card.dart'; // Ensure this file contains the WineCard widget

import 'filter_category.dart'; // Ensure this file contains the Filter and CategoryFilter widgets
import 'header.dart'; // Ensure this file contains the Header widget
import 'search.dart'; // Ensure this file contains the SearchingBar widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _searchQuery = '';
  String? selectedCategory;
  Filter? selectedFilter;
  String? place; // This will store the selected place from the Header

  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
      selectedFilter = null; // Reset the filter when category changes
    });
  }

  void updateSelectedFilter(Filter filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  void updatePlace(String newPlace) {
    setState(() {
      place =
          newPlace; // Update the place with the selected title from the dropdown
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2 Vilcu Virgiliu',
      theme: ThemeData(
        fontFamily: 'Archivo',
        primaryColor: Colors.black,
        scaffoldBackgroundColor: HexColor("#D1D9E6"),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Header(onPlaceSelected: updatePlace), // Pass the callback
                const SizedBox(height: 10),
                SearchingBar(
                  onQueryChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  'Shop wines by',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                CategoryFilter(
                  categories: const ['Type', 'Country', 'Grape'],
                  categoryFilters: {
                    'Type': [
                      Filter(
                          name: 'Red',
                          imageLink:
                              'https://scontent.fkiv1-1.fna.fbcdn.net/v/t1.6435-9/117747226_3367043753352900_5745952388137357987_n.jpg?stp=dst-jpg_p526x296&_nc_cat=108&ccb=1-7&_nc_sid=7b2446&_nc_ohc=D7-jHqIdcUcQ7kNvgFFpBMw&_nc_ht=scontent.fkiv1-1.fna&_nc_gid=AF7sUtdXXhJZc8pMAYLO8HZ&oh=00_AYDOPprm4-XTWhawql_bnXmsSUzieIWKforZZ_cxDmI32A&oe=67116124',
                          count: 123),
                      Filter(
                          name: 'White',
                          imageLink:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTWgVgSIfaHupVTgbJZCrx1rt5dgRflV-sMg&s',
                          count: 98),
                      Filter(
                          name: 'Rose',
                          imageLink:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK35IlGDg4HgKQgzIeha7XpiV39oQ4maLHOg&s',
                          count: 45),
                    ],
                    'Country': [
                      Filter(
                          name: 'France',
                          imageLink:
                              'https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/800px-Flag_of_France.svg.png',
                          count: 150),
                      Filter(
                          name: 'USA',
                          imageLink:
                              'https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg',
                          count: 75),
                      Filter(
                          name: 'Italy',
                          imageLink:
                              'https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1200px-Flag_of_Italy.svg.png',
                          count: 80),
                    ],
                    'Grape': [
                      Filter(
                          name: 'Grenache',
                          imageLink:
                              'https://cdn11.bigcommerce.com/s-a4amd7x8/images/stencil/1280x1280/products/9342/10043/grenache_grapes__27204__88651.1578091517.jpg?c=2',
                          count: 60),
                      Filter(
                          name: 'Cabernet Sauvignon',
                          imageLink:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoOst53ifpiu0Umg8PR7Wuk9TLvzvKoXqIQg&s',
                          count: 120),
                      Filter(
                          name: 'Pinot Noir',
                          imageLink:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLGRbgs6l7uv7mWOUgvEB5vJ0HFFV9CGE_Iw&s',
                          count: 90),
                      Filter(
                          name: 'Chardonnay',
                          imageLink:
                              'https://www.rootsplants.co.uk/cdn/shop/products/vitischardonnay1.jpg?v=1631356167',
                          count: 110),
                      Filter(
                          name: 'Sauvignon Blanc',
                          imageLink:
                              'https://creative-formulas.com/wp-content/uploads/2021/12/sauvignon-blanc-base.jpg',
                          count: 95),
                    ],
                  },
                  onCategorySelected: updateSelectedCategory,
                  onFilterSelected: updateSelectedFilter,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wines',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Text(
                      'view all',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: HexColor('#BE2C55')),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const WineListScreen(), // Directly include the list here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
