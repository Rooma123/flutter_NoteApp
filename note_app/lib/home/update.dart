import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  final String docid;
  final String oldname;
  const Update({super.key, required this.docid, required this.oldname});

  @override
  State<Update> createState() => _CatigoryState();
}

class _CatigoryState extends State<Update> {

  
  TextEditingController name = new TextEditingController();
  GlobalKey<FormState>formstate = new GlobalKey<FormState>();

  CollectionReference catigories = FirebaseFirestore.instance.collection('catigories');


Future<void> UpdateCatigory(BuildContext context) async {
  try {
    // Call the user's CollectionReference to add a new category
    await catigories.doc(widget.docid).update({
      'name':name.text
  });
    
    // Show success dialog or message
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: 'Category added successfully!',
      btnOkOnPress: () {
        // Navigate to the homepage after adding the category
        Navigator.of(context).pushNamedAndRemoveUntil("homepage", (Route<dynamic> route) => false);
      },
    ).show();
  } catch (error) {
    // Show error dialog if there was a failure
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: 'Failed to add category: $error',
      btnOkOnPress: () {},
    ).show();
  }
}

@override
  void initState() {
    super.initState();
    name.text=widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: formstate,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Container(
                child: 
                 TextFormField(
                       validator: (value) {
                          if (value == null || value.length < 2) {
                            return "Not valid";
                          }
                          return null;
                        },
                      controller:name ,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.folder),
                        hintText: "Enter the name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)
                        ),
                        
                      ),
                    ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                UpdateCatigory(context);
              }, 
              style: ElevatedButton.styleFrom(
                          backgroundColor:Color.fromARGB(255, 32, 141, 125) ,
                          
                              shape: RoundedRectangleBorder(
                                side:BorderSide(width: 2,color: Color.fromARGB(255, 39, 126, 117)),
                                  borderRadius: BorderRadius.circular(0), 
                            ),
                            ),
                        child: Text(" Save",
                         style: TextStyle(fontSize: 25,color: Colors.black)
                        // style: Theme.of(context).textTheme.bodyMedium,
                          ),)
            ],
          ),),
      ),
    );
  }
}