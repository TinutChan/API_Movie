// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movies_models.dart';
import 'package:flutter_application_1/pages/search_page.dart';
import 'package:flutter_application_1/respositry/repositry_items.dart';
import 'package:flutter_application_1/utils/zoho_salesiq.dart';
import 'package:flutter_application_1/widgets/detail_page.dart';
import 'package:flutter_application_1/widgets/custom_editpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<MoviesApi> _moviesDb;

  @override
  void initState() {
    super.initState();
    _moviesDb = getMovieAPI;
  }

  final List<String> items_Option = [
    'Preview',
    'Favourite',
    'Delete',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.black.withOpacity(0.9),
        centerTitle: true,
        elevation: 0,
        actions: [
          InkWell(
            child: const Icon(
              (Icons.favorite_border),
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                debugPrint("============onTab===========");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              child: const Icon(Icons.search),
            ),
          )
        ],
      ),
      body: FutureBuilder<MoviesApi>(
        future: _moviesDb,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint("Error ${snapshot.error}");

            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              debugPrint('Data ==> ${snapshot.data}');
              return Container(
                color: Colors.black87,
                child: _buildListView(snapshot.data!.results),
              );
            } else {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.red,
                  duration: Duration(seconds: 1),
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: zohoSalesIQchat(),
        onPressed: () {},
      ),
    );
  }

  _buildListView(List<Result> items) {
    return RefreshIndicator(
      onRefresh: () async {
        debugPrint('============onRefreshed=============');
        _moviesDb = getMovieAPI;
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildItem(items[index]);
        },
      ),
    );
  }

  _buildItem(Result item) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 0.1,
                color: Colors.grey,
                offset: Offset(0.3, 0.3),
                spreadRadius: 0.1,
              ),
            ],
          ),
          margin: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${item.posterPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        item.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${item.overview}',
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        "${item.releaseDate.year.toString().padLeft(4, '0')}-${item.releaseDate.month.toString().padLeft(2, '0')}-${item.releaseDate.day.toString().padLeft(2, '0')}",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          top: 10,
          child: PopupMenuButton(
            child: const Icon(Icons.more_horiz),
            itemBuilder: (context) {
              return items_Option
                  .map(
                    (e) => PopupMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList();
            },
            onSelected: (value) {
              if (value == 'Preview') {
                debugPrint('=======Previewed========');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(
                      item: item,
                    ),
                  ),
                );
              }
              if (value == 'Edit') {
                debugPrint('==========Edited=========');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditPage(),
                  ),
                );
              }
              if (value == 'Delete') {
                debugPrint('===========Deleted=========');
              }
            },
          ),
        ),
      ],
    );
  }
}
