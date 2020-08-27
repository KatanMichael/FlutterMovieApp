import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tmdb_app/Providers/MainController.dart';
import 'package:flutter_tmdb_app/Screens/MainMoviesScreen.dart';
import 'package:flutter_tmdb_app/Screens/SecondScreen.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatefulWidget
{
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
  MainController controller;

  List screens = [MainMovieScreen(), SecondScreen()];
  List titles = ["Popular Movies", "Popular Shows"];
  int screenIndex = 0;
  @override
  Widget build(BuildContext context)
  {
    controller = Provider.of<MainController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(titles.elementAt(screenIndex)),
      ),
      body: screens.elementAt(screenIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text("Movies"),
              icon: Icon(Icons.movie),
            backgroundColor: Colors.lightBlue
          ),
          BottomNavigationBarItem(
              title: Text("Shows"),
              icon: Icon(Icons.tv),
              backgroundColor: Colors.redAccent
          ),
        ],
        currentIndex: screenIndex,
        onTap: (index)
        {
          setState(() {
            screenIndex = index;
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Header"),
            ),
            FlatButton(
              child: ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              onPressed: ()=>{
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)
                    {
                      return SecondScreen();
                    }
                ))
              },
              onLongPress: ()=>print("Long Messages"),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
