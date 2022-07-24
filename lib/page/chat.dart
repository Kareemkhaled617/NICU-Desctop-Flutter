import 'dart:async';

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../resources/color_manger.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool _status = false;
  List req = [];
  int? currentIndex;

  @override
  void initState() {
    getMassage();
    Timer.periodic(
        const Duration(milliseconds: 300), (Timer t) => getMassage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ScrollablePositionedList.separated(
                initialScrollIndex: 0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          UserItem(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [MyItem(massage: req[index]['Massage'])],
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                itemCount: req.length),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          color: ColorManager.primary,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            _status == true
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              _status = !_status;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.arimo(
                            fontSize: 17,
                            color: Colors.grey[700],
                          ),
                          hintText: 'Type Something',
                          hintStyle: GoogleFonts.arimo(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.send,
                        ),
                        onPressed: () {}),
                  ],
                ),
                _status == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                              const Text('Photo'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.videocam,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                              const Text('Video'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                              const Text('location'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.keyboard_voice_sharp,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                              const Text('Voice'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.attach_file,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                              const Text('File'),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  getMassage() async {
    CollectionReference pp = Firestore.instance
        .collection('hospital')
        .document('FgvSGwLJLdYm75aTrxjJV6mnj6B3')
        .collection('massage');
    await pp.get().then((value) => value.forEach((elemente) {
          setState(() {
            var isExist = req.firstWhere(
                (element) => element['id'] == elemente.id,
                orElse: () => null);
            if (isExist == null) {
              req.add(elemente.map);
            } else {}
          });
        }));
  }

  addDataEmail(String id) async {
    var addUser = Firestore.instance.collection('hospital').document(id);
    addUser.set({
      'Massage': '',
      'time': DateFormat('hh:mm a').format(DateTime.now()).toString(),
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
    });
  }

  checkForNewSharedLists() {
    print('--------------');
    setState(() {});
  }
}

class UserItem extends StatefulWidget {
  const UserItem({Key? key}) : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            child: IconButton(
              icon: const Icon(Icons.person),
              alignment: Alignment.center,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(8),
                    bottomStart: Radius.circular(8),
                    topEnd: Radius.circular(8),
                  )),
              child: Text(
                'Hello Nourhan',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  MyItem({Key? key, this.massage}) : super(key: key);
  String? massage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(8),
                    bottomStart: Radius.circular(8),
                    topEnd: Radius.circular(8),
                  )),
              child: Text(
                massage!,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          CircleAvatar(
            child: IconButton(
              icon: const Icon(Icons.person),
              alignment: Alignment.center,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
