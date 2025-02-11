import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/screens/exProfilePage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/suggest.dart';


class SourcePage extends StatefulWidget {
  @override
  _SourcePageState createState() => _SourcePageState();
}






class _SourcePageState extends State<SourcePage> {
  final urlImages = [
  'https://images.unsplash.com/photo-1561731216-c3a4d99437d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
  'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2Fyc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVwcGVyb25pJTIwcGl6emF8ZW58MHx8MHx8&w=1000&q=80',
  'https://images.unsplash.com/photo-1598875706250-21faaf804361?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8OXx8fGVufDB8fHx8&w=1000&q=80',
  'https://images.unsplash.com/photo-1614027164847-1b28cfe1df60?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80',
  ];
  final profileImage =
    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  ;
  final List _suggested = ['NFL', 'Computers', 'F1', 'Math', 'Boxing', 'Cooking'];
FocusNode focusNode = FocusNode();

@override
void dispose() {
  focusNode.dispose();

  super.dispose();
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),);
                  },
                  icon: Icon(CupertinoIcons.search,color: Colors.grey.shade700,size: 30,),
                ),

                actions: [
                  IconButton(
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProfilePage();
                      }));
                    },
                    icon: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ],


          body: Container(
            child: Column(
              children: [

                Container(
                  height: 35,
                  child: ListView.builder(
                      itemCount: _suggested.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: MySuggest(
                              label: _suggested[index]
                          ),
                        );
                      }),
                ),

                /*Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),

                 */

                Expanded(
                  child: ListView.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index) {
                      final urlImage = urlImages[index];

                      return buildImage(urlImage, index);
                    },
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
  Widget buildImage(String urlImage, int index) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Center(
        child: Image.network(
          urlImage,
          width: double.infinity,
          height: 470,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'NFL',
    'Computers',
    'F1',
    'Math',
    'Boxing',
    'Cooking',
    'Books',
    'News',
    'Soccer',
    'Buildings',
    'Basketball',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildleading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var topic in searchTerms) {
      if (topic.toLowerCase().contains(query.toLowerCase())) {}
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var topic in searchTerms) {
      if (topic.toLowerCase().contains(query.toLowerCase())) {}
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {

  }
}


  /*
    return Scaffold(
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),);
                  },
                  icon: Icon(CupertinoIcons.search,color: Colors.grey.shade700,size: 30,),
                ),

                actions: [
                  IconButton(
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProfilePage();
                      }));
                    },
                    icon: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ],


          body: Container(
            child: Column(
              children: [

                Container(
                  height: 35,
                  child: ListView.builder(
                      itemCount: _suggested.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: MySuggest(
                              label: _suggested[index]
                          ),
                        );
                      }),
                ),

                Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index) {
                      final urlImage = urlImages[index];

                      return buildImage(urlImage, index);
                    },
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
  Widget buildImage(String urlImage, int index) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Center(
        child: Image.network(
          urlImage,
          width: double.infinity,
          height: 470,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'NFL',
    'Computers',
    'F1',
    'Math',
    'Boxing',
    'Cooking',
    'Books',
    'News',
    'Soccer',
    'Buildings',
    'Basketball',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildleading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var topic in searchTerms) {
      if (topic.toLowerCase().contains(query.toLowerCase())) {}
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var topic in searchTerms) {
      if (topic.toLowerCase().contains(query.toLowerCase())) {}
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {

  }
}


   */
