import 'package:attandance_system/models/dummy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Admin_Screen extends StatefulWidget {
  @override
  State<Admin_Screen> createState() => _Admin_ScreenState();
}

class _Admin_ScreenState extends State<Admin_Screen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('admin').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Text(
            'DashBoard'.toUpperCase(),
            style: TextStyle(color: Colors.black, letterSpacing: 2),
          ),
          centerTitle: true,
          leadingWidth: 90,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/intro'));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/employe.png'),
                      ),
                      title: Text(
                          document['firstname'] + " " + document['lastname']),
                      subtitle: Text(document['email']),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class employ extends StatelessWidget {
  const employ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView.builder(
        itemCount: employdata.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/a');
          },
          child: Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              height: size.height * 0.2 - 30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          employdata[index].name,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '9.00 AM - 10.00 PM',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        employdata[index].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
