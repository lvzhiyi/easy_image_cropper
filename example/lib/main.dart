import 'dart:ffi';
import 'dart:io';
import 'dart:async';

import 'package:easy_avator_cropper/easy_avator_cropper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum SheetType { gallery, camera }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "crop_page": (context) => const SimpleCropRoute(),
        "/": (context) => const MyHomeRoute()
      },
    );
  }
}

class MyHomeRoute extends StatefulWidget {
  const MyHomeRoute({super.key});

  @override
  MyHomeRouteState createState() => MyHomeRouteState();
}

class MyHomeRouteState extends State<MyHomeRoute> {
  final cropKey = GlobalKey<ImgCropState>();
  final _picker = ImagePicker();

  Future getImage(type) async {
    var image = await _picker.pickImage(
        source: type == SheetType.gallery
            ? ImageSource.gallery
            : ImageSource.camera);
    if (image == null) return;
    // Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamed('crop_page', arguments: {'image': image});
  }

  void _showActionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min, // 设置最小的弹出
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text("photo camera"),
                  onTap: () async {
                    getImage(SheetType.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("photo library"),
                  onTap: () async {
                    getImage(SheetType.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select image'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showActionSheet,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SimpleCropRoute extends StatefulWidget {
  const SimpleCropRoute({super.key});

  @override
  SimpleCropRouteState createState() => SimpleCropRouteState();
}

class SimpleCropRouteState extends State<SimpleCropRoute> {
  final cropKey = GlobalKey<ImgCropState>();

  Future<Null> showImage(BuildContext context, File file) async {
    return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'Current screenshot：',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1.1),
              ),
              content: Image.file(file));
        });
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)!.settings.arguments;
    XFile img = args['image'];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Zoom and Crop',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.navigate_before,
                color: Colors.black, size: 40),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: ImgCrop(
            key: cropKey,
            chipShape: ChipShape.circle,
            maximumScale: 1,
            image: FileImage(File(img.path)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final crop = cropKey.currentState;
            final croppedFile =
                await crop!.cropCompleted(File(img.path), pictureQuality: 900);
            // ignore: use_build_context_synchronously
            showImage(context, croppedFile);
          },
          tooltip: 'Increment',
          child: const Text('Crop'),
        ));
  }
}
