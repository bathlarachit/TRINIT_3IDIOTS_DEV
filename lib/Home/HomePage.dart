import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GNav(
          onTabChange: (index) {},
          activeColor: Colors.blue,
          gap: 20,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.bookmark,
              text: 'Home',
            ),
            GButton(
              icon: Icons.feed,
              text: 'Feed',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Image(
                    height: 70,
                    width: 70,
                    image: AssetImage('assets/images/man.png'),
                  ),
                  Column(
                    children: const [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Sunday, 12 Febraury'),
                      ),
                    ],
                  )
                ],
              ),
              // const Card(
              //   elevation: 0,
              //   child: ListTile(
              //     leading: Image(
              //       image: AssetImage('assets/images/man.png'),
              //     ),
              //     title: Text(
              //       'Welcome Back!',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     subtitle: Text('Sunday, 12 Febraury'),
              //   ),
              // ),

              Row(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        constraints: BoxConstraints(maxWidth: 280),
                        focusedBorder: OutlineInputBorder(),
                        hintText: "Search for NGO's....",
                        border: InputBorder.none),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    height: 60,
                    width: 60,
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
