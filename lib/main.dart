import 'package:aveosoft_demo/models/finalDownloadScreen.dart';
import 'package:aveosoft_demo/models/firebaseAPI.dart';
import 'package:aveosoft_demo/models/firebasefile.dart';
import 'package:aveosoft_demo/models/images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Images';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MainPage(),
    ); /*);*/
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApi.listAll('images/');
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          actions: [                     //download icon on right top for accessing app download file
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) {
                  return MyImageList();
                }));
              },
            )
          ],
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: FutureBuilder<List<FirebaseFile>>(                       //accessing firebase images in storage while showing linear progress bar
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(child: LinearProgressIndicator()),
                );
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //buildHeader(files.length),
                      const SizedBox(height: 0),
                      Expanded(
                        child: GridView.builder(                                // to show images in a grid like structure
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 3),
                          padding: const EdgeInsets.all(5),
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];         //getting all images
                            return buildFile(context, file);
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      );

  Widget buildFile(BuildContext context, FirebaseFile file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImagePage(file: file),
            ));
          },
          child: Image.network(
            file.url,
            width: 70,
            height: 52,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
            leading: file.isDownloaded                 //checking whether file is downloaded or not to show respective icon on image hence used ternary operator
                ? IconButton(
                    icon: Icon(
                      Icons.check_circle_sharp,
                      color: Colors.white70,
                    ),
                    onPressed: () {})
                : IconButton(
                    icon: Icon(Icons.file_download),
                    color: Colors.white,
                    onPressed: () async {
                      Center(
                          child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                      ));
                      setState(() {});
                      await FirebaseApi.downloadFile(file.ref);
                      setState(() {
                        file.isDownloaded = true;
                      });

                      final snackBar = SnackBar(                                   //notifying that image has been downloaded
                        content: Text('Downloaded ${file.name}'),
                      );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  )),
      ),
    );
  }
}
