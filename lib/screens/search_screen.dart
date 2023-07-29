import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilicis_assignment/data/apis/search_api_service.dart';
import 'package:mobilicis_assignment/data/objects/search_object.dart';

import '../const_colors.dart';
import 'notifications_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchC = TextEditingController();

  final SearchApiService _searchService = SearchApiService();
  late Search _search;

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String searchText) async {
    try {
      _search = await _searchService.performSearch(searchText);
      setState(() {});
    } catch (e) {
      // Handle the error.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {}, //Scaffold.of(context).openDrawer()
          icon: Image.asset('assets/menu.png'),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const NotificationsScreen()),
              icon: const Icon(Icons.notifications_outlined, color: Colors.white)),
        ],
        title: Image.asset('assets/logo.png', height: 28),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 4.0),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: searchC,
                autofocus: true,
                style: const TextStyle(fontSize: 15),
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  border: InputBorder.none,
                  icon: searchC.text == ''
                      ? const Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Icon(Icons.search, color: Colors.grey),
                        )
                      : null,
                  hintText: 'Search with make and model..',
                ),
                onChanged: (value) {
                  _performSearch(searchC.text);
                },
              ),
            ),
          ),
        ),
      ),
      body: searchC.text != ''
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Brand', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ),
                    SizedBox(
                      height: _search.makes.length * 35,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _search.makes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_search.makes[index]),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Mobile Model', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ),
                    SizedBox(
                      height: _search.models.length * 35,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _search.models.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_search.models[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Column(),
    );
  }
}
