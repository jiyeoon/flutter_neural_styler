import 'package:flutter/material.dart';
import 'package:neural_styler/detailpage.dart';
import 'package:neural_styler/image_model.dart';


class TheStyle extends StatelessWidget {
  final ImageModel _imagemodel;

  TheStyle(this._imagemodel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(_imagemodel)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_imagemodel.extraction_image),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(child: Text(_imagemodel.painter_name, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),)),
      ),
    );
  }
}
