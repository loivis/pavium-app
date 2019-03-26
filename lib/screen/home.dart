import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prunusavium/screen/favorite.dart';
import 'package:prunusavium/screen/rank.dart';
import 'package:prunusavium/screen/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// https://stackoverflow.com/questions/52598900/flutter-bottomnavigationbar-rebuilds-page-on-change-of-tab
class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _index = 0;
  List<Widget> pages = List<Widget>();

  @override
  void initState() {
    pages..add(FavoritePage())..add(SearchPage())..add(RankPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBNB(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.portrait, size: 30.0),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      title: Text(_tabs[_index].title),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _index,
      children: pages,
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 100.0,
            child: DrawerHeader(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Center(
                child: FlutterLogo(
                  colors: Theme.of(context).primaryColor,
                  size: 75.0,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/settings');
              }),
          ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/about');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Widget _buildBNB() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTabBar(
        activeColor: Theme.of(context).primaryColor,
        currentIndex: _index,
        onTap: _onTap,
        items: _tabs.map((tab) {
          return BottomNavigationBarItem(
            title: Text(tab.title),
            icon: Icon(tab.icon),
          );
        }).toList(),
      );
    }
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: _onTap,
      items: _tabs.map((tab) {
        return BottomNavigationBarItem(
          title: Text(tab.title),
          icon: Icon(tab.icon),
        );
      }).toList(),
    );
  }

  void _onTap(int idx) {
    setState(() {
      this._index = idx;
    });
  }
}

class _Tab {
  final String title;
  final IconData icon;

  const _Tab({this.title, this.icon});
}

const List<_Tab> _tabs = const <_Tab>[
  _Tab(title: '收藏', icon: Icons.favorite_border),
  _Tab(title: '搜索', icon: Icons.search),
  _Tab(title: '排行', icon: Icons.library_books),
];
