
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../themes/AppColors.dart';
import '../home/home screen.dart';

void main(){
  runApp( MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),

    );

  }

}
class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen ({Key?Key}):super(key:Key);

  @override
  State<WelcomeScreen> createState()=>_WelcomeScreenState();

}

class _WelcomeScreenState extends State< WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Center(child: Image(image: NetworkImage("https://cdn-icons-png.freepik.com/256/1488/1488997.png?ga=GA1.2.1454705726.1706974768&semt=ais"),),),
          SizedBox(
            height: 10.h,
          ),
          Center(child: Text('To Remember',style: GoogleFonts.anton(color: AppColors.secondaryColor,fontSize: 45.sp),)).animate().fade(duration: 2.seconds),
          SizedBox(
            height: 60.h,
          ),
          Column(children: [
            SizedBox(width: 60.h,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>HomeScreen()));
              },
              child: Container( width: 150.h,height: 60.h,child: Center(child: Text("Get Started",style:TextStyle(color: Colors.black,fontSize: 25.sp,),)),
                decoration: BoxDecoration(color:AppColors.secondaryColor,borderRadius: BorderRadius.circular(10.r),border: Border.all(width: 3.h,color:AppColors.secondaryColor)),),
            ).animate().fade(duration: 2.seconds),


          ],)
        ],
      ),

    );

  }
}

