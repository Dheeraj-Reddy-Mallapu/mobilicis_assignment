import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilicis_assignment/const_colors.dart';
import 'package:mobilicis_assignment/data/apis/listing_api_service.dart';
import 'package:mobilicis_assignment/data/objects/listing_object.dart';
import 'package:mobilicis_assignment/screens/home%20screen/widgets/listing_tile.dart';
import 'package:mobilicis_assignment/screens/search_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ListingApiService _listingApiService = ListingApiService();
  final int _itemsPerPage = 10;
  int _currentPage = 1;
  final List<Listing> _listings = [];

  bool _isLoading = true;

  final ScrollController _scrollController = ScrollController();

  Future<void> _loadNextPage() async {
    setState(() {
      _currentPage++;
    });

    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      final listings = await _listingApiService.fetchListings(_currentPage, _itemsPerPage);

      _listings.addAll(listings.listings);
      _isLoading = false;

      setState(() {});
    } catch (e) {
      Get.snackbar('Oops!', e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
        // Reached the end of the list, load the next page.
        _loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Image.asset('assets/menu.png'),
        ),
        title: Image.asset('assets/logo.png', height: 28),
        bottom: AppBar(
          toolbarHeight: 40,
          backgroundColor: primaryColor,
          title: Container(
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Icon(Icons.search, color: primaryColor),
                  ),
                  const Text('Search with make and model..', style: TextStyle(fontSize: 16)),
                ],
              ),
              onTap: () => Get.to(() => const SearchScreen(), transition: Transition.noTransition),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Buy Top Brands'),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: 135,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                      child: Image.asset('assets/brand${index + 1}.png'),
                    ),
                  );
                },
              ),
            ),
            const Text('Shop By'),
            const Text('Best Deals Near You'),
            !_isLoading
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisExtent: 250,
                      childAspectRatio: 2,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: _listings.length,
                    itemBuilder: (context, index) {
                      final listing = _listings[index];

                      return ListingTile(listing: listing);
                    },
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisExtent: 250,
                      childAspectRatio: 2,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer(
                          gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: backgroundColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: backgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
