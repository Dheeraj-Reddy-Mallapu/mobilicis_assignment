import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobilicis_assignment/const_colors.dart';
import 'package:mobilicis_assignment/data/apis/filters_api_service.dart';
import 'package:mobilicis_assignment/data/apis/listing_api_service.dart';
import 'package:mobilicis_assignment/data/objects/filter_object.dart';
import 'package:mobilicis_assignment/data/objects/listing_object.dart';
import 'package:mobilicis_assignment/notification_service.dart';
import 'package:mobilicis_assignment/screens/home%20screen/widgets/filters_sheet.dart';
import 'package:mobilicis_assignment/screens/home%20screen/widgets/listing_tile.dart';
import 'package:mobilicis_assignment/screens/notifications_screen.dart';
import 'package:mobilicis_assignment/screens/search_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ListingApiService _listingApiService = ListingApiService();
  final FiltersApiService _filterApiService = FiltersApiService();

  final int _itemsPerPage = 10;
  int _currentPage = 1;

  final List<Listing> _listings = [];
  late Filters _filters;

  bool _isLoading = true;

  final ScrollController _scrollController = ScrollController();
  final PageController _bannerScrollController = PageController();

  Future<void> _loadNextPage() async {
    setState(() {
      _currentPage++;
    });

    await _loadListings();
  }

  Future<void> _loadListings() async {
    try {
      final listings = await _listingApiService.fetchListings(_currentPage, _itemsPerPage);

      _listings.addAll(listings.listings);
      _isLoading = false;

      setState(() {});
    } catch (e) {
      Get.snackbar('Oops!', e.toString());
    }
  }

  Future<void> _loadFilters() async {
    try {
      final filter = await _filterApiService.fetchFilter(false);
      _filters = filter.filters;
    } catch (e) {
      Get.snackbar('Oops!', e.toString());
    }
  }

  //// notification service
  final _messagingService = MessagingService();

  @override
  void initState() {
    super.initState();
    _messagingService.init(context);
    _loadFilters();
    _loadListings();

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
          onPressed: () {}, // Scaffold.of(context).openDrawer(),
          icon: Image.asset('assets/menu.png'),
        ),
        actions: [
          GestureDetector(
            child: Row(
              children: [
                Text(_location, style: const TextStyle(color: Colors.white)),
                const Icon(Icons.place, color: Colors.white),
              ],
            ),
            onTap: () {},
          ),
          IconButton(
              onPressed: () => Get.to(() => const NotificationsScreen()),
              icon: const Icon(Icons.notifications_outlined, color: Colors.white)),
        ],
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
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Buy Top Brands',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      width: 75,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                      child: Image.asset('assets/brand${index + 1}.png'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _bannerScrollController,
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                          child: Image.asset('assets/banner1.jpg', fit: BoxFit.fill),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'assets/sell.png',
                                  fit: BoxFit.fill,
                                  height: 80,
                                  width: 160,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'assets/buy.png',
                                  fit: BoxFit.fill,
                                  height: 80,
                                  width: 160,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                      child: Image.asset(
                        'assets/banner${index + 1}.jpg',
                        fit: BoxFit.fill,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: SmoothPageIndicator(
                    controller: _bannerScrollController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: primaryColor,
                      dotColor: Colors.grey.shade600,
                      radius: 2,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Shop By',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        Container(
                          width: 75,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('assets/shopBy${index + 1}.svg', height: 40),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: 60,
                            child: Text(
                              shopBy[index],
                              style: const TextStyle(fontSize: 10),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Best Deals Near You',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          _location,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 251, 212, 36),
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(255, 251, 212, 36)),
                        ),
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => FiltersSheet(filters: _filters),
                        );
                        // Get.bottomSheet(const FiltersSheet(), backgroundColor: Colors.white);
                      },
                      child: const Text('Filter ⇅', style: TextStyle(color: Colors.black)))
                ],
              ),
            ),
            !_isLoading
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisExtent: 250,
                      childAspectRatio: 2,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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

  final String _location = 'India';
  List<String> shopBy = ['Bestselling Mobiles', 'Verified Devices Only', 'Like New Condition', 'Phones With Warranty'];
}
