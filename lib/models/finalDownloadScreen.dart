import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//this is to access the folder where the images are going to be downloaded and access them and showing them as list here i have used card

final Directory _photoDir = Directory(
    '/storage/emulated/0/Android/data/com.pratishodhi.aveosoft_demo/files');

class MyImageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyImageList(); //create state
  }
}

class _MyImageList extends State<MyImageList> {
  @override
  void initState() {
    //call getFiles() function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Downloaded"),
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Center(
            child: Text(
              "All Downloaded images should appear here",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList(growable: false);
      setState(() {});

      if (imageList.length > 0) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Downloaded"),
          ),
          body: Container(
            padding: EdgeInsets.only(bottom: 40.0),
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                String imgPath = imageList[index];
                return Card(
                  elevation: 8.0,
                  child: ListTile(
                    title: Text(imageList[index].split('/').last),
                    leading: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: imgPath,
                          child: Image.file(
                            File(imgPath),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    trailing: Icon(Icons.check_circle),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text("Downloaded images"),
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Text(
                "There are no images here : ) ",
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
        );
      }
    }
  }
}
