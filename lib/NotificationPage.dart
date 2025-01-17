import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationPage(),
    );
  }
}
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications = [
    NotificationItem(id: '1', title: 'New Message', message: 'You have a new message from Alex!'),
    NotificationItem(id: '2', title: 'System Update', message: 'Your system is ready for update.'),
    NotificationItem(id: '3', title: 'Reminder', message: 'Meeting at 2:00 PM today.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page (Volunteer Home)
          },
        ),
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
            },
          ),
        ],
      ),
      body: AnimatedList(
        initialItemCount: notifications.length,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: animation,
            child: Dismissible(
              key: Key(notifications[index].id),
              onDismissed: (direction) {
                setState(() {
                  notifications.removeAt(index);
                });
              },
              child: NotificationCard(notification: notifications[index]),
            ),
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      child: ListTile(
        leading: Icon(
          Icons.notification_important,
          color: Colors.blue,
        ),
        title: Text(
          notification.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(notification.message),
        trailing: IconButton(
          icon: Icon(Icons.check_circle_outline),
          onPressed: () {
            // Mark as read action
          },
        ),
      ),
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;

  NotificationItem({required this.id, required this.title, required this.message});
}
