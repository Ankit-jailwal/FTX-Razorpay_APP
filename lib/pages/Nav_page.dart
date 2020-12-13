import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/main.dart';
import 'package:ieeecrop/second_screen.dart';
import 'package:ieeecrop/pages/Sell_now.dart';
import 'package:ieeecrop/pages/Rent_now.dart';
import 'package:ieeecrop/services/authentication-service.dart';

import '../Functions_and_route.dart';


class nav_page extends StatelessWidget {
  Items item1 = new Items(
    title: "Buy",
    subtitle: "",
    img: "assets/buy.png",
    page:"buy",  );

  Items item2 = new Items(
    title: "Sell",
    subtitle: "",
    img: "assets/commission.png",
    page:"sell",
  );
  Items item3 = new Items(
    title: "rent",
    subtitle: "",
    img: "assets/rent.png",
    page:"rent",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3];
    return Container(
        child: FutureBuilder(
          future: AuthenticationService().login(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(), //Circular progress indicator
              );
            } else if (snapshot.data['token'] != null) {
              print(snapshot.data);
              var rest = snapshot.data['token'] as String;
              storage.write(
                  key: "jwt", value: rest); //Storing token in local storage
              return SafeArea(
                child: Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 150,),
                        Container(height:100,child: Image.asset("assets/images/Maati_high.png")),
                        Text("Welcome to IEEE MAATI",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: Colors.green.withOpacity(0.8),fontFamily: "Anton"),),
                        SizedBox(height: 50,),
                        Text("Do you want to Shop or Sell?",style: TextStyle(fontSize:24,fontWeight: FontWeight.w700,fontFamily: "Roberto"),),
                    SizedBox(height: 20,),
                    Flexible(
                      child: GridView.count(
                          childAspectRatio: 1.0,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          crossAxisCount: 3,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          children: myList.map((data) {
                            return GestureDetector(
                              onTap: () async{
                                HapticFeedback.selectionClick();
                                print("tapped");
                                if(data.page=="buy") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => mainpage()),
                                  );
                                }

                                else if(data.page=="sell") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Sell_now()),
                                  );
                                }
                                else if(data.page=="rent")
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Rent_now()),
                                  );
                                }

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.6), borderRadius: BorderRadius.circular(10),),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      data.img,
                                      width: 42,
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Text(
                                      data.title,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return NetworkGiffyDialog(
                image: Image.network(
                  "https://media.giphy.com/media/l4pLY0zySvluEvr0c/giphy.gif",
                  fit: BoxFit.cover,
                ),
                entryAnimation: EntryAnimation.TOP_LEFT,
                title: Text(
                  translations.text('login.er'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  translations.text('login.des'),
                  textAlign: TextAlign.center,
                ),
                onlyOkButton: true,
                onOkButtonPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          },
        ));
  }
}
class Items {
  String title;
  String subtitle;
  String page;
  String img;
  Items({this.title, this.subtitle, this.page, this.img});
}

