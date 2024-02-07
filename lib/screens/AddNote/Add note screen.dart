import 'package:dairy_app/models/note.dart';
import 'package:dairy_app/repositry/note%20repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/AppColors.dart';

class AddNote extends StatefulWidget{
  final Note? note;
const AddNote({super.key,this.note});

@override
State<AddNote> createState() => _AddNoteState();

}

class _AddNoteState  extends  State<AddNote>{
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
// update the node when clicked
  @override
  void initState(){
    if(widget.note != null){
      _title.text= widget.note!.title!;
      _description.text=widget.note!.description!;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(

       actions: [
         widget.note !=null?
         IconButton(onPressed:(){
           showDialog(context: context, builder: (context)=>AlertDialog(
             content: const Text("Are You sure  You want to delete this node ?"),

             actions: [
               TextButton(onPressed: (){
                 Navigator.pop(context);
               }, child: const Text('No'),
               ),
               TextButton(onPressed: (){
                 _deleteNote();
               }, child: const Text('Yes'),
               )
             ],

           )
           );

         }
         , icon: Icon(Icons.delete,size: 25,color: AppColors.secondaryColor,)):const SizedBox(),
         IconButton(onPressed: widget.note==null? _insertNote:_updateNote,
             icon: Icon(Icons.done_outline_rounded,size: 25,color: AppColors.secondaryColor,)),

       ],
       title:   Text(widget.note ==null?"Add Note":"Edit Note",style: GoogleFonts.anton(color: AppColors.secondaryColor,fontSize: 30.sp),),centerTitle: true,backgroundColor: Colors.black,leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back,size: 25,color: AppColors.secondaryColor,),),),
     body: Padding(
       padding: const EdgeInsets.all(15.0),
       child: Column(children: [
         TextField(
           controller: _title,
           decoration: InputDecoration(
             hintText: 'Title',
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
           ),
         ),
         SizedBox(height: 15.h,),
         Expanded(
           child: TextField(
             controller: _description,
             decoration: InputDecoration(
               hintText: 'Start typing here....',
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
             ),
             maxLines: 50,
           ),
         )
       ],),
     ),
   );
  }

_insertNote()async{
  final note =Note(
      title: _title.text,
      description: _description.text,
      createdAt: DateTime.now()
  );
  await  NoteRepository.insert(note: note);
}
  _updateNote()async{
    final note =Note(
         id: widget.note!.id,
        title: _title.text,
        description: _description.text,
        // previous date
        createdAt: widget.note!.createdAt,
    );
    await  NoteRepository.update(note: note);
  }
  _deleteNote()async{
    NoteRepository.delete(note: widget.note!).then((e){
      Navigator.pop(context);
    });
  }

}