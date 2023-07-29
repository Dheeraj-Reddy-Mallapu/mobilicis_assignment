import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final db = FirebaseFirestore.instance;

String userId = 'ak6j2hsd6flha86sdf'; //  FirebaseAuth.instance.currentUser!.uid -> in real scenario;

List<dynamic> notifications = [];

saveNotification(RemoteMessage message) async {
  final notificationData = message.data;

  await db.collection(userId).doc('notifications').get().then((value) async {
    if (value.exists) {
      await db.collection(userId).doc('notifications').update({
        'notifications': FieldValue.arrayUnion([
          {
            'id': notificationData['id'],
            'title': message.notification!.title!,
            'body': message.notification!.body!,
          }
        ])
      });
    } else {
      await db.collection(userId).doc('notifications').set({
        'notifications': [
          {
            'id': notificationData['id'],
            'title': message.notification!.title!,
            'body': message.notification!.body!,
          }
        ]
      });
    }
  });
}

getAllNotifications() async {
  await db.collection(userId).doc('notifications').get().then((value) async {
    if (value.exists) {
      notifications = value.data()!['notifications'];
    } else {
      await db.collection(userId).doc('notifications').set({
        'notifications': [
          {
            'id': '0000',
            'title': 'Welcome',
            'body':
                'ORUphones is India\'s first-ever online C2C marketplace dedicated to buying and selling Old, Refurbished & Used phones.',
          }
        ]
      });
      notifications = value.data()!['notifications'];
    }
  });
}
