import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilicis_assignment/data/apis/listing_api_service.dart';
import 'package:mobilicis_assignment/data/objects/listing_object.dart';
import 'package:mobilicis_assignment/screens/home%20screen/widgets/listing_tile.dart';

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
    return !_isLoading
        ? Scaffold(
            backgroundColor: const Color(0xFFFCFCFC),
            appBar: AppBar(
              title: const Text('Product List'),
            ),
            body: Column(
              children: [
                Expanded(
                    child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisExtent: 250,
                    childAspectRatio: 2,
                  ),
                  controller: _scrollController,
                  itemCount: _listings.length,
                  itemBuilder: (context, index) {
                    final listing = _listings[index];

                    return ListingTile(listing: listing);
                  },
                )),
              ],
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)));
  }
}
