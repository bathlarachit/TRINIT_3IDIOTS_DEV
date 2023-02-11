import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.img, required this.name});
  final String img;
  final String name;
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
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    image: NetworkImage(img),
                    height: 150,
                    width: 240,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$name ',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
