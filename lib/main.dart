import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:ndialog/ndialog.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Dreamer @ The Observation Merchandise',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'The Official Merchandise platform of The Observation.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  String name = "";
  TextEditingController obsIDController = TextEditingController();
  String obsID = "";
  TextEditingController contactController = TextEditingController();
  String contact = "";
  TextEditingController address1Controller = TextEditingController();
  String add1 = "";
  TextEditingController address2Controller = TextEditingController();
  String add2 = "";
  TextEditingController districtController = TextEditingController();
  String district = "";

  TextEditingController stateController = TextEditingController();
  String state="";

  TextEditingController pincodeController = TextEditingController();
  String pin = "";
  TextEditingController countryController = TextEditingController();
  String country = "";
  String sizeValue = "Small";
  ShirtStyles currentShirtStyle = ShirtStyles.none;
  Map<ShirtStyles, String> descriptions = {
    ShirtStyles.black_male: "Color: Black - Styled For: Men",
    ShirtStyles.black_female: "Color: Black - Styled For: Women",
    ShirtStyles.white_male: "Color: White - Styled For: Men",
    ShirtStyles.white_female: "Color: White - Styled For: Women",
  };




  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(12.0));

    var selectedColor = Color(0xff4A6C54);
    var notSelectedColor = Color(0xff2C3730);

    Map<String, dynamic> dbFields = {
      "fields": {
        "Full_Name": name,
        "Observation_ID": obsID,
        "Contact_Num": contact,
        "Address_Line_1": add1,
        "Address_Line_2": add2,
        "District": district,
        "State": state,
        "Country": country,
        "PIN": pin,
        "Style_Code": descriptions[currentShirtStyle],
        "Size": sizeValue
      }
    };

    Future<dynamic> postToDB() async {
      final response =  await http.post(
        Uri.parse('https://api.airtable.com/v0/appo2H9OryLkTxKRQ/Table%201'),
        headers: <String, String>{
          'Authorization': 'Bearer keyJ1PqUbBggmpXCY',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(dbFields),
      );

      if (response.statusCode == 200) {
       print( jsonDecode(response.body));
      } else {
        print(response);
      }

    }


    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff162019),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  "assets/assets/header_obs_merchs.png",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Text(
                  "A Dreamer @ The Observation Series",
                  style: TextStyle(
                      fontFamily: "Cagliostro",
                      color: Colors.white,
                      fontSize: 17,
                      letterSpacing: 1.5),
                ),
              ),
              Divider(
                color: Colors.white,
                indent: 80,
                endIndent: 80,
                thickness: 1.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                alignment: Alignment.center,
                child: Text(
                  "Official Merchandise for Employees",
                  style: TextStyle(
                      fontFamily: "Cagliostro",
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 1.5),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                child: Text(
                  "As a token of appreciation to the new Employees & Stakeholders, The Observation delivers official merchandise of their choice to thier registered address. This portal is exclusively for the Employees & StakeHolders to register their details. ",
                  style: TextStyle(
                      fontFamily: "Cagliostro",
                      color: Colors.grey,
                      letterSpacing: 1.5,
                      fontSize: 11),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.greenAccent, Color(0xff162019)]),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Identification & Shipping",
                    style: TextStyle(
                        fontFamily: "Cagliostro",
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.greenAccent)),
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Text("Full Name",
                                style: TextStyle(
                                    fontFamily: "Cagliostro",
                                    fontSize: 12,
                                    color: Colors.greenAccent)),
                            hintText:
                                "Note: This will be printed at the package.",
                            hintStyle: TextStyle(
                                fontFamily: "Cagliostro",
                                fontSize: 12,
                                color: Colors.greenAccent),
                            contentPadding: EdgeInsets.all(25),
                            isCollapsed: true,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: obsIDController,
                          onChanged: (value) {
                            setState(() {
                              obsID = value;
                            });
                          },
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("Observation ID",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "you@theobservation.app",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: contactController,
                          onChanged: (value) {
                            setState(() {
                              contact = value;
                            });
                          },
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("Registered Contact Number",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "e.g. +91 1234567890",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: address1Controller,
                          onChanged: (value) {
                            setState(() {
                              add1 = value;
                            });
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("Address Line 1",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "e.g. 223, Boulevard 1A",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              add2 = value;
                            });
                          },
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("Address Line 2",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "e.g. Near Kinesis Opera, High Street",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: districtController,
                          onChanged: (value) {
                            setState(() {
                              district = value;
                            });
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("District",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "e.g. New York City",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: pincodeController,
                          onChanged: (value) {
                            pin = value;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("Pincode",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "e.g. 110115",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: stateController,
                          onChanged: (value) {
                            state = value;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("State",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "e.g. California",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: countryController,
                          onChanged: (value) {
                            country = value;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: Text("Country",
                                  style: TextStyle(
                                      fontFamily: "Cagliostro",
                                      fontSize: 12,
                                      color: Colors.greenAccent)),
                              hintText: "e.g. United States of America",
                              hintStyle: TextStyle(
                                  fontFamily: "Cagliostro",
                                  fontSize: 12,
                                  color: Colors.greenAccent),
                              contentPadding: EdgeInsets.all(25),
                              isCollapsed: true,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.greenAccent, Color(0xff162019)]),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Styles & Sizes",
                    style: TextStyle(
                        fontFamily: "Cagliostro",
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.greenAccent)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Select Your T-Shirt Size",
                        style: TextStyle(
                            fontFamily: "Cagliostro",
                            fontSize: 15,
                            color: Colors.greenAccent),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.greenAccent),
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: sizeValue,
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            letterSpacing: 2.0,
                          ),
                          alignment: Alignment.topLeft,
                          icon: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Ionicons.shirt_outline,
                                color: Colors.greenAccent,
                                size: 24,
                              )),
                          dropdownColor: notSelectedColor,
                          borderRadius: BorderRadius.circular(12.0),
                          hint: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Select Your T-Shirt Size",
                              style: TextStyle(
                                fontFamily: "Cagliostro",
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                          items: <String>[
                            'Small',
                            'Medium',
                            'Large',
                            'X-Large',
                            'XX-Large'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontFamily: "Cagliostro",
                                  color: Colors.greenAccent,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newString) {
                            setState(() {
                              sizeValue = newString!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 450,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Card(
                      color: (currentShirtStyle == ShirtStyles.black_male)
                          ? selectedColor
                          : notSelectedColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Image.network(
                                        'assets/assets/mens_black.jpg',
                                        height: 300,
                                        width: 300,
                                        fit: BoxFit.contain,
                                      )),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "A Dreamer @ The Observation\nColor: Black\nStyled For: Male",
                                style: TextStyle(
                                    fontFamily: "Cagliostro",
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.greenAccent)),
                                onPressed: () {
                                  if (currentShirtStyle ==
                                      ShirtStyles.black_male) {
                                    setState(() {
                                      currentShirtStyle = ShirtStyles.none;
                                    });
                                  } else {
                                    setState(() {
                                      currentShirtStyle = ShirtStyles.black_male;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    (currentShirtStyle == ShirtStyles.black_male)
                                        ? "Selected"
                                        : "Select",
                                    style: TextStyle(
                                        fontFamily: "Cagliostro",
                                        fontSize: 14,
                                        color: Colors.greenAccent),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: (currentShirtStyle == ShirtStyles.white_male)
                          ? selectedColor
                          : notSelectedColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Image.network(
                                        'assets/assets/mens_white.jpg',
                                        height: 300,
                                        width: 300,
                                        fit: BoxFit.contain,
                                      )),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "A Dreamer @ The Observation\nColor: White\nStyled For: Male",
                                style: TextStyle(
                                    fontFamily: "Cagliostro",
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.greenAccent)),
                                onPressed: () {
                                  if (currentShirtStyle ==
                                      ShirtStyles.white_male) {
                                    setState(() {
                                      currentShirtStyle = ShirtStyles.none;
                                    });
                                  } else {
                                    setState(() {
                                      currentShirtStyle = ShirtStyles.white_male;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    (currentShirtStyle == ShirtStyles.white_male)
                                        ? "Selected"
                                        : "Select",
                                    style: TextStyle(
                                        fontFamily: "Cagliostro",
                                        fontSize: 14,
                                        color: Colors.greenAccent),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: (currentShirtStyle == ShirtStyles.black_female)
                          ? selectedColor
                          : notSelectedColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Image.network(
                                        'assets/assets/womens_black.jpg',
                                        height: 300,
                                        width: 300,
                                        fit: BoxFit.contain,
                                      )),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "A Dreamer @ The Observation\nColor: Black\nStyled For: Female",
                                style: TextStyle(
                                    fontFamily: "Cagliostro",
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.greenAccent)),
                                onPressed: () {
                                  setState(() {
                                    if (currentShirtStyle ==
                                        ShirtStyles.black_female) {
                                      setState(() {
                                        currentShirtStyle = ShirtStyles.none;
                                      });
                                    } else {
                                      setState(() {
                                        currentShirtStyle =
                                            ShirtStyles.black_female;
                                      });
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    (currentShirtStyle ==
                                            ShirtStyles.black_female)
                                        ? "Selected"
                                        : "Select",
                                    style: TextStyle(
                                        fontFamily: "Cagliostro",
                                        fontSize: 14,
                                        color: Colors.greenAccent),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: (currentShirtStyle == ShirtStyles.white_female)
                          ? selectedColor
                          : notSelectedColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Image.network(
                                        'assets/assets/womens_white.jpg',
                                        height: 300,
                                        width: 300,
                                        fit: BoxFit.contain,
                                      )),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "A Dreamer @ The Observation\nColor: White\nStyled For: Female",
                                style: TextStyle(
                                    fontFamily: "Cagliostro",
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.greenAccent)),
                                onPressed: () {
                                  setState(() {
                                    if (currentShirtStyle ==
                                        ShirtStyles.white_female) {
                                      setState(() {
                                        currentShirtStyle = ShirtStyles.none;
                                      });
                                    } else {
                                      setState(() {
                                        currentShirtStyle =
                                            ShirtStyles.white_female;
                                      });
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    (currentShirtStyle ==
                                            ShirtStyles.white_female)
                                        ? "Selected"
                                        : "Select",
                                    style: TextStyle(
                                        fontFamily: "Cagliostro",
                                        fontSize: 14,
                                        color: Colors.greenAccent),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                    padding: EdgeInsets.all(20),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.0),
                  ),
                  onPressed: () {
                    if (name != "" &&
                        obsID != "" &&
                        contact != "" &&
                        currentShirtStyle != ShirtStyles.none &&
                        add1 != "" &&
                        district != "" &&
                        pin != "" &&
                        country != "") {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Color(0x00162019),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    margin: EdgeInsets.fromLTRB(25, 20, 25, 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Order Specifications For ${name.split(" ")[0]}",
                                              style: TextStyle(
                                                  fontFamily: "Cagliostro",
                                                  letterSpacing: 2.0, fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                          child: Text(
                                            "Selected Size: $sizeValue",
                                            style: TextStyle(
                                                fontFamily: "Cagliostro",
                                                ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                          child: Text(
                                            "Style Information: ${descriptions[currentShirtStyle]}",
                                            style: TextStyle(
                                              fontFamily: "Cagliostro",
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                          child: Text(
                                            "Observation ID: $obsID",
                                            style: TextStyle(
                                              fontFamily: "Cagliostro",
                                            ),

                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                          child: Text(
                                            "Contact Number: $contact",
                                            style: TextStyle(
                                              fontFamily: "Cagliostro",
                                              ),

                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: ConfirmationSlider(
                                      stickToEnd: true,
                                      text: "Slide to Confirm Order",
                                      textStyle: TextStyle(fontFamily: "Cagliostro", color: Colors.greenAccent),
                                      backgroundColor: Color(0xff162019),
                                      foregroundColor: Colors.greenAccent,
                                      backgroundColorEnd: Colors.greenAccent,
                                      onConfirmation: () async {

                                        ProgressDialog progressDialog =
                                        ProgressDialog(context,
                                            dialogStyle: DialogStyle(backgroundColor: Color(0xff162019), borderRadius: BorderRadius.circular(12.0)),
                                            dialogTransitionType: DialogTransitionType.Bubble,
                                            blur: 10,
                                            backgroundColor: Color(0xff162019),
                                            message:Text("Sending Order Information to The Observation Servers. Please be patient.", style: TextStyle(fontFamily: "Cagliostro", color: Colors.white),),
                                            title:Text("Processing", style: TextStyle(fontFamily: "Cagliostro", color: Colors.greenAccent, fontSize: 15),)
                                        );


                                        progressDialog.show();

                                        await postToDB();
                                        Navigator.pop(context);
                                        progressDialog.dismiss();

                                        DialogBackground(
                                          dismissable: false,
                                          barrierColor: Color(0xff162019),
                                          blur: 10,
                                          dialog:
                                          AlertDialog(
                                            backgroundColor: Colors.greenAccent,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                            title: Lottie.network('assets/assets/success.json', repeat: false, height: 150, width: 150),

                                            content: Container(
                                              height: 150,
                                              child: Column(
                                                children: [
                                                  Container(child: Text("Order Successful.", style:TextStyle(fontFamily: "Cagliostro", color: Colors.black, fontSize: 15, letterSpacing: 2.0, fontWeight: FontWeight.bold), )),
                                                  SizedBox(height: 10,),
                                                  Container(child: Text("Please keep and eye on your mailbox for further communication and Tracking details. Due to countrywide shipping restrictions it may take upto 4 weeks for the printing and delivery partner to deliver the product at your location. ", style:TextStyle(fontFamily: "Cagliostro", color: Colors.black, fontSize: 11, letterSpacing: 2.0), )),

                                                ],
                                              ),
                                            ),

                                            actions: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text("R E V E R E N C E.", style:TextStyle(fontFamily: "Cagliostro", color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold), ),
                                              ),
                                            ],
                                          ),
                                        ).show(context, transitionType: DialogTransitionType.Bubble);

                                      },),

                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      DialogBackground(
                        blur: 10,
                        dialog: AlertDialog(
                          backgroundColor: Color(0xff19241D),
                          title: Text(
                              "One or more required fields are empty. Check the following points before submitting: \n\n\n - Fields such as Full Name, Observation ID, Contact Number, Address Line 1, District, State, Pin Code, Country are not empty. \n\n - Make sure you have selected the size and style of the merchandise before submitting",
                            style: TextStyle(fontFamily: "Cagliostro", fontSize: 11, color: Colors.greenAccent),
                          ),
                        ),
                      ).show(context,
                          transitionType: DialogTransitionType.BottomToTop);
                    }
                  },
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                        fontFamily: "Cagliostro",
                        color: Colors.black,
                        fontSize: 18,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Text(
                    "Copyright (C) 2022 The Observation Media Technologies Corporation Limited. The Observation, REVERENCE, The Observation RED DOT are registered trademark(s) of The Observation Media Technologies Corporation Limited. All rights are reserved.\n\nTo avail this service you must provide an internal Observation Account for verification procedures. However your data around your Observation ID are not by any means collected or stored in any form. The services of this portal are exclusively available to the employees of The Observation Media Technologies Corporation Limited and its affiliates.",
                    style: TextStyle(
                      fontFamily: "Cagliostro",
                      fontSize: 9,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Text(
                    "R  E  V  E  R  E  N  C  E.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Cagliostro",
                      color: Colors.white,
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

enum ShirtStyles { black_male, white_male, black_female, white_female, none }
