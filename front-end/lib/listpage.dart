import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neural_styler/detailpage.dart';
import 'package:neural_styler/image_model.dart';
import 'package:neural_styler/thestyle.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override

  final List<ImageModel> _imagelist = [
    ImageModel(1, "Van Gogh", "images/vangogh.jpg", null),
    ImageModel(2, "Claude Monet", "images/mone.jpg", null),
    ImageModel(3, "Paul Cezanne", "images/paulcezanne.jpg", null),
    ImageModel(4, "Egon Schiele", "images/egonschiele.jpg", null),
    ImageModel(5, "Picasso", "images/picasso.jpg", null),
    ImageModel(6, "Botticelli", "images/botticelli.jpeg", null),
    ImageModel(7, "Byeon Gwansik", "images/byeongwansik.jpeg", null),
    ImageModel(8, "Chang Ukjin", "images/chang_ukjin.jpeg", null),
    ImageModel(9, "Delacroix", "images/delacroix.jpeg", null),
    ImageModel(10, "Edvard Monk", "images/edvardmonk.jpeg", null),
    ImageModel(11, "Georges Seurant", "images/georges_seurat.jpeg", null),
    ImageModel(12, "Gustav Klimt", "images/gustav_klimt.jpeg", null),
    ImageModel(13, "Jacques Louis David", "images/jacques_louis_david.jpeg", null),
    ImageModel(14, "Jan Van Eyck", "images/jan_van_eyck.jpeg", null),
    ImageModel(15, "Jean Honore fragnard", "images/jean_honore_fragnard.jpeg", null),
    ImageModel(16, "Lee Jungseop", "images/lee_jungseop.jpeg", null),
    ImageModel(17, "Leonardo Davinci", "images/leonardodavinci.jpeg", null),
    ImageModel(18, "Leonidafremov", "images/leonidafremov.jpeg", null),
    ImageModel(19, "Michelangelo", "images/michelangelo.jpeg", null),
    ImageModel(20, "Oh Jiho", "images/oh_jiho.jpeg", null),
    ImageModel(21, "Park Sugeun", "images/parksugeun.jpeg", null),
    ImageModel(22, "Salvador Dali", "images/salvador_dali.jpeg", null),
    ImageModel(23, "Spring", "images/spring.jpeg", null),
    ImageModel(24, "Summer", "images/summer.jpeg", null),
    ImageModel(25, "Autumn", "images/autumn.jpeg", null),
    ImageModel(26, "Winter", "images/winter.jpeg", null),
    ImageModel(27, "神奈川沖浪裏", "images/wave_unknown.jpeg", null)
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 70.0, width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: null,),//Icon(Icons.add_a_photo, color: Colors.blueAccent),
            onPressed: (){
              _getImage();
            },
            backgroundColor: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Neural Styler', style: TextStyle(fontSize: 20),),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: _imagelist.map((_imagemodel)=>TheStyle(_imagemodel)).toList(),
    );
  }

  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    ImageModel create_image = ImageModel(0, "Custom Image", image.path, null);

    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(create_image)));

  }
}
