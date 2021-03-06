import 'package:flutter/material.dart';
import 'package:newtotolist/Homepages/Homepage_Diario.dart';

class PasswordChangedSuccessfully extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: passwordChangedSuccessfully(),
    );
  }
}

class passwordChangedSuccessfully extends StatefulWidget {
  @override
  _passwordChangedSuccessfullyState createState() =>
      _passwordChangedSuccessfullyState();
}

class _passwordChangedSuccessfullyState
    extends State<passwordChangedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/image/success.png"))),
          ),
          Text(
            "Exitoso!",
            style: TextStyle(fontSize: 35),
          ),
          Text(
            "Ha cambiado con éxito su contraseña.!",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 70,
          ),
          Center(
            child: InkWell(
              onTap: openHomePage,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color.fromARGB(255, 243, 182, 15)),
                child: Text(
                  "Continuar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage_Diario()));
  }
}
