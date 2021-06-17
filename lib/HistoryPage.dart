import 'package:flutter/material.dart';
import 'package:textlooptool/DMHelper.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DBHelper helper;
  @override
  void initState() {
    helper = DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "History",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.clear_all,
                color: Colors.black,
              ),
              onPressed: () async {
                setState(() {
                  helper.clear();
                });
              })
        ],
      ),
      body: FutureBuilder(
        future: helper.allItems(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.yellow)),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        "${snapshot.data[index]['word']}",
                        style: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${snapshot.data[index]['number'].toString()}",
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            helper.delete(snapshot.data[index]['id']);
                          });
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.yellow,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
