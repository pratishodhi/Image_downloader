import 'package:aveosoft_demo/models/firebasefile.dart';
import 'package:aveosoft_demo/models/firebaseAPI.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        /*actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseApi.downloadFile(file.ref);

              final snackBar = SnackBar(
                content: Text('Downloaded ${file.name}'),
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],*/
      ),
      body: isImage
          ? Image.network(
        file.url,
        height: double.infinity,
        fit: BoxFit.fitWidth,
      )
          : Center(
        child: Text(
          'Cannot be displayed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}