import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/chatDetailPage.dart';
import 'package:fullapp/screens/profilePage.dart';
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
                          return ProfilePage();
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

/*
class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _controller = TextEditingController();
  bool _isTyping = false;
  bool saved = false;

  List<ChatMessage> messages = [

    ChatMessage(messageContent: "We'll see ", messageType: "receiver", time: '11:46 PM', selected: true),
    ChatMessage(messageContent: "Agree", messageType: "sender", time: '11:46 PM', selected: true),
    ChatMessage(messageContent: "and the offense couldn't move the ball", messageType: "receiver", time: '11:45 PM', selected: true),
    ChatMessage(messageContent: "The defense was struggling", messageType: "receiver", time: '11:45 PM', selected: true),
    ChatMessage(messageContent: "They need to make some adjustments", messageType: "receiver", time: '11:45 PM', selected: true),
    ChatMessage(messageContent: "Hopefully better", messageType: "sender", time: '11:44 PM', selected: true),
    ChatMessage(messageContent: "But we'll see how it goes on the next one", messageType: "sender", time: '11:44 PM', selected: true),
    ChatMessage(messageContent: "True", messageType: "receiver", time: '11:43 PM', selected: true),
    ChatMessage(messageContent: "At that point of the game you have nothing to loose", messageType: "sender", time: '11:43 PM', selected: true),
    ChatMessage(messageContent: "I feel like they should have gone for it on fourth down", messageType: "sender", time: '11:43 PM', selected: true),
    ChatMessage(messageContent: "yeah, they took it down to the wire", messageType: "receiver", time: '11:42 PM', selected: false),
    ChatMessage(messageContent: "Hey John, yeah it was really good", messageType: "sender", time: '11:42 PM', selected: true),
    ChatMessage(messageContent: "Did you catch the game last night?", messageType: "receiver", time: '11:41 PM', selected: false),
    ChatMessage(messageContent: "Hey Brad", messageType: "receiver", time: '11:41 PM', selected: true),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.back,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                  maxRadius: screenHeight*0.025,
                ),
              ),
              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatInfoPage();
                          }));
                        },
                        child:
                        Text("John Murphy",style: GoogleFonts.interTight(
                              fontSize: screenHeight*0.0185,
                              fontWeight: FontWeight.bold,),),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Container(
                      width: screenHeight*0.011,
                      height: screenHeight*0.011,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD80E),
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(right: screenHeight*0.011),
                    ),
                      ),

                  Spacer(),
                  
                  Padding(padding: EdgeInsets.only(right: 26),
                  child: GestureDetector(
                    child: 
                      SvgPicture.asset(
                        'assets/facetime.svg',
                        height: screenHeight*0.028,
                        width: screenWidth*0.035,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,  
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: 
                        SvgPicture.asset(
                          'assets/phone.svg',
                          height: screenHeight*0.028,
                          width: screenWidth*0.035,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.tertiary, 
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // Chat messages (Scrollable List)
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true, // Scroll from bottom to top
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero, // Ensure no extra padding
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                var message = messages[index];
                return buildMessage(message, index);
              },
            ),
          ),

          // Input Field Section
          Container(
  color: Theme.of(context).brightness == Brightness.dark
      ? Color(0Xff242525)
      : Colors.white,
  child: SafeArea(
    top: false,
    bottom: true,
    child: Container(
      height: screenHeight * 0.052,
      width: double.infinity,
      padding: EdgeInsets.only(top: 6, bottom: 6),
      color: Theme.of(context).brightness == Brightness.dark
          ? Color(0Xff242525)
          : Colors.white,
      child: Row(
        children: <Widget>[
          SizedBox(width: 15),

          // Profile Image
          SvgPicture.asset(
            'assets/camera.svg',
            height: screenHeight*0.028,
            width: screenWidth*0.034,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.tertiary,
              BlendMode.srcIn,
            ),
          ),

          SizedBox(width: 13),

          // Input Field
          Expanded(
            child: TextField(
              controller: _controller,
              cursorColor: Theme.of(context).colorScheme.tertiary,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 11, left: 12),
                suffixIconConstraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SvgPicture.asset(
                    'assets/stickers.svg',
                    width: screenWidth * 0.025,
                    height: screenHeight * 0.025,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),

          SizedBox(width: 13),

          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  if (_controller.text.trim().isNotEmpty) {
                    print("Message Sent: ${_controller.text}");
                    _controller.clear(); // Clear text field
                  }
                },
                child: Center(
                  child: Container(
                    height: screenHeight * 0.040,
                    width: screenHeight * 0.040,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Theme.of(context).colorScheme.tertiary,
                    ),
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).colorScheme.onPrimary,
                      size: screenHeight * 0.020,
                    ),
                  ),
                ),
              ),
            )
          else ...[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return ChatInfoPage();
                  }));
                },
                child: SvgPicture.asset(
                  'assets/photos.svg',
                  height: screenHeight*0.032,
                  width: screenWidth*0.032,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/mic.svg',
                  height: screenHeight*0.0284,
                  width: screenWidth*0.0187,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  ),
),

        ],
      ),
    );
  }

  // Message Bubble Widget
  Widget buildMessage(ChatMessage message, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return
      Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14,),
          child: Align(
            alignment: (messages[index].messageType == "receiver"
                ? Alignment.centerLeft
                : Alignment.centerRight),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: (messages[index].messageType == "receiver"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).brightness == Brightness.dark? //your texts
                    Colors.grey[800]: Theme.of(context).colorScheme.secondary),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: 17), //screenHeight*0.010, horizontal: screenWidth*0.05
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      messages[index].messageContent,
                      style: GoogleFonts.inter(
                        fontSize: screenHeight*0.018,
                        color: messages[index].messageType == "receiver"
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  /*
                  SizedBox(width: 8),
                  Text(
                    messages[index].time,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                  */
                ],
              ),
            ),
          ),
      );
  }
}
*/