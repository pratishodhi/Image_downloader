import 'package:aveosoft_demo/models/firebasefile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

//changing files values as list
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url, isDownloaded: false);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }
//function to download image and saving it in local storage
 static Future downloadFile(Reference ref) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          final file = File('${directory.path}/${ref.name}');
          await ref.writeToFile(file);

          print(ref.name);

          print(ref.getDownloadURL());
          print(file);


          print(directory.path);
        } else {
          return false;
        }
      }
    } catch (e) {}

  }
//managing permission from android whther is granted or not
  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
