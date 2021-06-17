import 'package:flutter/material.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/services.dart';
import 'package:textlooptool/DMHelper.dart';
import 'package:textlooptool/HistoryPage.dart';
import 'package:textlooptool/Models/Item.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBHelper helper;
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController wordcontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  String output = "";
  int number;
  String input;
  String theFinalOutput;
  @override
  void initState() {
    helper = DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          "Text Loop Tool",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return HistoryPage();
                },
              ));
            },
          )
        ],
      ),
      body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.6,
                        child: TextFormField(
                          style: TextStyle(color: Colors.yellow),
                          controller: wordcontroller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'value required';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Input text',
                              hintStyle: TextStyle(
                                  color: Colors.yellow.withOpacity(.5)),
                              labelStyle: TextStyle(color: Colors.yellow),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.orange)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.yellow)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.orange))),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.yellow),
                          controller: numbercontroller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'value required';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Input number',
                              hintStyle: TextStyle(
                                  color: Colors.yellow.withOpacity(.5)),
                              labelStyle: TextStyle(color: Colors.yellow),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.orange)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.yellow)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.orange))),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * 0.4,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.4,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 1, color: Colors.yellow),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                theFinalOutput == null
                                    ? "the out put will be here"
                                    : '$theFinalOutput',
                                style: TextStyle(color: Colors.yellow),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.copy,
                                color: Colors.yellow,
                              ),
                              onPressed: () {
                                ClipboardManager.copyToClipBoard(output)
                                    .then((value) {
                                  if (value) {
                                    scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Copied to clipboard")));
                                  } else {
                                    scaffoldKey.currentState.showSnackBar(
                                        SnackBar(content: Text("Cannot Copy")));
                                  }
                                });
                              },
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                if (formkey.currentState.validate()) {
                                  output = "";
                                  number = int.parse(numbercontroller.text);
                                  input = wordcontroller.text;
                                  for (int i = 0; i < number; i++) {
                                    output = output + " " + input;
                                  }
                                  setState(() {
                                    theFinalOutput = output;
                                  });
                                  addToDatabase();
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: RaisedButton(
                              child: Text(
                                "Reset",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                setState(() {
                                  numbercontroller.clear();
                                  wordcontroller.clear();
                                  theFinalOutput = null;
                                });
                              },
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  void addToDatabase() async {
    Item item = Item({'word': input, 'number': number});
    int id = await helper.createItem(item);
    print("id = $id");
  }
}
