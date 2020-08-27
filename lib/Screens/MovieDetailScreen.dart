import 'package:flutter/material.dart';
import 'package:flutter_tmdb_app/Providers/MainController.dart';
import 'package:provider/provider.dart';


class MovieDetailScreen extends StatefulWidget
{

  Map movie;
  List genresNames = List();


  MovieDetailScreen({this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final String imagePrefix = "https://image.tmdb.org/t/p/w500/";

  List genresNames = List();

  MainController controller;

  @override
  Widget build(BuildContext context)
  {
    controller = Provider.of<MainController>(context);

    getGenres();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.redAccent,
            expandedHeight: 250,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.movie["title"]),
              background: Image.network(imagePrefix+widget.movie["backdrop_path"],
              fit: BoxFit.cover,),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Hero(
                    tag: widget.movie["id"],
                    child: Image.network(imagePrefix+widget.movie["poster_path"],
                    width: 250,
                    height: 250,),
                  ),
                  Text(genresNames[0]),

                ],

              ),
            ),
          )
        ],
      )
    );
  }



  void getGenres()
  {
    List genres = widget.movie["genre_ids"];
    List tempList = List();
    genres.forEach((genre)
    {
      controller.getGenres().forEach((element)
      {
        if(element["id"] == genre)
          {
            tempList.add(element["name"]);
          }
      });


    });
    setState(() {
      genresNames = tempList;
    });
  }
}
