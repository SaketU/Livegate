import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/models/friendListModel.dart';


class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  List<Friend> Friends = [
    Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
    Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6'),
    Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg'),
    Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader.jpg'),
    Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc'),
    Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
    Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6'),
    Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg'),
    Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader.jpg'),
    Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc'),
    Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
    Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6'),
    Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg'),
    Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader.jpg'),
    Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc'),
    Friend(name: "John Murphy", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
    Friend(name: "Luis Jose", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6'),
    Friend(name: "Emma Hall", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg'),
    Friend(name: "Chris Johnson", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader.jpg'),
    Friend(name: "Alejandra Vasquez", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc'),
  ];

  List<Friend> selectedFriends = [];

  void _toggleSelection(Friend Friend) {
    setState(() {
      Friend.isSelected = !Friend.isSelected;
      if (Friend.isSelected) {
        selectedFriends.add(Friend);
      } else {
        selectedFriends.remove(Friend);
      }
    });
  }

  void _navigateToNewGroupPage() {
    if (selectedFriends.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewGroupPage(selectedFriends: selectedFriends),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              size: 30,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          title: Text("Add Members", style: GoogleFonts.interTight(fontSize: 18, fontWeight: FontWeight.bold),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: TextButton(
                onPressed: selectedFriends.isNotEmpty ? _navigateToNewGroupPage : null,
                child: Text(
                  "Next",
                  style: GoogleFonts.interTight(
                    fontSize: screenHeight*0.019,
                    fontWeight: FontWeight.w500,
                    color: selectedFriends.isNotEmpty ? Theme.of(context).colorScheme.tertiary : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(preferredSize: Size.fromHeight(50), 
          child: Padding(
                padding: EdgeInsets.only(left: 16, bottom: 10, right: 16),
                child: Container(
                  width: double.infinity,
                  height: screenHeight*0.047,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: GoogleFonts.interTight(color: Colors.grey.shade600),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10), // Adjust padding as needed
                        child: SizedBox(
                          width: 20,  // Adjust the width to fit well
                          height: 20,  // Adjust the height
                          child: SvgPicture.asset(
                            'assets/search-icon.svg',
                            colorFilter: ColorFilter.mode(
                              Colors.grey.shade600,  
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),//Icon(Icons.search,color: Colors.grey.shade600,size: 25,),
                      filled: true,
                      fillColor: Theme.of(context).brightness == Brightness.dark?
                      Color(0Xff242525) :Colors.black12,
                      contentPadding: EdgeInsets.only(top: 3, bottom: 3, left: 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          )
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
        body: ListView.builder(
              itemCount: Friends.length,
              itemBuilder: (context, index) {
                final friend = Friends[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight *0.004),
                  child: GestureDetector(
                    onTap: () => _toggleSelection(friend),
                    child: ListTile(
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
                          border: Border.all(color: friend.isSelected ? Colors.transparent : Colors.grey),
                          color: friend.isSelected 
                              ? (Theme.of(context).brightness == Brightness.dark ? Colors.blue : Colors.black) 
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
          );
        }
      }

class NewGroupPage extends StatelessWidget {
  final List<Friend> selectedFriends;

  NewGroupPage({required this.selectedFriends});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              size: 30,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        title: Text("New Group", style: GoogleFonts.interTight(fontSize: 18, fontWeight: FontWeight.bold),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: TextButton(
                onPressed: null,
                child: Text(
                  "Create",
                  style: GoogleFonts.interTight(
                    fontSize: screenHeight*0.019,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary
                  ),
                ),
              )
            ),
          ],
        ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16, top: screenHeight*0.013, bottom: screenHeight*0.013),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary, // Background color to match the dark theme
                prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 15, left: 15), // Adjust padding as needed
                        child: SizedBox(
                          width: 25,  // Adjust the width to fit well
                          height: 25,  // Adjust the height
                          child:
                            SvgPicture.asset(
                              'assets/camera.svg',
                              height: screenHeight*0.028,
                              width: screenWidth*0.034,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.tertiary,
                                BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                hintText: "Group name (optional)", // Placeholder text
                hintStyle: GoogleFonts.interTight(
                  fontSize: screenHeight * 0.018,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey
                : Colors.grey.shade600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded edges
                  borderSide: BorderSide.none, // Remove border
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16, top: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Members', style: GoogleFonts.interTight(fontSize: screenHeight*0.015, 
              color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey
              : Colors.grey.shade600),)),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: selectedFriends.length,
              itemBuilder: (context, index) {
                final Friend = selectedFriends[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight *0.004),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(Friend.profileImage),
                      maxRadius: screenHeight * 0.0275,
                    ),
                    title: Text(
                        Friend.name,
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 

/*
void showAddMemberBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Container(
      child: AddMemberPage(),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0Xff242525)
                : Theme.of(context).colorScheme.tertiaryContainer,
      ),
    ),
  );
}
*/