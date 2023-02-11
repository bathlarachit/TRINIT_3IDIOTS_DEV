import 'package:flutter/material.dart';
import 'package:trinit/modal/ngo.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Image(
            image: AssetImage('assets/images/dog.jfif'),
            height: 100,
            width: 0,
          ),
          Column(
            children: [
              const Text('Category:Animal'),
              const Text(
                'Dog care health institute for Animal Welfare',
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
              Row(
                children: const [Icon(Icons.calendar_view_day)],
              )
            ],
          )
        ],
      ),
    );
  }
}

class CardList extends StatefulWidget {
  CardList({super.key, required this.ngo});
  NGO ngo;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  var ngo;
  @override
  void initState() {
    ngo = widget.ngo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const Image(
          image: AssetImage('assets/images/dog.jfif'),
          height: 140,
          width: 100,
        ),
        title: Text(
          '${ngo.name}',
          maxLines: 2,
          overflow: TextOverflow.clip,
        ),
        subtitle: const Text('Category: Animal Rescue'),
      ),
    );
  }
}
