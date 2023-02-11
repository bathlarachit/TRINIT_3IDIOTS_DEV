import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  const BigCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          height: 250,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Column(
              children: const [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    image: AssetImage('assets/images/dog2.jpg'),
                    height: 150,
                    width: 240,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Feel the thrill on the only surf simulator in Maldives ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
