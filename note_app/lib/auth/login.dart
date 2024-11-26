// ignore_for_file: unused_local_variable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:note_app/auth/signup.dart';
//import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  GlobalKey<FormState>formstate = new GlobalKey<FormState>();

  
Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if(googleUser == null){
    return;
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential);

  Navigator.of(context).pushNamedAndRemoveUntil("homepage",(Route<dynamic> route) => false,);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("images/note.png",
            cacheHeight: 250,cacheWidth: 250,)
            ),
            SizedBox(height: 25,),
        
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formstate,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    TextFormField(
                       validator: (value) {
                          if (value == null || value.length < 2) {
                            return "Not valid";
                          }
                          return null;
                        },
                      controller:email ,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Enter Your email",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)
                        ),
                        
                      ),
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      validator: (value) {
                          if (value == null || value.length < 2) {
                            return "Not valid";
                          }
                          return null;
                        },
                     controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: "Enter Your password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)
                        ),
                        
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: ()async{

                          if(email.text == ""){
                            return;
                            
                          }
                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error ',
                                  desc: 'first write your email....',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                  )..show();
                          try{        
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'Error ',
                                  desc: 'you can now change your password go to your Gmail....',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                  )..show();

                          }catch(e) {
                            AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error ',
                                  desc: 'The email is not correct try again....',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                  )..show();
                          }   
                        },
                        child: Text("Forget password ?"),
                        ),
                    ),

                    

                    SizedBox(height: 25,),

                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5)
                        ),
                      child: ElevatedButton(
                        onPressed: ()async{
                          try {
                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text
                                );
                                if(FirebaseAuth.instance.currentUser!.emailVerified){
                                  Navigator.of(context).pushNamedAndRemoveUntil("homepage",(Route<dynamic> route) => false,);
                                }
                                
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error ',
                                  desc: 'No user found for that email....',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                  )..show();
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error ',
                                  desc: 'Wrong password provided for that user..',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                  )..show();
                                  print('Wrong password provided for that user.');
                                }
                              }
                          //Navigator.of(context).pushReplacementNamed("homepage");
                          
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Color.fromARGB(255, 32, 141, 125) ,
                          
                              shape: RoundedRectangleBorder(
                                side:BorderSide(width: 2,color: Color.fromARGB(255, 39, 126, 117)),
                                  borderRadius: BorderRadius.circular(0), 
                            ),
                            ),
                        child: Text("Login",
                         style: TextStyle(fontSize: 25,color: Colors.black)
                        // style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      

                  ], 
                ),
              ),
            ),
            Container(
              child: Text("Or Login"),
            ),
            SizedBox(height: 15,),
            Container(
              height: 50,
              width: 50,
              child: InkWell(
                onTap: (){
                  signInWithGoogle();
                },
                child: Image.asset("images/google.jpg"),
              ),
            ),
            SizedBox(height: 25,),

                    Container(
                      child: Row(
                        children: [
                          Text("If You Don't have account"),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushReplacementNamed("signup");
                            },
                            child: Text("Click here",
                            style: TextStyle(color: Color.fromARGB(255, 32, 141, 125)),
                            ),
                          )
                        ],),
                    ),
          ]
        )
      )
       
      );
  }
}