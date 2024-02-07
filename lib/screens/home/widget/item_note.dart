import 'package:dairy_app/models/note.dart';
import 'package:dairy_app/repositry/note%20repository.dart';
import 'package:dairy_app/screens/AddNote/Add%20note%20screen.dart';
import 'package:dairy_app/themes/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ItemNote extends StatefulWidget {
  final Note note;

  const ItemNote({Key? key, required this.note}) : super(key: key);

  @override
  State<ItemNote> createState() => _ItemNoteState();
}

class _ItemNoteState extends State<ItemNote> {
  bool choosen = false;

  @override
  Widget build(BuildContext context) {
    // to open the note on clicking on it
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNote(note: widget.note)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.secondaryColor,
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat(DateFormat.ABBR_MONTH).format(widget.note.createdAt!),
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    DateFormat(DateFormat.DAY).format(widget.note.createdAt!),
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.sp),
                  ),
                  Text(
                    widget.note.createdAt!.year.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.note.title!,
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        DateFormat(DateFormat.HOUR24_MINUTE).format(widget.note.createdAt!),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.note.description!,
                        style: TextStyle(fontWeight: FontWeight.w300, height: 1.5),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: const Text("Mission done, Good Job"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    _deleteNote();
                                  },
                                  child: const Text('Delete the note'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      choosen = !choosen;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(' Keep it as ${choosen ? 'undone' : 'done'}'),
                                )
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          choosen ? Icons.check_box : Icons.check_box_outline_blank,
                          color: AppColors.secondaryColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deleteNote() async {
    NoteRepository.delete(note: widget.note!).then((e) {
      Navigator.pop(context);
    });
  }
}