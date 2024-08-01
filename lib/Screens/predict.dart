import 'package:flutter/material.dart';
import 'package:tutorial_2/Screens/home/home.dart';
import 'package:tutorial_2/shared/loading.dart';
class Predict extends StatelessWidget {
  // const Predict({Key? key}) : super(key: key);
  Text a1= Text('NOT SAFE',
    style: TextStyle(
      color: Colors.red,
        fontSize: 50,
        fontWeight: FontWeight.w500,
        fontFamily: 'Abril'
    ),
  );
  Text a2= Text('SAFE',
    style: TextStyle(
      color: Colors.green,
        fontSize: 50,
        fontWeight: FontWeight.w500,
        fontFamily: 'Abril'
    ),
  );
  Icon fg = Icon(Icons.block_outlined,size: 150,color: Colors.red,);
  Icon xg = Icon(Icons.check_circle,size: 150,color: Colors.green,);
  Row a =Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: 20,),
      Container(
        child: Image.asset(
          'assets/impure2.jpeg',
          width: 350.0,
          height: 250.0,
          fit: BoxFit.fill,
        ),
      ),
      SizedBox(width: 20,)
    ],
  );
  Row b= Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: 20,),
      Container(
        child: Image.asset(
          'assets/pure1.jpg',
          width: 350.0,
          height: 250.0,
          fit: BoxFit.fill,
        ),
      ),
      SizedBox(width: 20,)
    ],
  );
  String abcd;
  Predict({required this.abcd});
  late String bc;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            this.abcd=="It is not suitable for Drinking"?fg:xg,
            this.abcd=="It is not suitable for Drinking"?a1:a2,
            SizedBox(height: 20,),
            Text(
              this.abcd=="It is not suitable for Drinking" ? "Oooops! ${abcd}":"Hurray! ${abcd}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lora'),
            ),
            // Container(color: Colors.redAccent, height: 2),
            SizedBox(height: 70),
            this.abcd=="It is not suitable for Drinking"?a:b,
          ],
        ),
    );
  }
}


