import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:updated_barber_project/services/database.dart';
import 'package:updated_barber_project/services/shared_pref.dart';

class Booking extends StatefulWidget {
  final String service;

  const Booking({
    super.key,
    required this.service,
  });

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025),
        initialDate: _selectedDate);

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Shared Preferences Code

  String? name, image, email;

  getTheDataFromSharePref() async {
    name = await SharedPreferencsHelper().getUserName();
    image = await SharedPreferencsHelper().getUserImage();
    email = await SharedPreferencsHelper().getUserEmail();
    setState(() {});
  }

  getontheLoad() async {
    await getTheDataFromSharePref();
    setState(() {});
  }

  @override
  void initState() {
    getontheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                "Let's the\njourney begin",
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
              SizedBox(height: 15.0),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset("assets/discount.jpg")),
              SizedBox(height: 15.0),
              Text(widget.service,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0)),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xFFb4817e),
                ),
                child: Column(
                  children: [
                    Text("Set a Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month,
                              color: Colors.white, size: 21.0),
                          SizedBox(width: 20.0),
                          Text(
                              "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xFFb4817e),
                ),
                child: Column(
                  children: [
                    Text("Set a Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm, color: Colors.white, size: 21.0),
                          SizedBox(width: 20.0),
                          Text("${_selectedTime.format(context)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.0),
              GestureDetector(
                onTap: () async {
                  Map<String, dynamic> userBookingMap = {
                    "Service": widget.service,
                    "Date":
                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
                            .toString(),
                    "Time": "${_selectedTime.format(context)}".toString(),
                    "Username": name,
                    "Image": image,
                    "Email": email,
                  };
                  await DatabaseMethods()
                      .addUserBooking(userBookingMap)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Service Added Successfully",
                            style: TextStyle(fontSize: 20.0))));
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
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
}
