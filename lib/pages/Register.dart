import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newtotolist/pages/LoginPage.dart';
import 'package:newtotolist/models/ModeloUsuarios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newtotolist/Onboarding.dart';
import 'package:newtotolist/pages/Homepage.dart';
import 'package:newtotolist/widgets/toast.dart';

import '../Homepages/Homepage_Diario.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {

ModeloUsuarios modeloUsuarios= ModeloUsuarios();

  bool nosepuedever =true ;
  bool cargando = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _nombrecontroller = TextEditingController();
  final TextEditingController _contrasenacontroller = TextEditingController();

  Future signUp( String email, String password,) async {
    setState(()=> cargando = true);
    if (_nombrecontroller.text  !=  "") {
      try {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _contrasenacontroller.text.trim(),
        );

        Firestoreposteo();
      } on FirebaseAuthException catch (e) {
        print(e);
        return registerErrortoast();
      }
      
    } else{
      registernombreErrrotoast();
    }
    setState(()=> cargando = false);
    //agrega el usuario
  }

  Future Firestoreposteo() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    ModeloUsuarios modeloUsuarios = ModeloUsuarios();

    modeloUsuarios.nombre = _nombrecontroller.text;
    modeloUsuarios.contrasena = _contrasenacontroller.text;
    modeloUsuarios.correo = _emailcontroller.text;
    modeloUsuarios.uid = user!.uid;

    await firebaseFirestore
        .collection("Usuarios")
        .doc(user.uid)
        .set(modeloUsuarios.toMap());
    //
    openOnboardinPage();
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
           onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
              SizedBox(height: 80,),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Text(
                "¿Nuevo por aqui?",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Text(
                "Crea una cuenta ahora para ingresar!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            SizedBox( height: 20,),
            
            SafeArea(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: size.width*0.9,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(28)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _nombrecontroller,
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              hintText: "Usuario",
                              hintStyle: TextStyle(color: Colors.black54), 
                              prefixIcon:  Icon(Icons.person, size: 30, color: Colors.yellow[800],)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,), 
                    Container(
                      height: 60,
                      width: size.width*0.9,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(28)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Correo',
                              hintStyle: TextStyle(color: Colors.black54), 
                              prefixIcon:  Icon(Icons.email, size: 30, color: Colors.yellow[800])),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 60,
                      width: size.width*0.9,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(28)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            obscureText: nosepuedever,
                            controller: _contrasenacontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contraseña",
                              hintStyle: TextStyle(color: Colors.black54), 
                              prefixIcon:  Icon(Icons.password, size: 30, color: Colors.yellow[800]),
                              
                              suffixIcon: nosepuedever==true? IconButton(
                                onPressed:_togglePassword,
                              icon: Icon(Icons.visibility_off,))
                              :IconButton(
                                onPressed:_togglePassword,
                              icon: Icon(Icons.visibility,))),
                            ),
                        ),
                      ),
                      ),
                  SizedBox(height: 40,),
                  Center(
                  child: Container(
                    width: size.width*0.8,
                      child: Align(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            signUp(_emailcontroller.text, _contrasenacontroller.text);
                          },
                          backgroundColor: Color.fromARGB(255, 243, 182, 15),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                          label: cargando? Container(child:CircularProgressIndicator(color: Colors.lightGreen,) , height: 20, width: 20,) 
                          :Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: 
                             Center(
                              child: Text(
                                "Registrame",
                                style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2.2,
                                color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }  
  
  void _togglePassword(){
    if(nosepuedever == true){
      nosepuedever =false;
    } else {
      nosepuedever = true;
    }
    setState(() {
    });
  }




  openOnboardinPage() {
   Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Homepage(),
        ),
        (route) => false,//if you want to disable back feature set to false

    );
  }
}
