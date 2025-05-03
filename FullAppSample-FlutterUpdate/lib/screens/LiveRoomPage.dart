import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';
import 'package:focused_menu/modals.dart';
import 'package:fullapp/models/roomChatModel.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:fullapp/screens/chatDocumentsPage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/screens/usersProfilePage.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/widgets/friendsBottomSheet.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fullapp/services/socket_manager.dart'; // Import your SocketManager
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fullapp/config.dart';
import 'package:uuid/uuid.dart';

class LiveRoomPage extends StatefulWidget {
  final String team1;
  final String team2;
  final String gameId;

  LiveRoomPage({
    required this.team1,
    required this.team2,
    required this.gameId,
  });

  @override
  _LiveRoomPageState createState() => _LiveRoomPageState();
}

class _LiveRoomPageState extends State<LiveRoomPage> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  bool _showScrollButton = false;
  String currentUser = '@Unknown';
  List<RoomMessage> messages = [];
  RoomMessage? replyingTo;

  void showEmojiBottomSheet({
    required RoomMessage message,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return Container(
          height: 710,
          child: Column(
            children: [
              // Emoji Picker with custom layout
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color(0Xff242525)
                        : Colors.white,
                    child: EmojiPicker(
                      onEmojiSelected: (category, emoji) {
                        Navigator.pop(context);
                        addReactionToMessage(
                          message: message,
                          reaction: emoji.emoji,
                        );
                      },
                      config: Config(
                        emojiViewConfig: EmojiViewConfig(
                          columns: 6,
                          emojiSizeMax: 28,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xFF121212)
                            : Colors.white,
                          recentsLimit: 28,
                        ),
                        categoryViewConfig: CategoryViewConfig(
                          tabBarHeight: 54,
                          indicatorColor: Theme.of(context).colorScheme.tertiary,
                          iconColor: Colors.grey,
                          iconColorSelected: Theme.of(context).colorScheme.tertiary,
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? Color(0Xff242525)
                              : Colors.white,
                        ),
                        bottomActionBarConfig: BottomActionBarConfig(
                          showBackspaceButton: false,
                          showSearchViewButton: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmojiButton(String emoji, RoomMessage message) {
    return InkWell(
      onTap: () {
        addReactionToMessage(
          message: message,
          reaction: emoji,
        );
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  // add reaction to message
  void addReactionToMessage({
  required RoomMessage message,
  required String reaction,
}) {
  if (message.reactions.containsKey(reaction)) {
    message.reactions[reaction] = message.reactions[reaction]! + 1;
  } else {
    message.reactions[reaction] = 1;
  }
  setState(() {});
}
  

  Future<void> _loadCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUser = prefs.getString('username') ?? '@Unknown';
    });
  }

  Future<void> loadChatMessages() async {
    final url = Uri.parse('$kBackendBaseUrl/nba-chat/${widget.gameId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> chatArray = data['chat'];
      print(chatArray); // Debug print to inspect message fields
      setState(() {
        messages = chatArray.map((chatEntry) {
          final String sender = chatEntry['sender'] != null && chatEntry['sender'].toString().isNotEmpty
              ? chatEntry['sender']
              : 'Unknown';
          return RoomMessage(
            id: chatEntry['_id'] ?? chatEntry['id'] ?? const Uuid().v4(),
            name: '@$sender',
            profileImage:
                'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
            messageContent: chatEntry['message'] ?? '',
            messageType: sender == currentUser ? 'sender' : 'receiver',
            selected: true,
          );
        }).toList().reversed.toList();
      });
    } else {
      print('Error fetching chat messages: ${response.body}');
    }
  }

  void subscribeToSocketEvents() {
    SocketManager().socket.on('new message', (data) {
      print('New message received: $data');
      setState(() {
        messages.insert(
          0,
          RoomMessage(
            id: data['_id'] ?? data['id'] ?? const Uuid().v4(),
            name: data['sender'] != null && data['sender'].toString().isNotEmpty
                ? '@${data['sender']}'
                : '@Unknown',
            profileImage:
                'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
            messageContent: data['message'] ?? '',
            messageType: data['sender'] == currentUser ? 'sender' : 'receiver',
            selected: true,
          ),
        );
      });
    });
  }

  void _joinGameRoom() {
    if (SocketManager().socket.connected) {
      SocketManager().joinGame(widget.gameId);
    } else {
      // When the socket connects, join the game room.
      SocketManager().socket.on('connect', (_) {
        SocketManager().joinGame(widget.gameId);
        subscribeToSocketEvents();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();

    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.isNotEmpty;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        setState(() {
          _showScrollButton = true;
        });
      } else {
        setState(() {
          _showScrollButton = false;
        });
      }
    });

    loadChatMessages();
    subscribeToSocketEvents();
    _joinGameRoom();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    // Leave the game room when exiting the LiveRoomPage.
    SocketManager().leaveGame(widget.gameId);
    SocketManager().socket.off('new message');
    super.dispose();
  }

  void emitMessage(String gameId, String messageText, String sender) {
    SocketManager().socket.emit('send message', {
      "gameId": gameId,
      "message": messageText,
      "sender": sender,
    });
  }

  // Add method to handle reply to message
  void replyToMessage(RoomMessage message) {
    setState(() {
      replyingTo = message;
    });
    // Focus the text field
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Add method to cancel reply
  void cancelReply() {
    setState(() {
      replyingTo = null;
    });
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
                padding: const EdgeInsets.only(left: 3, right: 5),
                child: Row(
                  children: [
                    Text(
                      widget.team1,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Text(
                      ' vs ',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Text(
                      widget.team2,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 18),
                  child: SvgPicture.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/app_logos/LIVEGATE_dark.svg'
                      : 'assets/app_logos/LIVEGATE_light.svg',
                  height: screenHeight * 0.022,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              /* //share and report button
              Padding(
                padding: EdgeInsets.only(right: 18),
                child: GestureDetector(
                  child: SvgPicture.asset(
                    'assets/report.svg',
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
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => FriendsBottomSheet(),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/share.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              */

            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Chat messages (Scrollable List)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 15),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return GestureDetector(
                      onLongPress: () {
                            // navigate with a custom [HeroDialogRoute] to [ReactionsDialogWidget]
                            Navigator.of(context).push(
                              HeroDialogRoute(
                                builder: (context) {
                                  return ReactionsDialogWidget(
                                    widgetAlignment: Alignment.topLeft,
                                    id: message.id, // unique id for message
                                    messageWidget: buildMessage(message, index), // message widget
                                    onReactionTap: (reaction) {
                                      print('reaction: $reaction');

                                      if (reaction == '➕') {
                                        showEmojiBottomSheet(
                                          message: message,
                                        );
                                        // show emoji picker container
                                      } else {
                                        addReactionToMessage(
                                          message: message,
                                          reaction: reaction,
                                        );
                                        // add reaction to message
                                      }
                                    },
                                    onContextMenuTap: (menuItem) {
                                      print('menu item: $menuItem');
                                      handleContextMenuTap(menuItem, message);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                      onHorizontalDragEnd: (details) {
                        // Only detect right to left swipes (negative velocity means right to left)
                        if (details.primaryVelocity! < 0) {
                          replyToMessage(message);
                        }
                      },
                      child: buildMessage(message, index),
                    );
                  },
                ),
              ),
              // Show reply preview if replying to a message
              if (replyingTo != null)
                Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0Xff242525)
                      : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Replying to ${replyingTo!.name}',
                                  style: GoogleFonts.interTight(
                                    fontSize: 12,
                                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1),
                            Text(
                              replyingTo!.messageContent,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.interTight(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: cancelReply,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ],
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 15),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                          maxRadius: screenHeight * 0.020,
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: screenHeight * 0.25,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: TextField(
                              controller: _controller,
                              cursorColor: Theme.of(context).colorScheme.tertiary,
                              minLines: 1,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(fontSize: 14), // You can tweak this
                              decoration: InputDecoration(
                                isCollapsed: true, // Minimizes vertical padding
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, // Reduce height here
                                  horizontal: 12,
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                /*
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
                                */
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: GestureDetector(
                            onTap: _isTyping ? _sendMessage : null,
                            child: Container(
                              height: screenHeight * 0.040,
                              width: screenHeight * 0.040,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isTyping
                                    ? Theme.of(context).brightness == Brightness.dark?
                                    Color(0xFF007AFF)
                                    :Colors.black
                                    : Theme.of(context).brightness == Brightness.dark
                                        ? Colors.grey.shade800
                                        : Colors.grey[350],
                              ),
                              child: Icon(
                                Icons.send,
                                color: _isTyping
                                    ? Colors.white
                                    : Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white60
                                        : Colors.white70,
                                size: screenHeight * 0.020,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Scroll to bottom button
          if (_showScrollButton)
            Positioned(
              right: 20,
              bottom: 300,
              child: FloatingActionButton(
                mini: true,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  _scrollController.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                child: Icon(
                  CupertinoIcons.chevron_down_circle,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: screenHeight * 0.026,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Message Bubble Widget
  Widget buildMessage(RoomMessage message, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isConsecutiveMessage = index < messages.length - 1 && 
                              messages[index + 1].name == message.name; //check if the next message is from the same user
    bool hasReaction = message.reactions.isNotEmpty; //check if the message has reactions
    bool isLastMessageFromUser = index > 0 && messages[index - 1].name != message.name; //check if the message is the last message from the user  
    double bottomPadding = hasReaction ? 25.0 : (isLastMessageFromUser ? 7.0 : 2.0); //space between reactions and between messages if it's the last message from the user

    return Container(
      padding: EdgeInsets.only(
        top: isConsecutiveMessage ? 2 : 7, //space between messages
        bottom: bottomPadding,
        left: 15,
        right: 15,
      ),
      child: Align(
        alignment: Alignment.centerLeft,  // Always align from left
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,  // Change to align from top
          children: [
            if (!isConsecutiveMessage) ...[
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.016),  // Small top padding to align with username
                child: CircleAvatar(
                  backgroundImage: NetworkImage(message.profileImage),
                  maxRadius: screenHeight * 0.020,
                ),
              ),
              SizedBox(width: screenWidth * 0.008),
            ],
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: isConsecutiveMessage
                      ? screenHeight * 0.040 + screenWidth * 0.008
                      : 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isConsecutiveMessage)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UsersProfilePage();
                          }));
                        },
                        child: Text(
                          message.name,
                          style: GoogleFonts.interTight(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    if (!isConsecutiveMessage) SizedBox(height: 3),//space between username and message

                    // Reply preview if this is a reply message
                    if (message.replyTo != null)
                      Container(
                        margin: EdgeInsets.only(bottom: 4), //space between reply preview and message
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.arrow_turn_down_right,
                                  size: 15,
                                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  message.replyToName ?? '',
                                  style: GoogleFonts.interTight(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2), //space between arrow and reply message
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                message.replyTo!.messageContent,
                                style: GoogleFonts.interTight(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: (message.messageType == "receiver"
                                ? Theme.of(context).brightness == Brightness.dark?
                                Color(0xFF2C2C2E)
                                :Theme.of(context).colorScheme.primary
                                : Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF007AFF)//or deeppurpleAccent or blue
                                    : Theme.of(context).colorScheme.secondary),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.0095, horizontal: 17),
                          child: Text(
                            message.messageContent,
                            style: GoogleFonts.interTight(
                              fontSize: screenHeight * 0.018,
                              color: message.messageType == "receiver"
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),

                        if (hasReaction)
                          Positioned(
                            bottom: -23,
                            left: message.messageType == "receiver" ? 7 : null,
                            right: message.messageType == "receiver" ? null : 7, //if on right side message.messageType == "receiver" ? null : 7,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: message.reactions.entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Row(
                                        children: [
                                          Text(entry.key, style: TextStyle(fontSize: 13)),
                                          if (entry.value > 1)
                                            Padding(
                                              padding: const EdgeInsets.only(left: 2),
                                              child: Text(
                                                entry.value.toString(),
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleContextMenuTap(dynamic menuItem, RoomMessage message) {
    print('menuItem: $menuItem');
    try {
      print('menuItem.label: \\${menuItem.label}');
    } catch (e) {
      print('menuItem.label not found');
    }
    try {
      print('menuItem.title: \\${menuItem.title}');
    } catch (e) {
      print('menuItem.title not found');
    }
    try {
      print('menuItem.value: \\${menuItem.value}');
    } catch (e) {
      print('menuItem.value not found');
    }
    String action;
    try {
      action = menuItem.label.toLowerCase();
    } catch (e) {
      action = menuItem.toString().toLowerCase();
    }
    switch (action) {
      case 'reply':
        replyToMessage(message);
        break;
      case 'copy':
        // Handle copy
        break;
      case 'report':
        // Handle report
        break;
      case 'delete':
        setState(() {
          messages.removeWhere((m) => m.id == message.id);
        });
        break;
    }
  }

  void _sendMessage() {
    String messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      // Create the new message
      RoomMessage newMessage = RoomMessage(
        id: const Uuid().v4(),
        name: '@$currentUser',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: messageText,
        messageType: "sender",
        selected: true,
        replyTo: replyingTo,
        replyToName: replyingTo?.name,
      );

      // Update UI
      setState(() {
        messages.insert(0, newMessage);
        replyingTo = null; // Clear the reply
      });

      // Scroll to bottom after the message is added
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      // Prepare socket message data
      Map<String, dynamic> messageData = {
        "gameId": widget.gameId,
        "message": messageText,
        "sender": currentUser,
        "messageType": "sender"
      };

      // Add reply information if present
      if (newMessage.replyTo != null) {
        messageData["replyTo"] = {
          "name": newMessage.replyToName,
          "message": newMessage.replyTo!.messageContent,
        };
      }

      // Send message through socket
      SocketManager().socket.emit('send message', messageData);
      _controller.clear();
    }
  }
}










  



//old app bar
/*AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 18, left: 18),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.back, size: 30,),
                  padding: EdgeInsets.only(right: 7, bottom: 7), // Remove default padding
                  constraints: BoxConstraints(), // Removes size constraints
                ),
                SizedBox(width: 2),
                Text('Lakers vs Warriors',
                    style: GoogleFonts.interTight(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary)),
                SizedBox(width: 4),
                Text('1 hr',
                    style: GoogleFonts.interTight(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary)),
                SizedBox(width: 6),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.only(bottom: 1),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => buildSheet(),
                          );
                        },
                        icon: Icon(
                            CupertinoIcons.paperplane,
                            size: 24,
                            color: Theme.of(context).colorScheme.tertiary),
                        constraints: BoxConstraints(),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatDocumentsPage()));
                        },
                        icon: Icon(CupertinoIcons.exclamationmark_circle, size: 26,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      */

      
/*
Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(top: 10,),
                      height: screenHeight*0.052,
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 13,),
        
                          Expanded(
                            child: TextField(
                              cursorColor: Theme.of(context).colorScheme.tertiary,
        
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 12, left: 12),
                                suffixIcon: Icon(CupertinoIcons.square,color: Theme.of(context).colorScheme.tertiary,),
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.onPrimary,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17),
                                    borderSide: BorderSide(color: Colors.transparent)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                              ),
                            ),
                          ),
        
                          Padding(
                            padding: const EdgeInsets.only(left: 33, right: 18),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ProfilePage();
                                }));
                              },
                              child: Center(
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.tertiary,
                                  ),
                                  child: Icon(
                                    Icons.send,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
          ],
        ),
        */