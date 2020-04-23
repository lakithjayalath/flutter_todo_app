import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewTask extends StatefulWidget {
  NewTask();
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  String taskName;
  String taskDetails;
  String taskDate;
  String taskTime;

  getTaskName(taskName) {
    this.taskName = taskName;
  }

  getTaskDetails(taskDetails) {
    this.taskDetails = taskDetails;
  }

  getTaskDate(taskDate) {
    this.taskDate = taskDate;
  }

  getTaskTime(taskTime) {
    this.taskTime = taskTime;
  }

  int _myTaskType = 0;
  String taskVal;

  void _handleTaskType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          taskVal = 'travel';
          break;
        case 2:
          taskVal = 'shopping';
          break;
        case 3:
          taskVal = 'gym';
          break;
        case 4:
          taskVal = 'party';
          break;
        case 5:
          taskVal = 'other';
          break;
      }
    });
  }

  //add data to the fire store
  createData() {
    DocumentReference ds = Firestore.instance.collection('todolist').document(taskName);
    Map<String, dynamic> tasks = {
      'taskDate': taskDate,
      'taskDetails': taskDetails,
      'taskName': taskName,
      'taskTime': taskTime,
      'taskType': taskVal
    };
    ds.setData(tasks).whenComplete(() {
      print('Task created');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String name) {
                      getTaskName(name);
                    },
                    decoration: InputDecoration(labelText: "Task: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String details) {
                      getTaskDetails(details);
                    },
                    decoration: InputDecoration(labelText: "Details: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String date) {
                      getTaskDate(date);
                    },
                    decoration: InputDecoration(labelText: "Date: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String time) {
                      getTaskDetails(time);
                    },
                    decoration: InputDecoration(labelText: "Time: "),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    'Select Task Type: ',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Travel',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Shopping',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Gym',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Party',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 5,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Other',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xFFFA7397),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFFFDDE42)),
                      ),
                    ),
                    RaisedButton(
                      color: Color(0xFFFA7397),
                      onPressed: () {
                        createData();
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Color(0xFFFDDE42)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


Widget _myAppBar(context) {
  return Container(
    height: 80.0,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFFFA7397),
          const Color(0xFFFDDE42),
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'New Tasks',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
