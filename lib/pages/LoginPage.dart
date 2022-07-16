import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newtotolist/Homepages/Homepage_Diario.dart';
import 'package:newtotolist/Onboarding.dart';
import 'package:newtotolist/pages/Homepage.dart';
import 'package:newtotolist/widgets/toast.dart';
import 'package:newtotolist/widgets/validator.dart';
import '../Forgotpassword.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'avenir'),
      home: loginPage(),
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  bool isHiddenPassword =true ;
  final _formKey = GlobalKey<FormState>();  
  TextEditingController _correocontroller = TextEditingController();
  TextEditingController _contracontroller = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                  Onboarding()));
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Bienvenido de nuevo!",
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  "Inicie sesion para continuar...",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Correo",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                TextFormField(
                  validator: validateEmail,
                  controller: _correocontroller,
                  decoration: InputDecoration(
                    hintText: "Aqui tu correo"),
                      style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Contraseña",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                TextFormField(
                  obscureText: isHiddenPassword,
                  validator: validatecontra,
                  controller: _contracontroller,
                  decoration: InputDecoration(
                    hintText: "Aqui tu contraseña",
                    suffix: IconButton(
                      onPressed: (){
                          setState(() {
                            isHiddenPassword =! isHiddenPassword;
                          });
                      }, 
                      icon: Icon(Icons.remove_red_eye))),
                  style: TextStyle(fontSize: 20),
                  
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: openForgotPassword,
                      child: Text(
                        "¿Olvide la contraseña?",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 80,),
                Center(
                  child: Container(
                    width: double.infinity,
                      child: Align(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                              signIn2(
                                correo: _correocontroller.text,
                                contrasena: _contracontroller.text
                              );
                          },
                          backgroundColor: Color.fromARGB(255, 243, 182, 15),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                          label: Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Center(
                              child: Text(
                                "Iniciar sesion",
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
        ),
      ),
    );
  }
  void _togglePassword(){
    if(isHiddenPassword == true){
      isHiddenPassword =false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {
      
    });
  }
  Future<String?> signIn2({ required String correo, required String contrasena}) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: correo, password: contrasena)
            .then((uid) => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Homepage())),
                });
      } on FirebaseAuthException catch (e){
        print(e);
        loginErrortoast();
                        
                          
      }
  }

} 

  void openForgotPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  }
}

