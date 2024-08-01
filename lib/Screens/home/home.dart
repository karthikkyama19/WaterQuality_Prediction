import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tutorial_2/Models/brew.dart';
import 'package:tutorial_2/Screens/home/api.dart';
import 'package:tutorial_2/Services/auth.dart';
import 'package:tutorial_2/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorial_2/Models/brew.dart';
import 'package:tutorial_2/Screens/predict.dart';
import 'package:tutorial_2/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tutorial_2/Screens/home/apiautofill.dart';
import 'package:tutorial_2/Screens/home/listtilll.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);
  late List<num> auto;

  Home(List<num> aut) {
    auto = aut;
  }

  @override
  State<Home> createState() => _HomeState(this.auto);
}

class _HomeState extends State<Home> {
  late List<num> auto;
  var take;
  _HomeState(List<num> aut) {
    auto = aut;
  }

  final player = AudioPlayer();

  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  void autofill() async {
    var pH = pHc.text;
    var hardness = hardnessc.text;
    var solids= solidsc.text;
    var chloramines = chloraminesc.text;
    var sulphates= sulphatesc.text;
    var conductivity = conductivityc.text;
    var organiccarbon = organiccarbonc.text;
    var trihalomethanes = trihalomethanesc.text;
    var turbidity = turbidityc.text;
    dynamic map = {
      "ph": pH,
      "Hardness": hardness,
      "Solids": solids,
      "Chloramines": chloramines,
      "Sulfate": sulphates,
      "Conductivity": conductivity,
      "Organic_carbon": organiccarbon,
      "Trihalomethanes": trihalomethanes,
      "Turbidity": turbidity
    };
    Map<String, dynamic> df = await autoFill(map);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Listvalues(df)));
  }

  void fillup() {
    take= auto[10].toString();
    pHc.text = this.auto[1].toString() == "-1" ? "" : this.auto[1].toString();
    hardnessc.text =
        this.auto[2].toString() == "-1" ? "" : this.auto[2].toString();
    solidsc.text =
        this.auto[3].toString() == "-1" ? "" : this.auto[3].toString();
    chloraminesc.text =
        this.auto[4].toString() == "-1" ? "" : this.auto[4].toString();
    sulphatesc.text =
        this.auto[5].toString() == "-1" ? "" : this.auto[5].toString();
    conductivityc.text =
        this.auto[6].toString() == "-1" ? "" : this.auto[6].toString();
    organiccarbonc.text =
        this.auto[7].toString() == "-1" ? "" : this.auto[7].toString();
    trihalomethanesc.text =
        this.auto[8].toString() == "-1" ? "" : this.auto[8].toString();
    turbidityc.text =
        this.auto[9].toString() == "-1" ? "" : this.auto[9].toString();
  }

  var pHc = TextEditingController();
  var hardnessc = TextEditingController();
  var solidsc = TextEditingController();
  var chloraminesc = TextEditingController();
  var sulphatesc = TextEditingController();
  var conductivityc = TextEditingController();
  var organiccarbonc = TextEditingController();
  var trihalomethanesc = TextEditingController();
  var turbidityc = TextEditingController();

  Future<String> fun(int n) async {
    dynamic map = {
      "ph": pHc.text,
      "Hardness": hardnessc.text,
      "Solids": solidsc.text,
      "Chloramines": chloraminesc.text,
      "Sulfate": sulphatesc.text,
      "Conductivity": conductivityc.text,
      "Organic_carbon": organiccarbonc.text,
      "Trihalomethanes": trihalomethanesc.text,
      "Turbidity": turbidityc.text
    };
    var abc = await callApi(map, n);
    print(abc);
    String asc = abc.toString();
    if (asc == "Unsafe to drink") {
      asc = "It is not suitable for Drinking";
    } else {
      asc = "It is suitable for Drinking";
    }
    return asc;
  }
  Text x=Text('Your water is expected to be safe');
  Text y=Text('Your water is not expected to be safe');

  final AuthService _auth = AuthService();
  bool loading = false;

  void cun() {
    pHc.text = "9.44513";
    hardnessc.text = "145.8054";
    solidsc.text = "13168.53";
    chloraminesc.text = "9.444471";
    sulphatesc.text = "310.5834";
    conductivityc.text = "529.659";
    organiccarbonc.text = "8.6097";
    trihalomethanesc.text = "77.57746";
    turbidityc.text = "3.875165";
  }

  @override
  Widget build(BuildContext context) {
    fillup();
    return loading
        ? MaterialApp(home: Builder(builder:(context)=> Loading()))
        : Scaffold(
            backgroundColor: Colors.cyan[100],
            appBar: AppBar(
              title: Text('Home'),
              centerTitle: true,
              backgroundColor: Colors.cyanAccent[400],
              elevation: 0.0,
              actions: [
                TextButton.icon(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  label: Text(
                    'LogOut',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sky1.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Enter Parameters',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                fontFamily: 'Anton'),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: pHc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () async {
                                await goToWebPage(
                                    "https://en.wikipedia.org/wiki/PH");
                              },
                              icon: Icon(
                                Icons.info,
                                color: Colors.black45,
                              ),
                            ),
                            hintText: 'pH',
                            labelText: 'pH',
                            labelStyle: TextStyle(color: Colors.black87),
                            hintStyle: TextStyle(fontWeight: FontWeight.w400),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: hardnessc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Hardness");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Hardness',
                            labelText: 'Hardness',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: solidsc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Total_dissolved_solids");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Solids',
                            labelText: 'Solids',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: chloraminesc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Chloramines");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Chloramines',
                            labelText: 'Chloramines',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: sulphatesc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Sulfur_water");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Sulphates',
                            labelText: 'Sulphates',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: conductivityc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Conductivity_(electrolytic)#:~:text=High%20quality%20deionized%20water%20has,or%2050%2C000%20%CE%BCS%2Fcm).");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Conductivity',
                            labelText: 'Conductivity',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: organiccarbonc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Total_organic_carbon");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Organic Carbon',
                            labelText: 'Organic Carbon',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: trihalomethanesc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Trihalomethane");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Trihalomethanes',
                            labelText: 'Trihalomethanes',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: turbidityc,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await goToWebPage(
                                      "https://en.wikipedia.org/wiki/Turbidity");
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.black45,
                                )),
                            hintText: 'Turbidity',
                            labelText: 'Turbidity',
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: this.auto[10].toString()=="-1"?false:true,
                        child: Text('Ground Truth : $take')
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade500)),
                        child: Text(
                          '          AutoFill          ',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          autofill();
                        },
                      ),
                      Text(
                        'Choose Algorithm to Predict',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade500)),
                        child: Text(
                          '          XGBoost          ',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          String output1 = await fun(1);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Predict(abcd: output1.toString())));
                          output1 == "It is not suitable for Drinking"
                              ? player.play(AssetSource('notdrinkaudio.mp3'))
                              : player.play(AssetSource('drinkaudio.mp3'));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade500)),
                        child: Text(
                          '    Random Forest    ',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          String output2 = await fun(2);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Predict(abcd: output2.toString())));
                          output2 == "It is not suitable for Drinking"
                              ? player.play(AssetSource('notdrinkaudio.mp3'))
                              : player.play(AssetSource('drinkaudio.mp3'));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade500)),
                        child: Text(
                          'Logistic Regression',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          String output3 = await fun(2);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Predict(abcd: output3.toString())));
                          output3 == "It is not suitable for Drinking"
                              ? player.play(AssetSource('notdrinkaudio.mp3'))
                              : player.play(AssetSource('drinkaudio.mp3'));
                        },
                      ),
                      // IconButton(
                      //     icon: Icon(
                      //       Icons.info_outline,
                      //     ),
                      //     onPressed: () {_launchURLBrowser();}
                      // )
                      // ElevatedButton(
                      //   onPressed: _launchURLBrowser,
                      //   style: ButtonStyle(
                      //     padding:
                      //     MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                      //     textStyle: MaterialStateProperty.all(
                      //       const TextStyle(color: Colors.black),
                      //     ),
                      //   ),
                      //   // textColor: Colors.black,
                      //   // padding: const EdgeInsets.all(5.0),
                      //   child: const Text('Open in Browser'),
                      // ),
                    ],
                  ),
                ),
              )),
            ));
  }
}
