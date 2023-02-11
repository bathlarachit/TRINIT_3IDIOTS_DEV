import 'package:flutter/material.dart';
import 'package:trinit/modal/Staticfile.dart';

import '../VC.dart';
import '../modal/ngo.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, required this.ngo});
  final NGO ngo;

  @override
  Widget build(BuildContext context) {
    String type = Staticfile.type;
    String id = Staticfile.uid;
    String name = Staticfile.name;
    String ngoId = ngo.key;
    String callId = id + ngoId;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image(
              width: double.infinity,
              height: 260,
              image: NetworkImage(ngo.photo_link),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 300),
              child: IconButton(
                  onPressed: () {
                    type = 'User';

                    if (type == 'User') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CallPage(
                                  callID: callId, userName: name, userid: id)));
                    } else {
                      print('NGo to NGo vc not allowed');
                    }
                  },
                  icon: const Icon(Icons.video_call_outlined)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 240.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 30, right: 30),
                  child: Column(children: [
                    Text(
                      ngo.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      '${ngo.mission}',
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Social Impact',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    // ListView.builder(itemBuilder: (context, index) {
                    //   return null;
                    // }),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(84, 116, 253, 1),
                          borderRadius: BorderRadius.circular(16)),
                      child: const Center(
                        child: Text(
                          'Donate',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
