import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Acerca de la aplicacion",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: _listViewInfo(context));
  }

  _listViewInfo(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 50, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Worship fué desarrollada por",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
                Text("César Berrio",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Theme.of(context).primaryColor)),
                SizedBox(
                  height: 34,
                ),
                Container(
                  height: 160,
                  width: 115,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(1, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image: AssetImage('assets/img/dev.png'),
                          fit: BoxFit.fill)),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Datos de contacto",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white),
              ),
              Text("clberrio4@gmail.com",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Theme.of(context).primaryColor)),
              Text("Toca el boton para contactarme",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white)),
              Text("medio de Whatsapp",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white)),
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 54,
                width: media.width * 0.54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    shadowColor: Theme.of(context).accentColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: _handleWhatsapp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("314 621 3099",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.send_rounded)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("version",
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("1. 2. 1",
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Theme.of(context).primaryColor, fontSize: 20)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  void _handleWhatsapp() {
    FlutterOpenWhatsapp.sendSingleMessage("+573146213099",
        "*Hola César, ¿Como estas?.* ```Te estoy escribiendo desde Worship app```");
  }
}
