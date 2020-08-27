import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tmdb_app/Providers/MainController.dart';
import 'package:flutter_tmdb_app/Screens/MovieDetailScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';


final String API_KEY = "e59a3745b3e4534b3d9d3541be46ad9e";
final String imagePrefix = "https://image.tmdb.org/t/p/w500/";

class MainMovieScreen extends StatefulWidget {
  @override
  _MainMovieScreenState createState() => _MainMovieScreenState();
}

class _MainMovieScreenState extends State<MainMovieScreen> {
  List movie = List();

  MainController controller;


  String picture = "";
  String name = "";
  int pageCount = 1;

  String url;

  @override
  Widget build(BuildContext context)
  {

    controller = Provider.of<MainController>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  children:
                  List.generate(controller.getPoplarMovies().length, (index)
                  {
                    return (Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: FlatButton(
                        onPressed: (){
                          //print("Clicked on: ${controller.getPoplarMovies()[index]["title"]}!");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return(MovieDetailScreen(
                                movie: controller.getPoplarMovies()[index]
                              ));
                            }
                          ));
                        },
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Hero(
                                  tag: controller.getPoplarMovies()[index]["id"],
                                  child: Image.network(
                                    imagePrefix + controller.getPoplarMovies()[index]["poster_path"],
                                    scale: 0.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    controller.getPoplarMovies()[index]["title"],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                flex: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
                  }),
                ),
              ),
            ),
            FlatButton(
              child: Center(
                child: Text("Load More",style: TextStyle(fontSize: 25),),
              ),
              onPressed: ()
              {
                setState(()
              {
                pageCount = pageCount+1;
                controller.getPopularMoviesByPage(pageCount);
              });
              } ,
            )
          ],
        ),
      ),
    );
  }
}
