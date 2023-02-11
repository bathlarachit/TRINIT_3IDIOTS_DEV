import 'package:flutter/material.dart';

import '../modal/ngo.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, required this.ngo});
  final NGO ngo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const Image(
              width: double.infinity,
              height: 260,
              image: AssetImage('assets/images/hamster.jpg'),
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
                    const Text(
                      'Animal welfare is the well-being of non-human animals. Formal standards of animal welfare vary between contexts, but are debated mostly by animal welfare groups, legislators, and academics. Animal welfare science uses measures such as longevity, disease, immunosuppression, behavior, physiology, and reproduction, although there is debate about which of these best indicate animal welfare.',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
