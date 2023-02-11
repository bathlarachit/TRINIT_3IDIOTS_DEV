import 'package:flutter/material.dart';

import 'components/info.dart';
import 'components/list.dart';
import 'modal/ngo.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({
    Key? key,
    required this.ngo,
  }) : super(key: key);
  final List<NGO> ngo;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  var ngoList = [];

  @override
  void initState() {
    ngoList = widget.ngo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results...'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfoPage(
                            ngo: ngoList[index],
                          )));
            },
            child: CardList(
              ngo: ngoList[index],
            ),
          );
        },
        itemCount: ngoList.length,
      ),
    );
  }
}
