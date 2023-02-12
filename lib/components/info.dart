// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Ngo/ngo_fetch.dart';
import 'package:trinit/modal/Staticfile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../VC.dart';
import '../fundTransaction.dart';
import '../modal/ngo.dart';

Future get(NGO ngo) async {
  String url =
      "upi://pay?pa=${ngo.UpiId}&pn=${ngo.name}&am=1000&tn=TestPayment&cu=INR";
  var result = await launch(url);
  debugPrint(result.toString());
  if (result == true) {
    print("Done");
  } else if (result == false) {
    print("Fail");
  }
}

class InfoPage extends StatelessWidget {
  InfoPage({super.key, required this.ngo});
  NGO ngo;

  @override
  Widget build(BuildContext context) {
    String type = Staticfile.type;
    String id = Staticfile.uid;
    String name = Staticfile.name;
    String ngoId = "id1";
    String callId = id + ngoId;

    print(Staticfile.type);
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
                              builder: (context) => const CallPage(
                                  callID: "callId",
                                  userName: "shreeram",
                                  userid: "id2")));
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
                    Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 60, 60, 60))),
                        child: Text(
                          "Location :- ${ngo.loc}\nEmail :- ${ngo.mail}\nUpi Id :- ${ngo.UpiId} \nAccount No. :- ${ngo.acc_num} \nAccount Name :- ${ngo.acc_name}\nIFSC Code :- ${ngo.ifsc}",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                            fontSize:
                                MediaQuery.of(context).size.width * (0.04),
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    const Text(
                      'Social Impact',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text('Loading'));
                        }

                        // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
                        if (snapshot.hasError) {
                          return const Center(child: Text('Error'));
                        }

                        // IF IT WORKS IT GOES HERE!
                        return Column(
                          children: [
                            Text(
                                'Total Fund Raised:${snapshot.data!.FundRaised}'),
                            TextButton(
                                onPressed: () {
                                  // print(snapshot.data!.trans);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FundTable(
                                              fnds: snapshot.data!.trans
                                                  .toString())));
                                },
                                child: const Text('View Transactions'))
                          ],
                        );
                      },
                      future: getFunds(ngo.key),
                    ),
                    // ListView.builder(itemBuilder: (context, index) {
                    //   return null;
                    // }),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(84, 116, 253, 1),
                          borderRadius: BorderRadius.circular(16)),
                      child: InkWell(
                        onTap: () async {
                          await get(ngo);
                        },
                        child: Center(
                          child: Text(
                            'Donate',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
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
