import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movies_models.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.item}) : super(key: key);

  final Result item;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Result _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _item.title,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${_item.posterPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                _item.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.star),
              Text('${_item.voteAverage}'),
            ],
          ),
          Row(
            children: [
              Text(
                '${_item.id}',
              ),
              const SizedBox(
                width: 15,
              ),
              const Text('||'),
              const SizedBox(
                width: 15,
              ),
              Text('${_item.originalLanguage}'),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '${_item.overview}',
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
