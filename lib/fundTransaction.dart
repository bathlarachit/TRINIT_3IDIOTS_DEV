import 'package:flutter/material.dart';

class FundTable extends StatefulWidget {
  FundTable({super.key, required this.fnds});
  String fnds;
  @override
  State<FundTable> createState() => _FundTableState();
}

class _FundTableState extends State<FundTable> {
  late String fnd;
  var ar = [];
  @override
  void initState() {
    fnd = widget.fnds;
    ar = fnd.split(',');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: ar.length,
          itemBuilder: ((context, index) {
            return Card(
              child: ListTile(
                leading: Text(ar[index]),
              ),
            );
          }),
        ));
  }
}
