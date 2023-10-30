// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/constants.dart';
import '../models/user_model.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({
    super.key,
  });

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  getUserInterestBackend() async {
    List<String> interests = await UserModel().getUserInterest();

    setState(() {
      SelectedInterestList = interests;
    });
  }

  List<Map<String, String>> interestsData = [
    {
      'name': 'Exercise',
      'icon': 'assets/interest/exercise.png',
    },
    {
      'name': 'Society',
      'icon': 'assets/interest/society_icon.png',
    },
    {
      'name': 'Traveling',
      'icon': 'assets/interest/travelling.png',
    },
    {
      'name': 'Music',
      'icon': 'assets/interest/music.png',
    },
    {
      'name': 'Movies',
      'icon': 'assets/interest/movies.png',
    },
    {
      'name': 'Sports',
      'icon': 'assets/interest/sports.png',
    },
    {
      'name': 'Coding',
      'icon': 'assets/interest/coding.png',
    },
    {
      'name': 'Reading',
      'icon': 'assets/interest/open-book.png',
    },
    {
      'name': 'Business',
      'icon': 'assets/interest/business.png',
    },
    {
      'name': 'Art',
      'icon': 'assets/interest/art.png',
    },
    {
      'name': 'Charity',
      'icon': 'assets/interest/generous.png',
    },
    {
      'name': 'Animals',
      'icon': 'assets/interest/wild-animals.png',
    },
    {
      'name': 'Cars',
      'icon': 'assets/interest/car.png',
    },
    {
      'name': 'Culture',
      'icon': 'assets/interest/worldwide.png',
    },
    {
      'name': 'Yoga',
      'icon': 'assets/interest/yoga.png',
    },
    {
      'name': 'Spirituality',
      'icon': 'assets/interest/pray.png',
    },

    // {
    //   'name': 'Photography',
    //   'icon': 'assets/interest/photography.png',
    // },
    // {
    //   'name': 'Karaoke',
    //   'icon': 'assets/interest/karaoke.png',
    // },
    // {
    //   'name': 'Shopping',
    //   'icon': 'assets/interest/shopping.png',
    // },
    //
    // {
    //   'name': 'Cooking',
    //   'icon': 'assets/interest/cooking.png',
    // },
    // {
    //   'name': 'Tennis',
    //   'icon': 'assets/interest/tennis.png',
    // },
    // {
    //   'name': 'Run',
    //   'icon': 'assets/interest/run.png',
    // },
    // {
    //   'name': 'Swimming',
    //   'icon': 'assets/interest/swimming.png',
    // },
    //
    //
    // {
    //   'name': 'Extreme',
    //   'icon': 'assets/interest/extreme.png',
    // },
    //
    // {
    //   'name': 'Drink',
    //   'icon': 'assets/interest/drink.png',
    // },
  ];

  // ignore: non_constant_identifier_names
  List<String> SelectedInterestList = [];
  @override
  void initState() {
    super.initState();
    getUserInterestBackend();
  }

  void showSnackBar(BuildContext context) {
    Fluttertoast.showToast(
      msg: 'Successfully saved!',
      toastLength: Toast.LENGTH_SHORT, // Set the duration of the toast
      gravity: ToastGravity.BOTTOM, // Set the toast position
    );
    // const snackBar = SnackBar(
    //   content: Text('Successfully saved!'),
    //   backgroundColor: Colors.green,
    //   behavior: SnackBarBehavior.floating,
    //   duration: Duration(seconds: 2),
    // );
    //
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBarRemoved(BuildContext context, String interestName) {
    Fluttertoast.showToast(
      msg: 'Removed $interestName!',
      toastLength: Toast.LENGTH_SHORT, // Set the duration of the toast
      gravity: ToastGravity.BOTTOM, // Set the toast position
    );
    // final snackBar = SnackBar(
    //   content: Text('Removed $interestName!'),
    //   backgroundColor: Colors.red,
    //   behavior: SnackBarBehavior.floating,
    //   duration: Duration(seconds: 2),
    // );

    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.height * 0.06,
                margin: const EdgeInsets.only(left: 20, top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    (Icons.arrow_back_ios_outlined),
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 1000,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 5 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20),
                      itemCount: interestsData.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            final String interestName =
                                interestsData[index]['name']!;

                            if (SelectedInterestList.contains(interestName)) {
                              // Item is already in the list, remove it
                              SelectedInterestList.remove(interestName);
                              UserModel().userInterest(
                                userInterests: SelectedInterestList,
                                onSuccess: () {
                                  showSnackBarRemoved(context, interestName);
                                  print('Interest removed: $interestName');
                                },
                                onFail: (error) {
                                  print("Interest removal error: $error");
                                },
                              );
                            } else {
                              // Item is not in the list, add it
                              SelectedInterestList.add(interestName);
                              UserModel().userInterest(
                                userInterests: SelectedInterestList,
                                onSuccess: () {
                                  showSnackBar(context);
                                  print('Interest saved: $interestName');
                                },
                                onFail: (error) {
                                  print("Interest save error: $error");
                                },
                              );
                            }

                            setState(() {});
                          },

                          // onTap: () {
                          //   if (SelectedInterestList.contains(
                          //       interestsData[index]['name'])) {
                          //     SelectedInterestList.remove(
                          //         interestsData[index]['name']);
                          //   } else {
                          //     SelectedInterestList.add(interestsData[index]['name']!);
                          //   }
                          //   UserModel().userInterest(
                          //     userInterests: SelectedInterestList,
                          //     onSuccess: () async {
                          //       showSnackBar(context);
                          //       print('Interested updated');
                          //     },
                          //     onFail: (error) {
                          //       print("interest error $error");
                          //     },
                          //   );
                          //
                          //   setState(() {});
                          // },
                          child: SelectedInterestList.contains(
                                  interestsData[index]['name'])
                              ? Container(
                                  width: 140,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffDDDDDD),
                                        blurRadius: 10.0,
                                        spreadRadius: 4.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ],
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF589DC6),
                                        Color(0xFFF4B3B7),
                                      ],
                                    ),
                                    color: const Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: const Color(0xFFE8E6EA),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        ColorFiltered(
                                          colorFilter: const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                          child: Image.asset(
                                              interestsData[index]['icon']!),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          interestsData[index]['name']!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  )),
                                )
                              : Container(
                                  width: 140,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFFFFFFFF),
                                      ],
                                    ),
                                    color: const Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: const Color(0xFFE8E6EA),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        ColorFiltered(
                                          colorFilter: const ColorFilter.mode(
                                            APP_PRIMARY_COLOR,
                                            BlendMode.srcIn,
                                          ),
                                          child: Image.asset(
                                              interestsData[index]['icon']!),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          interestsData[index]['name']!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
