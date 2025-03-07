import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/chatDetailPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fullapp/models/friendListModel.dart';

List<Friend> friends = [
  Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
  Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
  Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3763188.jpg&fm=jpg'),
  Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs='),
  Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZSUyMHBob3RvfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
  Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
  Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
  Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3763188.jpg&fm=jpg'),
  Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs='),
  Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZSUyMHBob3RvfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
  Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
  Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
  Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3763188.jpg&fm=jpg'),
  Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs='),
  Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZSUyMHBob3RvfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
  Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
  Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
  Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3763188.jpg&fm=jpg'),
  Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs='),
  Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZSUyMHBob3RvfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),

];


class ShareSearchPage extends StatefulWidget {
  @override
  _ShareSearchPageState createState() => _ShareSearchPageState();
}

class _ShareSearchPageState extends State<ShareSearchPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _searchBarWidth;
  late Animation<double> _cancelButtonOpacity;
  late Animation<Offset> _cancelButtonSlide;

  List<Friend> selectedFriends = [];
  List<Friend> filteredFriends = List.from(friends);

  void _toggleSelection(Friend friend) {
    setState(() {
      friend.isSelected = !friend.isSelected;
      if (friend.isSelected) {
        selectedFriends.add(friend);
      } else {
        selectedFriends.remove(friend);
      }
    });
  }

  void _filterFriends(String query) {
    setState(() {
      filteredFriends = friends
          .where((friend) => friend.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _searchBarWidth = Tween<double>(begin: 1.08, end: 0.99)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _cancelButtonOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _cancelButtonSlide = Tween<Offset>(begin: Offset(0.4, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: "searchBar",
                      child: Material(
                        color: Colors.transparent,
                        child: AnimatedBuilder(
                          animation: _searchBarWidth,
                          builder: (context, child) {
                            return FractionallySizedBox(
                              widthFactor: _searchBarWidth.value,
                              child: Container(
                                height: screenHeight * 0.045,
                                child: TextField(
                                  autofocus: true,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    hintStyle: GoogleFonts.interTight(color: Colors.grey.shade600),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: SvgPicture.asset(
                                          'assets/search-icon.svg',
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey.shade600,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context).brightness == Brightness.dark
                                        ? Color(0Xff242525)
                                        : Colors.black12,
                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Reduced spacing on the right of "Cancel"
                  Padding(
                    padding: EdgeInsets.only(right: 4.0, left: screenHeight * 0.013), // 👈 This reduces space
                    child: SlideTransition(
                      position: _cancelButtonSlide,
                      child: FadeTransition(
                        opacity: _cancelButtonOpacity,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              fontSize: screenHeight * 0.019,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.019),

            Expanded(
              child: ListView.builder(
                itemCount: filteredFriends.length,
                itemBuilder: (context, index) {
                  final friend = filteredFriends[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.004, horizontal: 16),
                    child: GestureDetector(
                      onTap: () => _toggleSelection(friend),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(friend.profileImage),
                          maxRadius: screenHeight * 0.0275,
                        ),
                        title: Text(
                          friend.name,
                          style: GoogleFonts.interTight(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Container(
                          width: screenHeight * 0.03,
                          height: screenHeight * 0.03,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: friend.isSelected ? Colors.transparent : Colors.grey,
                            ),
                            color: friend.isSelected
                                ? (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.blue
                                    : Colors.black)
                                : Colors.transparent,
                          ),
                          child: friend.isSelected
                              ? Icon(Icons.check, color: Colors.white, size: screenHeight * 0.018)
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Conditionally display the Send button if there are selected friends
            Visibility(
              visible: selectedFriends.isNotEmpty,
              child: SafeArea(
                top: false,
                bottom: true,
                child: Padding(
                  padding: EdgeInsets.all(screenHeight * 0.016),
                  child: SizedBox(
                    height: screenHeight * 0.0533,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChatDetailPage();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.blue
                            : Theme.of(context).colorScheme.tertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Send',
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

