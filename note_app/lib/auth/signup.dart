// ignore_for_file: unused_local_variable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
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
                      controller: username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Enter Your Username",
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
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter Your Email",
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
                        hintText: "Enter Your passmord",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)
                        ),
                        
                      ),
                    ),

                    SizedBox(height: 25,),

                    Container(
                      child: Row(
                        children: [
                          Text("If You have account"),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushReplacementNamed("login");
                            },
                            child: Text("Click here",
                            style: TextStyle(color: Color.fromARGB(255, 32, 141, 125)),
                            ),
                          )
                        ],),
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
                                final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );
                                FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                if(FirebaseAuth.instance.currentUser!.emailVerified){
                                  Navigator.of(context).pushNamedAndRemoveUntil("homepage",(Route<dynamic> route) => false,);
                                }
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: 'first virify your email by clicking on the link in your email..',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                    )..show();

                                
                                 
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                    AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: 'The password provided is too weak...',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                    )..show();
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'The account already exists for that email....',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                  )..show();
                                  print('The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
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
                        child: Text("SignUP",
                         style: TextStyle(fontSize: 25,color: Colors.black)
                        // style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      

                  ], 
                ),
              ),
            ),
          ]
        )
      )
       
      );
  }
}