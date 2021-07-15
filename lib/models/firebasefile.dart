import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseFile{
  final Reference ref;
  final String name;
  final String url;
   var isDownloaded = false;

   FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
     this.isDownloaded = false,
});
}