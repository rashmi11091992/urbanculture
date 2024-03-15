import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Skincareprovider.dart';
import 'StreaksScreen.dart';

class RoutineScreen extends StatefulWidget {
  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF7FA),
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Daily Skincare',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Color(0xffFCF7FA),
      ),
      body: Consumer<SkincareProvider>(
        builder: (context, provider, child) {
          if (provider.allRoutinesCompletedForToday()) {
            provider.showMessage();
            Fluttertoast.showToast(
              msg: 'You have completed your daily routine for today.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 12.0,
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.routine.length,
                  itemBuilder: (context, index) {
                    final step = provider.routine[index];

                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(5),
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xfff2e8eb),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: step.completed
                              ? Icon(Icons.check, color: Colors.black, size: 20)
                              : null,
                        ),
                        onTap: () {
                          if (!step.completed) {
                            provider.toggleStep(index);
                          }
                        },
                        title: Text(
                          step.name.toString(),
                          style:
                              TextStyle(color: Color(0xff62565b), fontSize: 16),
                        ),
                        subtitle: Text(
                          step.subname.toString(),
                          style:
                              TextStyle(color: Color(0xffb88797), fontSize: 14),
                        ),
                        trailing: Container(
                          // margin: EdgeInsets.only(right: 20),
                          constraints:
                              BoxConstraints(maxHeight: 27, maxWidth: 80),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  provider.getImageFromCamera(context, index);
                                },
                                child: provider.isUploading[index] &&
                                        provider.imageUrls[index].isEmpty
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Color(0xffb88797),
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : provider.imageUrls[index].isNotEmpty
                                        ? Image.network(
                                            "${provider.imageUrls[index]}")
                                        : Container(
                                            height: 27,
                                            width: 27,
                                            color: Color(0xffb7b7b7),
                                            child: Image.asset(
                                              "assets/images/camera.jpg",
                                            )),
                              ),
                              Spacer(),
                              Container(
                                  // margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                '${provider.getCompletionTime(index)}',
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xffb88797)),
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
