import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class VanGoghPage extends StatefulWidget {
  @override
  _VanGoghPageState createState() => _VanGoghPageState();
}

class _VanGoghPageState extends State<VanGoghPage> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: 300, height: 250,
                  child: Image.asset('images/vangogh.jpg', fit: BoxFit.cover,),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, top: 30),
                  child: GestureDetector(
                    onTap: _getImage,
                    child: SizedBox(
                        width: 300, height: 250,
                        child: _image == null ?
                          SizedBox(width: 300, height: 250, child: RaisedButton(color: Colors.white54, onPressed: _getImage, child: Text('No image', style: TextStyle(color: Colors.white, fontSize: 30),),),) :
                          Image.file(_image, fit: BoxFit.cover,)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.send), label: Text('Sent this Image to change')),
      ],
    );
  }

  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}

