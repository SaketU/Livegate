import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDocumentsPage extends StatefulWidget{
  @override
  _ChatDocumentsPageState createState() => _ChatDocumentsPageState();
}

class _ChatDocumentsPageState extends State<ChatDocumentsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child:
      Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 5),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.back,),
                  ),
                  SizedBox(width: 2,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(CupertinoIcons.search,color: Colors.grey.shade600,size: 25,),
                          filled: true,
                          fillColor: Colors.black12,
                          contentPadding: EdgeInsets.all(3),
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
                  Padding(padding: EdgeInsets.only(right: 10, left: 10, top: 16,),),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Text('Select',),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
                ],
              ),
            ),
          ),
        ),
        body:
        Container(
          child: Column(
            children: [
              Container(
                height: 35,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: [
                    Tab(text: "Saved",),

                    Tab(text: "Posted",),

                    Tab(text: "Photos",),
                  ],
                ),
              ),
              Expanded(
                child:
                TabBarView(
                  children: [
                    Center(child: Text("one"),),
                    Center(child: Text("two"),),
                    Center(child: Text("three"),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}