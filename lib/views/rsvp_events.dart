// import 'package:appwrite/models.dart';
// import 'package:event_management_app/constants/colors.dart';
// import 'package:event_management_app/database.dart';
// import 'package:event_management_app/saved_data.dart';
// import 'package:event_management_app/views/event_details.dart';
// import 'package:flutter/material.dart';

// class RSVPEvents extends StatefulWidget {
//   const RSVPEvents({super.key});

//   @override
//   State<RSVPEvents> createState() => _RSVPEventsState();
// }

// class _RSVPEventsState extends State<RSVPEvents> {
//   List<Document> events = [];
//   List<Document> userEvents = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     refresh();
//     super.initState();
//   }

//   void refresh() {
//     String userId = SavedData.getUserId();
//     getAllEvents().then((value) {
//       events = value;
//       for (var event in events) {
//         List<dynamic> participants = event.data["participants"];

//         if (participants.contains(userId)) {
//           userEvents.add(event);
//         }
//         setState(() {
//           isLoading = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Joined Events")),
//       body: ListView.builder(
//         itemCount: userEvents.length,
//         itemBuilder: (context, index) => Card(
//           child: ListTile(
//             onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         EventDetails(data: userEvents[index]))),
//             title: Text(
//               userEvents[index].data["name"],
//               style: TextStyle(color: Colors.black),
//             ),
//             subtitle: Text(
//               userEvents[index].data["location"],
//               style: TextStyle(color: Colors.black),
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.check_circle,
//                   color: kLightGreen,
//                 ),
//                 SizedBox(width: 8), // Add some space between icons
//                 GestureDetector(
//                   onTap: () {
//                     // Add code to handle deletion here
//                   },
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:appwrite/models.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/database.dart';
import 'package:event_management_app/saved_data.dart';
import 'package:event_management_app/views/event_details.dart';
import 'package:flutter/material.dart';

class RSVPEvents extends StatefulWidget {
  const RSVPEvents({Key? key}) : super(key: key);

  @override
  State<RSVPEvents> createState() => _RSVPEventsState();
}

class _RSVPEventsState extends State<RSVPEvents> {
  List<Document> events = [];
  List<Document> userEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    String userId = SavedData.getUserId();
    getAllEvents().then((value) {
      events = value;
      for (var event in events) {
        List<dynamic> participants = event.data["participants"];

        if (participants.contains(userId)) {
          userEvents.add(event);
        }
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void deleteEvent(int index) {
    setState(() {
      userEvents.removeAt(index);
    });
  }

  void onTapEvent(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetails(data: userEvents[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Joined Events")),
      body: ListView.builder(
        itemCount: userEvents.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () => onTapEvent(context, index),
            title: Text(
              userEvents[index].data["name"],
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              userEvents[index].data["location"],
              style: TextStyle(color: Colors.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: kLightGreen,
                ),
                SizedBox(width: 8), // Add some space between icons
                GestureDetector(
                  onTap: () => deleteEvent(index),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

