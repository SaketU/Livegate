import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/chatDetailPage.dart';
import 'package:fullapp/screens/searchPage.dart';
import 'package:fullapp/screens/shareSearchPage.dart';
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
];

class FriendsBottomSheet extends StatefulWidget {
  @override
  _FriendsBottomSheetState createState() => _FriendsBottomSheetState();
  
}



class _FriendsBottomSheetState extends State<FriendsBottomSheet> {
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
void dispose() {
  for (var friend in friends) {
    friend.isSelected = false;
  }
  selectedFriends.clear();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(16),
      height: screenHeight * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF121212)
                : Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 45,
                height: screenHeight * 0.00474,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                  ?Colors.grey: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ShareSearchPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                    child: Hero(
                  tag: "searchBar",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.047,
                      child: IgnorePointer( // Prevents interaction in original screen
                        child: TextField(
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
                            contentPadding: EdgeInsets.only(top: 3, bottom: 3, left: 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                  ),
                ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFriends.length,
                itemBuilder: (context, index) {
                  final friend = filteredFriends[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.004),
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
                                color: friend.isSelected ? Colors.transparent : Colors.grey),
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
            SizedBox(height: screenHeight*0.019),
            selectedFriends.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildIconColumn("assets/upload.svg", "Share to...", screenWidth, screenHeight, context),
                      SizedBox(width: 32),
                      _buildIconColumn("assets/link.svg", "Copy Link", screenWidth, screenHeight, context),
                      SizedBox(width: 32),
                      _buildIconColumn("assets/download.svg", "Download", screenWidth, screenHeight, context),
                    ],
                  )
                : SizedBox(
                  height: screenHeight * 0.0533,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ChatDetailPage(
                    name: selectedFriends.first.name,
                    profileImage: selectedFriends.first.profileImage,
                  );
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
                        fontSize: screenHeight*0.018,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconColumn(String asset, String label, double screenWidth, double screenHeight, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: screenWidth * 0.15,
          height: screenWidth * 0.15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200],
          ),
          child: Center(
            child: SvgPicture.asset(
              asset,
              width: screenWidth * 0.06,
              height: screenWidth * 0.06,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.tertiary, BlendMode.srcIn),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          label,
          style: GoogleFonts.interTight(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}