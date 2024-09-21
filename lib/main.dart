import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff0b1111),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xff0b1111),
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(),

    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  String data = "";
  List newsdata = [];

  @override
  void initState() {
    super.initState();
    getData("all");
  }

  Future<void> getData(String category) async {
    http.Response response = await http.get(
      Uri.parse("https://inshortsapi.vercel.app/news?category=$category"),
    );
    setState(() {
      data = response.body;
      newsdata = jsonDecode(data)["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12, // Corrected the length to 12
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "PRIME NEWS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notification()));
                },
                icon: Icon(Icons.notifications_none_rounded),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                },
                icon: Icon(Icons.account_circle),
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Top News"),
              Tab(text: "National"),
              Tab(text: "Business"),
              Tab(text: "Sports"),
              Tab(text: "World"),
              Tab(text: "Politics"),
              Tab(text: "Technology"),
              Tab(text: "Startup"),
              Tab(text: "Entertainment"),
              Tab(text: "Miscellaneous"),
              Tab(text: "Hatke"),
              Tab(text: "Science"),
            ],
            onTap: (index) {
              var categories = [
                'all',
                'national',
                'business',
                'sports',
                'world',
                'politics',
                'technology',
                'startup',
                'entertainment',
                'miscellaneous',
                'hatke',
                'science'
              ];
              getData(categories[index]);
            },
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 230,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: newsdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                newsItem: newsdata[index],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          newsdata[index]["imageUrl"],
                                          height: 200,
                                          width: 400,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 12,
                                        left: 10,
                                        right: 10,
                                        child: Text(
                                          newsdata[index]["title"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16,
                                            color: Colors.white,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: newsdata.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                            newsItem: newsdata[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                newsdata[index]["title"],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Card(
                                  child: Image.network(
                                    newsdata[index]["imageUrl"],
                                    height: 150,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(newsdata[index]["author"]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(newsdata[index]["time"]),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(accountName: Text("Mehul Solanki"), accountEmail: Text("mehul787487687gmail.com"),
              currentAccountPicture: CircleAvatar(child: ClipOval(child: Image.network("https://t4.ftcdn.net/jpg/05/62/02/41/360_F_562024161_tGM4lFlnO0OczLYHFFuNNdMUTG9ekHxb.jpg",fit: BoxFit.fill,height: 100,width: 200,),),),),
             SingleChildScrollView(
               child: Column(
                 children: [
                   ListTile(
                     title: Text("Top News", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("National", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Business", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Sports", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("World", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Politics", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Technology", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Startup", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Entertainment", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Miscellaneous", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Hatke", style: TextStyle(fontSize: 14)),
                   ),
                   ListTile(
                     title: Text("Science", style: TextStyle(fontSize: 14)),
                   ),
                 ],
               ),
             ),
              Divider(),

            ],
          ),
        ),
      ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final Map newsItem;

  NewsDetailScreen({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News Detail"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  newsItem["imageUrl"],
                ),
                SizedBox(height: 10),
                Text(
                  newsItem["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: Text(newsItem["content"]),
                )
              ],
            ),
          ),
        ));
  }
}


class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Center(
        child: Text("Notifications"),
      ),
    );
  }
}
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                 child: ClipOval(child: Image.network("https://t4.ftcdn.net/jpg/05/62/02/41/360_F_562024161_tGM4lFlnO0OczLYHFFuNNdMUTG9ekHxb.jpg",fit: BoxFit.fill,height: 100,width: 200,),), // Replace with a valid image URL
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Mehul Solanki',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'mehul787487687gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 32),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Profile"),
                onTap: () {
                  // Handle edit profile action
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change Password"),
                onTap: () {
                  // Handle change password action
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log Out"),
                onTap: () {
                  // Handle logout action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}