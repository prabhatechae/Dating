import 'package:Mingledxb/helpers/app_localizations.dart';
import 'package:Mingledxb/models/user_model.dart';
import 'package:Mingledxb/widgets/default_card_border.dart';
import 'package:Mingledxb/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constants/constants.dart';
import '../screens/custom_profile_screen.dart';

class ProfileBasicInfoCard extends StatelessWidget {
  const ProfileBasicInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Initialization
    final i18n = AppLocalizations.of(context);
    //
    // Get User Birthday
    final DateTime userBirthday = DateTime(UserModel().user.userBirthYear,
        UserModel().user.userBirthMonth, UserModel().user.userBirthDay);
    // Get User Current Age
    final int userAge = UserModel().calculateUserAge(userBirthday);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ScrollPhysics(),
      child: Card(
        color: Colors.grey[900],
        elevation: 4.0,
        shape: defaultCardBorder(),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile image
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40, // Adjust the radius as needed
                            backgroundColor:
                                Colors.purple, // Specify the background color
                            backgroundImage:
                                UserModel().user.userProfilePhoto != null
                                    ? NetworkImage(
                                        UserModel().user.userProfilePhoto)
                                    : null,
                          ),
                          if (UserModel().user.userVideoUrl != null &&
                              UserModel().user.userVideoUrl.isNotEmpty)
                            ClipOval(
                              child: SizedBox(
                                width: 80,
                                height: 80,
                                child: VideoPlayerWidget(
                                  videoUrl: UserModel().user.userVideoUrl,
                                ),
                              ),
                            ),
                        ],
                      )

                      // ClipOval(
                      //   child: SizedBox(
                      //     width: 80, // Set an appropriate size
                      //     height: 80, // Set an appropriate size
                      //     child: Align(
                      //       alignment: Ali2gnment.center,
                      //       child: Container(
                      //         color: Colors.cyan,
                      //         child: UserModel().user.userVideoUrl != null
                      //             ? VideoPlayerWidget(
                      //                 videoUrl: UserModel().user.userVideoUrl,
                      //               )
                      //             : Image.network(
                      //                 UserModel().user.userProfilePhoto,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      ),

                  ///>>>. profile image only
                  // Container(
                  //   padding: const EdgeInsets.all(3.0),
                  //   decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     radius: 40,
                  //     backgroundImage: NetworkImage(UserModel().user.userProfilePhoto),
                  //     onBackgroundImageError: (e, s) => {debugPrint(e.toString())},
                  //   ),
                  // ),

                  const SizedBox(width: 10),

                  /// Profile details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${UserModel().user.userFullname.split(' ')[0]} ",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        userAge.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),

                      /// Location
                      Row(
                        children: [
                          const SvgIcon("assets/icons/location_point_icon.svg",
                              color: Colors.white),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // City
                              Text("${UserModel().user.userLocality},",
                                  style: const TextStyle(color: Colors.white)),
                              // Country
                              Text(UserModel().user.userCountry,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            APP_PRIMARY_COLOR,
                            APP_ACCENT_COLOR,
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(28))),
                      child: TextButton.icon(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                      // borderRadius: BorderRadius.circular(28),
                                      ))),
                          label: Text(i18n.translate("edit"),
                              style: const TextStyle(color: Colors.black)),
                          onPressed: () {
                            /// Go to edit profile screen
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const EditProfileScreen()));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CustomProfileScreen(
                                      user: UserModel().user,
                                      showButtons: false,
                                    )));
                          }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              /// Buttons
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       SizedBox(
              //         height: 30,
              //         child: OutlinedButton.icon(
              //             icon: const Icon(Icons.remove_red_eye,
              //                 color: Colors.white),
              //             label: Text(i18n.translate("view"),
              //                 style: const TextStyle(color: Colors.white)),
              //             style: ButtonStyle(
              //                 side: MaterialStateProperty.all<BorderSide>(
              //                     const BorderSide(color: Colors.white)),
              //                 shape: MaterialStateProperty.all<OutlinedBorder>(
              //                     RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(28),
              //                 ))),
              //             onPressed: () {
              //               /// Go to profile screen
              //               Navigator.of(context).push(MaterialPageRoute(
              //                   builder: (context) => ProfileScreen(
              //                       user: UserModel().user, showButtons: false)));
              //             }),
              //       ),
              //       cicleButton(
              //         bgColor: APP_ACCENT_COLOR,
              //         padding: 13,
              //         icon: const SvgIcon("assets/icons/settings_icon.svg",
              //             color: Colors.white, width: 30, height: 30),
              //         onTap: () {
              //           /// Go to profile settings
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => const SettingsScreen()));
              //         },
              //       ),
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _controller.initialize().then((_) {
      // Ensure the first frame is shown and set state
      if (mounted) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      }
    }).catchError((error) {
      print("Video initialization error: $error");
    });
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.videoUrl != oldWidget.videoUrl) {
      _controller.dispose();
      _controller = VideoPlayerController.network(widget.videoUrl);
      _controller.initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller.play();
          _controller.setLooping(true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//
//   VideoPlayerWidget({required this.videoUrl});
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         _controller!.play();
//         _controller!.setLooping(true);// Optionally set looping
//         // Ensure the first frame is shown and set state
//         setState(() {});
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           )
//         : SizedBox();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
