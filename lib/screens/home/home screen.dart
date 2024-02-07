import 'package:dairy_app/repositry/note%20repository.dart';
import 'package:dairy_app/screens/AddNote/Add%20note%20screen.dart';
import 'package:dairy_app/screens/home/widget/item_note.dart';
import 'package:dairy_app/themes/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delayed_display/delayed_display.dart';

import '../../models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await NoteRepository.getNote();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Tasks",
          style: GoogleFonts.anton(
            color: AppColors.secondaryColor,
            fontSize: 25.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor, size: 25,),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              _loadData();
            },
            icon: Icon(Icons.refresh, size: 25, color: AppColors.secondaryColor,),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNote()));
        },
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.black, size: 25,),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Note>>(
        future: NoteRepository.getNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('Empty'),);
            }
            return ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final note = snapshot.data![index];
                return DelayedDisplay(
                  delay: Duration(milliseconds: 200 * index),
                  child: ItemNote(
                    note: note,
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}