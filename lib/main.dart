import 'package:flutter/material.dart';
import 'package:jobswipe/ContentApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;
import 'package:awesome_dialog/awesome_dialog.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String url = "https://remoteok.io/api";

Future<List<ContentApi>?> _gonderiGetir() async {
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> decoded = json.decode(response.body);
    return decoded.skip(1).map((e) => ContentApi.fromJson(e)).toList();
  } else {
    throw Exception("Baglanamadık ${response.statusCode}");
  }
}

final fifteenAgo = new DateTime.now();


  }
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: (text) {setState(() {
              });},
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Container(
            child: FutureBuilder(
                future: _gonderiGetir(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ContentApi>?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: (){AwesomeDialog(
                              context: context,
                              dialogType: DialogType.NO_HEADER,
                              animType: AnimType.BOTTOMSLIDE,
                              title: '${snapshot.data![index].position}',
                              desc: '${snapshot.data![index].description}',
                              btnOkOnPress: () {},
                            )..show();},
                            title: Text(snapshot.data![index].position),
                            subtitle: Text(snapshot.data![index].location),
                            leading: CircleAvatar(
                              child: Image.network(
                                  snapshot.data![index].logo.toString()),
                            ),
                            trailing: Text(
                              timeago.format(DateTime.parse(snapshot.data![index].date), locale: 'tr',),
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
