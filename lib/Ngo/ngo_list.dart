import 'package:flutter/material.dart';
import 'package:trinit/Ngo/ngo_fetch.dart';
import 'package:trinit/components/info.dart';
import 'package:trinit/components/list.dart';

class NgoList extends StatefulWidget {
  const NgoList({super.key});

  @override
  State<NgoList> createState() => _NgoListState();
}

class _NgoListState extends State<NgoList> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NGO list'), centerTitle: true),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading'));
          }

          // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }

          // IF IT WORKS IT GOES HERE!
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoPage(
                                ngo: snapshot.data![index],
                              )));
                },
                child: CardList(
                  ngo: snapshot.data![index],
                ),
              );
            },
          );
        },
        future: getNgoList(),
      ),
    );
  }
}
