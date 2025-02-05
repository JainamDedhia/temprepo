// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: NotificationPage(),
//     );
//   }
// }
// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   List<NotificationItem> notifications = [
//     NotificationItem(id: '1', title: 'New Message', message: 'You have a new message from Alex!'),
//     NotificationItem(id: '2', title: 'System Update', message: 'Your system is ready for update.'),
//     NotificationItem(id: '3', title: 'Reminder', message: 'Meeting at 2:00 PM today.'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Go back to the previous page (Volunteer Home)
//           },
//         ),
//         title: Text('Notifications'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.clear_all),
//             onPressed: () {
//               setState(() {
//                 notifications.clear();
//               });
//             },
//           ),
//         ],
//       ),
//       body: AnimatedList(
//         initialItemCount: notifications.length,
//         itemBuilder: (context, index, animation) {
//           return FadeTransition(
//             opacity: animation,
//             child: Dismissible(
//               key: Key(notifications[index].id),
//               onDismissed: (direction) {
//                 setState(() {
//                   notifications.removeAt(index);
//                 });
//               },
//               child: NotificationCard(notification: notifications[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class NotificationCard extends StatelessWidget {
//   final NotificationItem notification;

//   NotificationCard({required this.notification});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 8,
//       child: ListTile(
//         leading: Icon(
//           Icons.notification_important,
//           color: Colors.blue,
//         ),
//         title: Text(
//           notification.title,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(notification.message),
//         trailing: IconButton(
//           icon: Icon(Icons.check_circle_outline),
//           onPressed: () {
//             // Mark as read action
//           },
//         ),
//       ),
//     );
//   }
// }

// class NotificationItem {
//   final String id;
//   final String title;
//   final String message;

//   NotificationItem({required this.id, required this.title, required this.message});
// }



import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
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
    NotificationItem(
        id: '1',
        title: 'New Message',
        message: 'You have a new message from Alex!',
        isRead: false),
    NotificationItem(
        id: '2',
        title: 'System Update',
        message: 'Your system is ready for update.',
        isRead: false),
    NotificationItem(
        id: '3',
        title: 'Reminder',
        message: 'Meeting at 2:00 PM today.',
        isRead: false),
  ];

  void _clearAllNotifications() {
    if (notifications.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear All Notifications'),
        content: Text('Are you sure you want to delete all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.pop(context);
            },
            child: Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: _clearAllNotifications,
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_off,
                      size: 80, color: Colors.grey.shade400),
                  SizedBox(height: 20),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${notification.title} dismissed'),
                      ),
                    );
                  },
                  child: NotificationCard(
                    notification: notification,
                    onMarkAsRead: () {
                      setState(() {
                        notification.isRead = !notification.isRead;
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onMarkAsRead;

  NotificationCard({required this.notification, required this.onMarkAsRead});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: notification.isRead ? Colors.grey : Colors.blue,
          size: 32,
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: notification.isRead
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          notification.message,
          style: TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: Icon(
            notification.isRead ? Icons.check_circle : Icons.radio_button_unchecked,
            color: notification.isRead ? Colors.green : Colors.grey,
          ),
          onPressed: onMarkAsRead,
        ),
      ),
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    this.isRead = false,
  });
}

