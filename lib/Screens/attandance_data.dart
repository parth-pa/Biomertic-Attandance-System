import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Admin_Screen extends StatefulWidget {
  @override
  State<Admin_Screen> createState() => _Admin_ScreenState();
}

class _Admin_ScreenState extends State<Admin_Screen> {
  String _date = DateFormat('dd MMMM yyyy').format(DateTime.now());
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('checkin')
      .orderBy('firstname')
      .snapshots();
  final Stream<QuerySnapshot> _usersStream1 = FirebaseFirestore.instance
      .collection('checkout')
      .orderBy('firstname')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildappbar(context),
        body: TabBarView(
          children: [
            checkin(),
            checkout(),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> checkin() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Smoething went Wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                DateFormat('dd MMMM yyyy').format(document['time'].toDate()) ==
                        _date
                    ? Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(2, 2),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade100),
                                  child: const Icon(Icons.person),
                                ),
                              ),
                            ),
                            title: Text(
                              document['firstname'] +
                                  " " +
                                  document['lastname'],
                              style: const TextStyle(
                                  letterSpacing: .2,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: Colors.blue),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                document['departmrent'] + '  Department',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                            ),
                            trailing: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Check In',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(document['check-in'],
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> checkout() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream1,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Smoething went Wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('NO DATA FOUND'),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                DateFormat('dd MMMM yyyy').format(document['time'].toDate()) ==
                        _date
                    ? Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(2, 2),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade100),
                                  child: const Icon(Icons.person),
                                ),
                              ),
                            ),
                            title: Text(
                              document['firstname'] +
                                  " " +
                                  document['lastname'],
                              style: const TextStyle(
                                  letterSpacing: .2,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: Colors.blue),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                document['departmrent'] + '  Department',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                            ),
                            trailing: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Check Out',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(document['check-out'],
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  AppBar buildappbar(BuildContext context) {
    return AppBar(
      title: Text(
        'DashBoard'.toUpperCase(),
        style: const TextStyle(
            color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.w800),
      ),
      bottom: const TabBar(
        labelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.w900),
        automaticIndicatorColorAdjustment: true,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        physics: BouncingScrollPhysics(),
        tabs: [
          Tab(
            text: 'CHECK-IN ',
          ),
          Tab(
            text: 'CHECK-OUT',
          ),
        ],
      ),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/intro'));
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            onPressed: () async {
// Call when you want to show the date picker
              final DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime(2022, 4),
                firstDate: DateTime(2017, 1),
                lastDate: DateTime(2040),
                helpText: 'Select a date',
              );
              if (newDate != null) {
                setState(() {
                  _date = DateFormat('dd MMMM yyyy').format(newDate);
                });
              }
            },
            icon: const Icon(
              Icons.date_range,
              color: Colors.white,
            )),
      ],
    );
  }
}
