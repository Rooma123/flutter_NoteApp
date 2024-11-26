import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home/update.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List notes = [
  //   {
  //     "note": "Sample note 1",
  //     "image": "OIF.jpeg"
  //   },
  //   {
  //     "note": "Sample note 2",
  //     "image": "OIF.jpeg"
  //   },
  //   {
  //     "note": "Sample note 3",
  //     "image": "OIF.jpeg"
  //   },
  //   {
  //     "note": "Sample note 4",
  //     "image": "OIF.jpeg"
  //   },
  //   {
  //     "note": "Sample note 5",
  //     "image": "OIF.jpeg"
  //   },
  //   {
  //     "note": "Sample note 6",
  //     "image": "OIF.jpeg"
  //   },
  // ];

  List notes = [];

  getData()async{
   QuerySnapshot querySnapshot= await FirebaseFirestore.instance
    .collection('catigories').where('id',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get();
    notes.addAll(querySnapshot.docs);
    setState(() {
      
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void delete (int i){
    setState(() {
      notes.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: Datasearch(notes));
            },
             icon: Icon(Icons.search)),

          IconButton(
            onPressed: ()async{
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
            }, 
            icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 32, 141, 125),
        onPressed: (){
          Navigator.of(context).pushNamed("catigory");
        },
        child: Icon(Icons.add),),
      // body: Column(
      //   children: [
      //     Container(
      //       margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
      //       //alignment: Alignment.center,
      //       child: ListView.builder(
      //         itemCount: notes.length,
      //         itemBuilder: (context,i){
      //           return Dismissible(key:Key("$i") , child: 
      //          ListNotes(
      //           notes: notes[i],
      //           delete : () => delete(i),
      //           )
      //           );
      //         }),
      //     ),
      //   ],
      // ),
      

// class ListNotes extends StatelessWidget {
//   const ListNotes({super.key, this.notes, required this.delete});


//   final VoidCallback delete;
//   final notes;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       margin: const EdgeInsets.only(bottom: 10),
//       child: InkWell(
//           onTap: (){},
//         child: Card(
//           child: ListTile(
//             title: Text("Title"),
//             subtitle: Text("${notes['note']}"),
//             //subtitle: IconButton(onPressed: (){},
//             //icon: Icon(Icons.delete),),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [ IconButton(onPressed: (){},
//             icon: Icon(Icons.edit),),
        
//             IconButton(onPressed: (){
//               delete();
//             },
//             icon: Icon(Icons.delete,color: Colors.red,),
//             ),
//             ],),
           
//             leading: Image.asset("images/note.png",fit: BoxFit.fill,),
//           ),
//         ),
//       ),
//     );
//   }
// }


body: GridView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () {
               AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Error ',
                                  desc: 'No user found for that email....',
                                  btnCancelText: "Delete",
                                  btnCancelOnPress: () async{
                                   await FirebaseFirestore.instance.collection('catigories').doc(notes[index].id).delete();
                                  },
                                  btnOkText: "update",
                                  btnOkOnPress: () async{
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context){
                                        return Update(docid: notes[index].id, oldname: notes[index]['name']);}),
                                        (Route<dynamic> route) => false,);
                                  },
                                  )..show();
                                  Navigator.of(context).pushNamedAndRemoveUntil("homepage",(Route<dynamic> route) => false,);
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Image.asset("images/folder.jpg"),
                    Text('${notes[index]['name']}')
                  ],
                )
                
              ),
            ),
          );
        } ,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),

    );
  }
}


class Datasearch extends SearchDelegate{
  final  List notes;
  Datasearch(this.notes);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: (){
        query="";
      },
       icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("$query");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      final filteredNotes = notes
      .where((note) => note['note']!.toLowerCase().contains(query.toLowerCase()))
      .toList();
    return ListView.builder(
      itemCount: query==""?notes.length:filteredNotes.length,
      itemBuilder: (context,i){
        return InkWell(
          onTap: (){
            query==""?notes[i]:filteredNotes[i];
            showResults(context);
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: query==""?Text("${notes[i]['note']}")
            :Text("${filteredNotes[i]['note']}"),
          ),
        );
      });

  }
}