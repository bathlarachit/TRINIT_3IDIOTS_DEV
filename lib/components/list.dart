import 'package:flutter/material.dart';

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

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 0,
      child: ListTile(
        leading: Image(
          image: AssetImage('assets/images/dog.jfif'),
          height: 140,
          width: 100,
        ),
        title: Text(
          'Dog care health institute for Animal Welfare',
          maxLines: 2,
          overflow: TextOverflow.clip,
        ),
        subtitle: Text('Category: Animal Rescue'),
      ),
    );
  }
}
