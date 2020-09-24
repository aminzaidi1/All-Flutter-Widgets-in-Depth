import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cats_vs_dogs/lib.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Image Classification',
                style: TextStyle(color: homeTextColor, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Detect Dogs and Cats',
              style: TextStyle(
                fontWeight: bold,
                fontSize: 28,
                color: splashTextColor,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
                child: _loading
                    ? Container(
                        width: 280,
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/cat.png'),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 250,
                              child: Image.file(_image),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _output != null
                                ? Text(
                                    '${_output[0]['label']}',
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  )
                                : Container(),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                          color: splashTextColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        'Take a Photo',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: pickGalleryImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: splashTextColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Camera Roll',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
