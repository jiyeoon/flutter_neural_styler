import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neural_styler/image_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DetailPage extends StatefulWidget {
  final ImageModel _imagemodel;
  DetailPage(this._imagemodel);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  File _image;
  File _transferedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget._imagemodel.painter_name} Style'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10),),
        Stack(
          children: <Widget>[
            SizedBox(
              width: 300, height: 250,
              child: Image.asset(widget._imagemodel.extraction_image, fit: BoxFit.cover,),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 30),
              child: GestureDetector(
                onTap: _getImage,
                child: SizedBox(
                    width: 300, height: 250,
                    child: _image == null ?
                    SizedBox(width: 300, height: 250, child: RaisedButton(color: Colors.white54, onPressed: _getImage, child: Text('No image', style: TextStyle(color: Colors.grey[50], fontSize: 30),),),) :
                    Image.file(_image, fit: BoxFit.cover,)
                ),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(10),),
        Center(child: RaisedButton.icon(
            onPressed: _upload,
            icon: Icon(Icons.send),
            label: Text('Send this Image to change')),
        ),
        _transferedImage == null ? Text('no transfered image') : Image.file(_transferedImage),
      ],
    );
  }

  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  //인우오빠 IP : 172.26.24.240
  Future _upload() async{
    File imageFile = _image;
    Dio dio = new Dio();

    String extractionpath = '/Users/leejiyeon/AndroidStudioProjects/neural_styler/${widget._imagemodel.extraction_image}';
    File extractionImage = new File(extractionpath);

    if(imageFile==null) return;
    if(_transferedImage!=null) {
      _transferedImage = null;
    }
    else{
      
    }

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var stream2 = new http.ByteStream(DelegatingStream.typed(extractionImage.openRead()));

    var length = await imageFile.length();
    var length2 = await extractionImage.length();

    var uri = Uri.parse("http://172.26.24.240:8000/style_transfer/form/");       //add
    var request = new http.MultipartRequest("POST", uri);

    var multipartFile1 = new http.MultipartFile('content_image', stream, length,
        filename: basename(imageFile.path)
    );
    var multipartFile2 = new http.MultipartFile('style_image', stream2, length2,
      filename: basename(extractionImage.path),
    );

    request.fields['id'] = '1000';
    request.files.add(multipartFile1);
    request.files.add(multipartFile2);
    request.fields['content_weight'] = '5';
    request.fields['style_weight'] = '10000';

    /*
    * 디폴트 가중치
    * 컴텐트 5
    * 스타일 10000
    * */

    var response = await request.send();

    print(response.statusCode);

    var responsebody1 = await response.stream.transform(utf8.decoder);
    print(" @@@@@@@@@@@@@@@@@Response Body1 : ${responsebody1}");

    final dictionary = await getApplicationDocumentsDirectory();
    print(dictionary.path);

    final _receivedimage = new File('${dictionary.path}/receivedimage.jpg');
    var sink = _receivedimage.openWrite();
    await sink.addStream(response.stream);
    await sink.close();

    setState(() {
      _transferedImage = _receivedimage;
    });

  }
}