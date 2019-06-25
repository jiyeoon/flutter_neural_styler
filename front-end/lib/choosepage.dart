import 'package:flutter/material.dart';
import 'package:neural_styler/vangogh.dart';

class ChoosePage extends StatefulWidget {
  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  TextStyle font_style = TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neural Styler', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10),),
          Center(child: Text('Chosse the style you want', style: TextStyle(fontSize: 15,))),
          Padding(padding: EdgeInsets.all(8),),
          ///////////////////////line 1//////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VanGoghPage()));
                        },
                        child: Image.asset('images/vangogh.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>VanGoghPage()));},
                        child: Center(child: Text('Van Gogh', style: font_style))
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Image.asset('images/mone.jpg', fit: BoxFit.cover,)),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                        onTap: (){},
                        child: Center(child: Text('MONE', style: font_style) )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ///////////////////////line 2//////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Image.asset('images/paulcezanne.jpg', fit: BoxFit.cover,)),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: Center(child: Text('Paul\nCezanne', style: font_style) ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Image.asset('images/egonschiele.jpg', fit: BoxFit.cover,)),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: Center(child: Text('Egon\nSchiele', style: font_style) ),
                    ),
                  ],
                ),
              )
            ],
          ),
          ///////////////////////line 3//////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => VanGoghPage()));
                        },
                        child: Image.asset('images/picasso.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>VanGoghPage()));
                            },
                          child: Center(child: Text('Picasso', style: font_style))
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Image.asset('images/delacroix.jpeg', fit: BoxFit.cover,)),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Center(child: Text('Delacroix', style: font_style) )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ///////////////////////line 4//////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => VanGoghPage()));
                        },
                        child: Image.asset('images/botticelli.jpeg', fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>VanGoghPage()));
                           },
                          child: Center(child: Text('Botticelli', style: font_style))
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Image.asset('images/byeongwansik.jpeg', fit: BoxFit.cover,)),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Center(child: Text('Byeon\nGwansik', style: font_style) )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ///////////////////////line 5//////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => VanGoghPage()));
                        },
                        child: Image.asset('images/chang_ukjin.jpeg', fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>VanGoghPage()));
                          },
                          child: Center(child: Text('Chang\nUkjin', style: font_style))
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Image.asset('images/edvardmonk.jpeg', fit: BoxFit.cover,)),
                    ),
                    SizedBox(
                      width: 170, height: 150,
                      child: GestureDetector(
                          onTap: (){},
                          child: Center(child: Text('Edvard\nMonk', style: font_style) )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  

}
