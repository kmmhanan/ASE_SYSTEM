import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UsersTripsHistoryPage extends StatefulWidget {
  const UsersTripsHistoryPage({super.key});

  @override
  State<UsersTripsHistoryPage> createState() => _UsersTripsHistoryPageState();
}

class _UsersTripsHistoryPageState extends State<UsersTripsHistoryPage> {
  final completeTripRequestsOfCurrentUser = FirebaseDatabase.instance.ref().child("tripRequests");
  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'My Trips History',
      appBarOnPressed: () {
        Navigator.pop(context);
      },
      widget: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height - 56,
            padding: EdgeInsets.only(left: 16, top: MediaQuery.of(context).padding.top, right: 16, bottom: MediaQuery.of(context).padding.bottom + 48),
            child: StreamBuilder(
              stream: completeTripRequestsOfCurrentUser.onValue,
              builder: (BuildContext context, snapshotData) {
                if (snapshotData.hasError) {
                  return Center(
                    child: Text(
                      "Error Occured",
                      style: Theme.of(context).textTheme.bold18.copyWith(
                            color: Palette.white,
                          ),
                    ),
                  );
                }
                if (!(snapshotData.hasData)) {
                  return Center(
                    child: Text(
                      "No Record Found",
                      style: Theme.of(context).textTheme.bold18.copyWith(
                            color: Palette.white,
                          ),
                    ),
                  );
                }
                Map dataTrips = snapshotData.data!.snapshot.value as Map;
                List tripsList = [];
                dataTrips.forEach((key, value) => tripsList.add({
                      "key": key,
                      ...value
                    })); // one by one pick each key nd each record details nd added to the list
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: tripsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (tripsList[index]["status"] != null && tripsList[index]["status"] == "ended" && tripsList[index]["userID"] == FirebaseAuth.instance.currentUser!.uid) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: ShapeDecoration(
                            color: Palette.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            children: [
                              // pickup - fare amount
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/logo/icons/destination-green.png",
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                    child: Text(
                                      tripsList[index]["pickUpAddress"].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "LKR ${tripsList[index]["fareAmount"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              // drop off
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/logo/icons/destination-red.png",
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                    child: Text(
                                      tripsList[index]["dropOffAddress"].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    } else {
                      return Container();
                    }
                  },
                );
              },
            )),
      ),
    );
  }
}
