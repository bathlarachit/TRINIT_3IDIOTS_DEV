// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables


import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Modal/Staticfile.dart';

import '../BottomNavbar/BottomNavBar.dart';
import '../EnteringPage/Splash.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool load = false,load2=false,load3=false,load4=false;
  String location="",mission="",upiId="",accName="",accNo="",ifsc="";
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    print(Staticfile.type);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title: SizedBox(
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                //margin: EdgeInsets.only(left: 50),
                height: MediaQuery.of(context).size.width * (0.1),
                width: MediaQuery.of(context).size.width * (0.1),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    image:
                        const DecorationImage(image: AssetImage("assets/images/logo.png"))),
              ),
              Text(
                "Profile",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * (0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                onPressed: () async {
                  try {
                    Staticfile.navIndex=0;
                    await auth.signOut();
                    Fluttertoast.showToast(msg: "Signed Out");
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error Signing Out:-$e");
                  }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Splash()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  "Logout",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * (0.04),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xFFd8f2fd),
      ),
      resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavbar().navbar(context),
        body:
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: ()=>{
                    if(Staticfile.photo!=""){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewImg(s.pic)))
                    }
                  },
                  child: 
                  Staticfile.photo=="null"?
                  Container(
                    height: MediaQuery.of(context).size.height * (0.25),
                    width: MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      border: Border.all(width: 3, color: const Color.fromARGB(255, 60, 60, 60)),
                      image:const DecorationImage(image: AssetImage("assets/images/dog2.jpg"))
                    ))
                  :
                  Container(
                    height: MediaQuery.of(context).size.height * (0.25),
                    width: MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                          border: Border.all(width: 3, color: const Color.fromARGB(255, 60, 60, 60))),
                    child: Image.network(
                      Staticfile.photo,
                      fit: BoxFit.contain,
                      loadingBuilder: (BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null ) {
                          return child;
                        }
                        return Container(color: Colors.teal.shade100);
                      },
                    ),
                    )
                ),
                SizedBox(height: 20,),
                Center(
                  child: Text("${Staticfile.name.toString()}",style:GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * (0.05),
                      fontWeight: FontWeight.w400,
                  )),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Text("Phone :- ${Staticfile.phn.toString()}",style:GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * (0.05),
                      fontWeight: FontWeight.w400,
                  )),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Text("Mail :- ${Staticfile.email.toString()}",style:GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * (0.05),
                      fontWeight: FontWeight.w400,
                  )),
                ),
                SizedBox(height: 20,),
                Staticfile.location!="null"?
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Text("Location :- ${Staticfile.location.toString()}",style:GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * (0.05),
                      fontWeight: FontWeight.w400,
                  )),
                ):
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                                width: MediaQuery.of(context).size.width*(1.2)/2-10,
                                child: TextField(
                                  onChanged: (value) {
                                    location = value;
                                  },
                                  style: TextStyle(fontSize: 17),
                                  decoration: InputDecoration(
                                    //isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 25, top: 10, bottom: 10, right: 20),
                                    labelText: 'Enter Location',
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 237, 237, 237),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.teal.shade300,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              load==false?SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width/3,
                                        // color: Colors.red,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(15)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color.fromARGB(255, 237, 237, 237)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ))),
                                          onPressed: () async {
                                            setState(() {
                                              load=true;
                                            });
                                            FirebaseDatabase db = FirebaseDatabase.instance;
                                            await db.ref("${Staticfile.type=="Ngo"?"Ngo/":"Users/"}"+Staticfile.uid+"/location").set(location);
                                            setState(() {
                                              Staticfile.location=location;
                                              load=false;
                                            });
                                          },
                                          child: Text(
                                            "Save",
                                            style: GoogleFonts.roboto(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )):CircularProgressIndicator()
                    ],),
                    
                ),
                SizedBox(height: 20),
                Staticfile.type=="Ngo"?SizedBox(
                  width: MediaQuery.of(context).size.width-10,
                  child: 
                  Center(
                    child: 
                    Text("Mission",
                      style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.width *(0.05),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
        
                  )
                ):SizedBox(),
                Staticfile.mission!="null" && Staticfile.type=="Ngo"?Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 60, 60, 60))),
                  child: 
                  Text(
                      Staticfile.mission,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                      fontSize: MediaQuery.of(context).size.width*(0.04),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ):
                  Staticfile.type=="Ngo"? Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*(0.9),
                      // height: 80,
                      child: TextField(
                        maxLines: 4,
                        expands: false,
                        onChanged: (value) {
                          mission = value;
                        },
                        style: TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter Mission',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 237, 237, 237),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ):SizedBox(),
                  SizedBox(height: 15,),
                  Staticfile.type=="Ngo" && Staticfile.type=="Ngo" && Staticfile.mission=="null" && load3==false?
                  Center(
                    child: SizedBox(
                      width:
                          MediaQuery.of(context).size.width/3,
                      // color: Colors.red,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(
                                    EdgeInsets.all(15)),
                            backgroundColor:
                                MaterialStateProperty.all(
                                    Color.fromARGB(255, 237, 237, 237)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5),
                            ))),
                        onPressed: () async {
                          setState(() {
                            load3=true;
                          });
                          FirebaseDatabase db = FirebaseDatabase.instance;
                          await db.ref("Ngo/"+Staticfile.uid+"/mission/").set(mission);
                          setState(() {
                            Staticfile.mission=mission;
                            load3=false;
                          });
                        },
                        child: Text(
                          "Save Mission",
                          style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  )

                :Staticfile.type=="Ngo" &&load3==true?Center(child: CircularProgressIndicator()):SizedBox(),

                SizedBox(height: 20),
                Center(
                  child: Text("Please update your preferred impact domain",style:GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * (0.045),
                      fontWeight: FontWeight.bold,
                  )),
                ),
        
        
          
                load2==false? SizedBox(
                  height: 300,
                  child: FilterListWidget<String>(
                    listData: Staticfile.impact,
                    selectedListData: Staticfile.selectedImpact,
                    onApplyButtonClick: (list)async {
                      setState(() {
                        load2=true;
                      });
                      FirebaseDatabase db = FirebaseDatabase.instance;
                      var x={};
                      Staticfile.selectedImpact.clear();
                      for(var i in list!){
                        Staticfile.selectedImpact.add(i);
                        x[i]=true;
                      }
                        await db.ref("${Staticfile.type=="Ngo"?"Ngo/":"Users/"}"+Staticfile.uid+"/${Staticfile.type=="Ngo"?"impact/":"interests/"}").set(x);
                      
                      setState(() {
                        load2=false;
                      });
                  
                    },
                    choiceChipLabel: (item) {
                      /// Used to print text on chip
                      return item;
                    },
                    validateSelectedItem: (list, val) {
                      ///  identify if item is selected or not
                      return list!.contains(val);
                    },
                    onItemSearch: (text, query) {
                      return text.toLowerCase().contains(query.toLowerCase());
                    },),
                ):Center(child: CircularProgressIndicator()),


                Staticfile.type=="Ngo" && Staticfile.upiId=="null"? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text("Bank Details",style:GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * (0.045),
                          fontWeight: FontWeight.bold,
                      )),
                    ),
                    Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*(0.9),
                      child: TextField(
                        onChanged: (value) {
                          upiId = value;
                        },
                        style: TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter UPI Id',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 237, 237, 237),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*(0.9),
                      child: TextField(
                        onChanged: (value) {
                          accName = value;
                        },
                        style: TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter Account Name',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 237, 237, 237),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*(0.9),
                      child: TextField(
                        onChanged: (value) {
                          accNo = value;
                        },
                        style: TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter Account No.',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 237, 237, 237),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*(0.9),
                      child: TextField(
                        onChanged: (value) {
                          ifsc = value;
                        },
                        style: TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter IFSC code',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 237, 237, 237),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  load4==false?Center(
                    child: SizedBox(
                      width:
                          MediaQuery.of(context).size.width/3,
                      // color: Colors.red,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(
                                    EdgeInsets.all(15)),
                            backgroundColor:
                                MaterialStateProperty.all(
                                    Color.fromARGB(255, 237, 237, 237)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5),
                            ))),
                        onPressed: () async {
                          setState(() {
                            load4=true;
                          });

                          if(!RegExp("[a-zA-Z0-9\\.\\-]{2,256}\\@[a-zA-Z][a-zA-Z]{2,64}").hasMatch(upiId)){
                            Fluttertoast.showToast(msg: "Please enter valid UPI Id!");
                            setState(() {
                             load4=false;
                            });
                            return;
                          }
                          if(!RegExp("[0-9]{9,18}").hasMatch(accNo)){
                            Fluttertoast.showToast(msg: "Please enter valid Account No. !");
                            setState(() {
                             load4=false;
                            });
                            return;
                          }
                          if(!RegExp("^[A-Za-z]{4}0[A-Z0-9a-z]{6}").hasMatch(ifsc)){
                            Fluttertoast.showToast(msg: "Please enter valid IFSC code !");
                            setState(() {
                             load4=false;
                            });
                            return;
                          }
                          if(accName.isEmpty){
                            Fluttertoast.showToast(msg: "Please enter valid Account Name. !");
                            setState(() {
                             load4=false;
                            });
                            return;
                          }
                          FirebaseDatabase db = FirebaseDatabase.instance;
                          await db.ref("Ngo/"+Staticfile.uid+"/accountProof/").set({"accountName":accName,"accountNo":accNo,"upiId":upiId,"ifsc":ifsc});
                          setState(() {
                            Staticfile.accName=accName;
                            Staticfile.upiId=upiId;
                            Staticfile.accNo=accNo;
                            Staticfile.ifsc=ifsc;
                            load4=false;
                          });
                        },
                        child: Text(
                          "Save Details",
                          style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  ):Center(child: CircularProgressIndicator(),)



                  ],
                ):Staticfile.type=="Ngo"?
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                  width: MediaQuery.of(context).size.width-10,
                  child: 
                  Center(
                    child: 
                    Text("Bank Details",
                      style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.width *(0.05),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
        
                  )
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 60, 60, 60))),
                  child: 
                  Text(
                      "Upi Id :- ${Staticfile.upiId} \nAccount No. :- ${Staticfile.accNo} \nAccount Name :- ${Staticfile.accName}\nIFSC Code :- ${Staticfile.ifsc}",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                      fontSize: MediaQuery.of(context).size.width*(0.04),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                )
                  ],
                )
                
                :SizedBox(),
                SizedBox(height: 20,),
                                
            ],
          ),
        )
      ));
  }
}