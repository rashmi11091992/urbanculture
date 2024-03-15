import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RoutineScreen.dart';
import 'Skincareprovider.dart';
import 'StreaksScreen.dart';

class SkincareRoutineScreen extends StatefulWidget {
  @override
  _SkincareRoutineScreenState createState() => _SkincareRoutineScreenState();
}

class _SkincareRoutineScreenState extends State<SkincareRoutineScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    RoutineScreen(),
    StreaksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<SkincareProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Color(0xffFCF7FA),
        body: _tabs[_currentIndex],
        bottomNavigationBar: Container(
          alignment: Alignment.bottomCenter,
          height: 56,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xffb88797),
                width: 0.2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                    provider.resetAllRoutines();
                  });
                },
                child: Container(
                  width: 66,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Color(0xffb88797),
                      ),
                      Text("Routine",
                          style: TextStyle(
                            color: Color(0xffb88797),
                          ))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Container(
                  width: 66,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.group_rounded,
                        color: Color(0xffb88797),
                      ),
                      Text("Streaks",
                          style: TextStyle(
                            color: Color(0xffb88797),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border(
        //       top: BorderSide(
        //         color: Color(0xffb88797),
        //         width: 0.5,
        //       ),
        //     ),
        //   ),
        //   child: BottomNavigationBar(
        //     currentIndex: _currentIndex,
        //     onTap: (index) {
        //       setState(() {
        //         _currentIndex = index;
        //       });
        //     },
        //     backgroundColor: Colors.white10,
        //     elevation: 0,
        //     iconSize: 40,
        //     unselectedItemColor: Color(0xffb88797),
        //     selectedItemColor: Color(0xffb88797),
        //     items: const [
        //       BottomNavigationBarItem(
        //         icon: Padding(
        //           padding: EdgeInsets.only(bottom: 2.0),
        //           child: Icon(Icons.search),
        //         ),
        //         label: 'Routine',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Padding(
        //           padding: EdgeInsets.only(bottom: 2.0),
        //           child: Icon(Icons.group),
        //         ),
        //         label: 'Streaks',
        //       ),
        //     ],
        //   ),
        // ),
      );
    });
  }
}
