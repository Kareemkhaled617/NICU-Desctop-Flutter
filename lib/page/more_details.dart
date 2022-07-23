import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nicu_desctop/page/requests.dart';

import '../home_page.dart';

class MoreDetails extends StatelessWidget {
  MoreDetails(
      {Key? key,
      this.image,
      this.name,
      this.email,
      this.weight,
      this.birthday,
      this.gender})
      : super(key: key);
  String? name;
  String? email;
  String? birthday;
  String? gender;
  String? image;
  String? weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios,),onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (conext)=>const MyHomePage()));
      },),),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image == 'null'
              ? const CircleAvatar(
                  radius: 70,
                  child: Icon(Icons.person),
                )
              : CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(image!),
                ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            color: Colors.teal.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name :',
                    style: GoogleFonts.archivo(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name!,
                    style: GoogleFonts.alef(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown.shade700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            color: Colors.teal.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email :',
                    style: GoogleFonts.archivo(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    email!,
                    style: GoogleFonts.alef(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown.shade700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            color: Colors.teal.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gender :',
                    style: GoogleFonts.archivo(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    gender!,
                    style: GoogleFonts.alef(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown.shade700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            color: Colors.teal.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Birthday :',
                    style: GoogleFonts.archivo(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    birthday!,
                    style: GoogleFonts.alef(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown.shade700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            color: Colors.teal.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Weight :',
                    style: GoogleFonts.archivo(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    weight!,
                    style: GoogleFonts.alef(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown.shade700),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
