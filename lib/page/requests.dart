import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nicu_desctop/page/more_details.dart';

class Requests extends StatefulWidget {
   Requests({Key? key,required this.id}) : super(key: key);

  String id;

  @override
  State<Requests> createState() => _RequestState();
}

class _RequestState extends State<Requests> {
  CollectionReference request = Firestore.instance.collection('Request');
  String? name;
  List req = [];
  String? id;

  getRequest() async {
    CollectionReference pp = Firestore.instance
        .collection('hospital')
        .document('20')
        .collection('Request');
    await pp.get().then((value) => value.forEach((element) {
          setState(() {
            req.add(element.map);
          });
        }));
  }

  getID() async {
    DocumentReference pp =
        Firestore.instance.collection('hospital').document('20');
    await pp.get().then((value) {
      setState(() {
        id = value.map['id'];
      });
    });
  }

  @override
  void initState() {
    getID();
    getRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: req.length,
        itemBuilder: (context, index) => Container(
          margin:
              const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
          padding: const EdgeInsets.only(left: 30, bottom: 20, top: 10),
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          width: MediaQuery.of(context).size.width / 2,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              req[index]['image'] == 'null'
                  ? const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(req[index]['image']),
                    ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name :',
                        style: GoogleFonts.archivo(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        req[index]['name'],
                        style: GoogleFonts.adamina(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Email :',
                        style: GoogleFonts.archivo(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          req[index]['Email'],
                          style: GoogleFonts.adamina(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Colors.lightBlue.shade900),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(child: Container()),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MoreDetails(
                              name: req[index]['name'],
                              gender: req[index]['Gender'],
                              image: req[index]['image'],
                              birthday: req[index]['Birthday'],
                              email: req[index]['Email'],
                              weight: req[index]['Weight'],
                              phone: req[index]['phone'],
                            )));
                  },
                  icon: const Icon(Icons.read_more_rounded),
                  label: const Text('More'))
            ],
          ),
        ),
      ),
    );
  }
}
