import 'dart:convert';

import 'package:apitutorial2/model/photosmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PhotosModel> photoList = [];

  Future<List<PhotosModel>> getPhotosApi() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        PhotosModel pM = PhotosModel(title: i["title"], url: i["url"]);
        photoList.add(pM);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: getPhotosApi(),
                builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: photoList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data![index].url.toString())),
                              subtitle:
                                  Text(snapshot.data![index].title.toString()),
                              title:
                                  Text(snapshot.data![index].title.toString()));
                        }),
                  );
                })
          ],
        ));
  }
}
