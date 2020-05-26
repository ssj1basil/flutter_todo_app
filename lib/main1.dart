import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/save.dart';


//Scroll down to read_file function 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todoitems = [];
  List Cards = [];
  int index = 1;

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < todoitems.length) {
          return _buildTodoItem(todoitems[index], index);
        }
        return null;
      },
    );
  }

  void _removeTodoItem(int index) {
    setState(() => todoitems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${todoitems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  Widget _buildTodoItem(String todotext, int index) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      color: Colors.grey,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(
            "$todotext",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onLongPress: () {
            _promptRemoveTodoItem(index);
          },
        ),
      ),
    );
  }


//This is where the problem is i can retrieve string from save.dart but when i return data, it's returning as null

  String read_file(AppState content) {
    String data;
    print('sucesfully called');
    content.readContent().then((String onValue) {
      setState(() {
        print('sucessfully retrieved' + onValue);
        data = onValue;
        print('sucessfully copied' + data);
      });
    });

    return data;
  }

  void showalertdialog() {
    final myController = TextEditingController();
    AppState contents = new AppState();
    String temp;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text("Add Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: myController,
                    autofocus: false,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(),
                            color: Colors.purple,
                            onPressed: () {
                              setState(() {
                                contents.writeContent(myController.text);
                                temp = read_file(contents);
                                todoitems.add(temp);
                              });
                            },
                            child: Text("ADD"),
                          ))
                    ],
                  )
                ],
              ),
            ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "To D List",
          style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: _buildTodoList(),
      /*SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_buildTodoList()],
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: showalertdialog,
        tooltip: 'Add task',
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
