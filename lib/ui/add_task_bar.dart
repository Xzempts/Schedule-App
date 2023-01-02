import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/controllers/task_controller.dart';
import 'package:scheduler/ui/theme.dart';
import 'package:scheduler/ui/widgets/button.dart';
import 'package:scheduler/ui/widgets/input_field.dart';

import '../models/task.dart';
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController= Get.put(TaskController());
  final TextEditingController _titleController =TextEditingController();
  final TextEditingController _noteController =TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String endTime = DateFormat("hh:mm a").format(DateTime.now().add(Duration(minutes: 30))).toString();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List <int> remindList=[
    5,
    10,
    15,
    20,
    30,
    45,
    60,
  ];
  String _selectedRepeat = "None";
  List <String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
  ];
int _selectedColor=0;
 // String _selectedRepeat = "None";
//  List <String> repeatList=[
  //   "None",
//    "Monday",
  //   "Tuesday",
  //   "Wednesday",
  //  "Thursday",
  //  "Friday",
  //  "Saturday",
  //   "Sunday",
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.bottomAppBarColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                 style: headingStyle,
              ),
           MyInputField(title: "Title", hint: "Enter your title",controller: _titleController,),
              MyInputField(title: "Any Details?", hint: "Enter your note",controller: _noteController,),
              MyInputField(title: "Start Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon:const Icon(Icons.calendar_today_outlined,
                  color:Colors.grey
                ),
                onPressed: () {
                  _getDateFromUser();
                },
              ),),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: "Start Time",
                        hint: startTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime:true);
                        },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color:Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                      child: MyInputField(
                        title: "End Time",
                        hint: endTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime:false);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color:Colors.grey,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              MyInputField(title: "Add Alerts", hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down,
                    color:Colors.grey,

              ),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items:remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child:Text(value.toString())
                  );
                }
              ).toList()),
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                      color:Colors.grey,

                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    onChanged: (String? newValue){
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items:repeatList.map<DropdownMenuItem<String>>((String? value){
                      return DropdownMenuItem<String>(
                          value:value,
                          child:Text(value!, style:const TextStyle(color:Colors.grey))
                      );
                    }
                    ).toList()),
              ),
              SizedBox(height: 8.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  MyButton(label: "Create Task", onTap:()=>_validateDate()
              ),
              ],
              )
            ],
          ),
        ),
      )
    );
  }

  _validateDate(){
      if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
    }else if(_titleController.text.isEmpty ||_noteController.text.isEmpty){
        Get.snackbar("Error", "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom:10,),
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon:Icon(Icons.warning_amber_rounded,
            color:Colors.red
          )
        );
  }
  }

  _addTaskToDb()async{
   int value = await _taskController.addTask(
        task: Task(
          note: _noteController.text,
          title:_titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: startTime,
          endTime: endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        )
    );
   print("My id is "+"$value");
  }
  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pick a Color",
          style: titleStyle,
        ),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(
              9,
                  (int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor=(index);
                    });

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5 , left: 5.0 , right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index==0?bluishClr:index==1?redClr:index==2?pinkClr:index==3?yellowClr:index==4?greenClr:index==5?orangeClr:index==6?brownClr:index==7?purpleClr:blackClr,
                      child: _selectedColor==index?Icon(Icons.done,
                          color: Colors.white,
                          size:16

                      ):Container(),
                    ),
                  ),
                );
              }
          ),
        )

      ],
    );
  }

  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      leading:GestureDetector(
        onTap:(){
            Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
            size: 20,
            color:Get.isDarkMode ? Colors.white:Colors.black
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/profile.png"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2222)
    );

    if(_pickerDate!=null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    }else{
      print("It's null or something is wrong");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async{
   var pickedTime = await _showTimePicker();
   String _formatedTime = pickedTime.format(context);
   if(pickedTime==null){
     print("Time Canceled");
   }else if(isStartTime==true) {
     setState(() {
       startTime = _formatedTime;
     });
   }else if(isStartTime==false){
     setState(() {
       endTime=_formatedTime;
     });
   }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            //_startTime --> 10:30 AM
            hour: int.parse(startTime.split(":")[0]),
            minute: int.parse(startTime.split(":")[1].split(" ")[0]),

        )
    );
  }

  row({required MainAxisAlignment mainAxisAlignment, required CrossAxisAlignment crossAxisAlignment, required List<MyButton> children}) {}
}
