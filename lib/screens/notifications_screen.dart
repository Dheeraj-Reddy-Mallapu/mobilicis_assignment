import 'package:flutter/material.dart';
import 'package:mobilicis_assignment/const_colors.dart';
import 'package:mobilicis_assignment/firestore_db.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isLoading = true;

  loadNotifications() async {
    await getAllNotifications();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    loadNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {}, // Scaffold.of(context).openDrawer(),
          icon: Image.asset('assets/menu.png'),
        ),
        title: Image.asset('assets/logo.png', height: 28),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('All Notifications:', style: TextStyle(fontSize: 25)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification['title'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  notification['body'],
                                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
