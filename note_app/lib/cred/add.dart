import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child:Column(
            children: [
              Form(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 224, 242, 241),
                      labelText: "write note's title",
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                     ),
                  ),
                  SizedBox(height: 20,),
                    TextFormField(

                      minLines: 5,
                      maxLines: 10,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 224, 242, 241),
                      labelText: "write note's title",
                      prefixIcon: Icon(Icons.note),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                     ),
                  ),
        
                  SizedBox(height: 35,),
        
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: (){
                        showBottomSheet(context);
                      }, 
                      style: ElevatedButton.styleFrom(
                              backgroundColor:Color.fromARGB(255, 32, 141, 125),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 30,
                        ),
                              
                                  shape: RoundedRectangleBorder(
                                    side:BorderSide(width: 2,color: Color.fromARGB(255, 39, 126, 117)),
                                      borderRadius: BorderRadius.circular(10), 
                                ),
                                ),
                                
                     icon: const Icon(Icons.image, color: Colors.black),
                     label: const Text(
                        "Add Image",
                      style: TextStyle(fontSize: 20,color: Colors.black)
                      )),
                  ),
                  SizedBox(height: 30,),
                  
                    Center(
                    child: ElevatedButton.icon(
                      onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                              backgroundColor:Color.fromARGB(255, 23, 150, 112),
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 100),
                              
                                  shape: RoundedRectangleBorder(
                                    side:BorderSide(width: 2,color: Color.fromARGB(255, 9, 129, 97)),
                                      borderRadius: BorderRadius.circular(10), 
                                ),
                                ),
                      icon: const Icon(Icons.note_add, color: Colors.black),
                      label: const Text(
                        "save Note",
                      style: TextStyle(fontSize: 30,color: Colors.black)
                      )),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

void showBottomSheet(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("choose the image",
          style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold) ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){},
                child: Column(
                  children: [
                      Icon(Icons.photo,size: 30,),
                    Text("from the galary",
                    style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              InkWell(
                onTap: (){},
                child: Column(
                  children: [
                    Icon(Icons.camera,size: 30,),
                    Text("from the camera",
                    style: TextStyle(fontSize: 20)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  });
}