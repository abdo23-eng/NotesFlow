import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/Note.dart';
import 'package:notes/pages/data.dart';
class Ideas extends StatefulWidget{
    final bool state; 
  final String query ;
  const Ideas({super.key, required this.state, required this.query}); 
  @override
  State<StatefulWidget> createState() {
   
    return IdeasState();
  }
}
class IdeasState extends State<Ideas>{

  Stream<QuerySnapshot> getNoteStream() {
    User? user1 = FirebaseAuth.instance.currentUser;
    String uid = user1!.uid;
 
    var fireStoreRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notes').where('categories' , arrayContains: "Ideas");
    return fireStoreRef.snapshots();
    }
  @override
  Widget build(BuildContext context) {
    
   return StreamBuilder(
        stream:  getNoteStream(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 241, 143, 142),
              ),
            );
          }
          List<NoteModel> allNotes = snapshot.data!.docs.map((doc) {
        return NoteModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();

      
      List<NoteModel> noteList = widget.query.isEmpty
          ? allNotes
          : allNotes.where((note) {
              return note.title.toLowerCase().contains(widget.query.toLowerCase());
            }).toList();
          if(!noteList.isEmpty){
          return Container(
            margin: EdgeInsets.only(top: 0),
            padding: EdgeInsets.all(0),
            // 2. استخدام MasonryGridView
            child: MasonryGridView.count(
              crossAxisCount: 2, // عدد الأعمدة (عمودين بجانب بعضهما)
              mainAxisSpacing: 12, // الفراغ العمودي بين الخلايا
              crossAxisSpacing: 12, // الفراغ الأفقي بين الخلايا
              itemCount: noteList.length, // عدد الملاحظات التجريبي
              itemBuilder: (context, index) {
                // هنا نمرر كارد الملاحظة، وكل كارد سيأخذ ارتفاعاً تلقائياً بحسب محتواه
                return InkWell(
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Data(
                          title: noteList[index].title,
                          note: noteList[index].content,
                          date: noteList[index].dateTime,
                          id: noteList[index].id!
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        233,
                        213,
                        182,
                      ), // لون خلفية الكارد
                      borderRadius: BorderRadius.circular(16.0),
                      border: BoxBorder.all(
                        width: 2.0,
                        color: const Color.fromARGB(255, 241, 143, 142),
                      ), // حواف دائرية للكارد
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noteList[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color.fromARGB(255, 124, 62, 58),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          noteList[index].content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 124, 62, 58),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          (noteList[index].dateTime).toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 202, 118, 117),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
          } 
          else{
            return Center(
              child: Text('Add some notes', style: TextStyle(
                fontSize: 20 , 
                fontWeight: FontWeight(500) ,
                color: const Color.fromARGB(255, 241, 143, 142)
              ),),
            );
          }
        },
      );
  }
}