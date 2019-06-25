import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nerual Styler', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Upload image that you want to repaint.\nWe can make your image to Gogh\'s style.')),
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 8.0),),
        RaisedButton(
          child: _image == null ? Image.asset('images/no_image.png') : Image.file(_image),
          onPressed: _getimage,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: RaisedButton(
              onPressed: _upload,
              child: Text('Send Image to convert'),
            ),
          ),
        )
      ],
    );
  }

  Future _getimage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future _upload() async{
    File imageFile = _image;
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://172.26.24.240:8000/style_transfer/form/");       //add
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path)
    );

    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value){
      print(value);
    });
  }

}
