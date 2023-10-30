import 'dart:ffi';
import 'dart:typed_data';
import 'package:Mingledxb/models/user_model.dart';
import 'package:biopassid_face_sdk/biopassid_face_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../datas/user.dart';
import 'interest_screen.dart';

// class FaceRecognitionScreen extends StatefulWidget {
//   const FaceRecognitionScreen({Key? key}) : super(key: key);
//
//   @override
//   _FaceRecognitionScreenState createState() => _FaceRecognitionScreenState();
// }
//
// class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> {
//   late FaceController controller;
//   bool isFaceVerified = false;
//   String? faceRecognitionValue;
//   @override
//   void initState() {
//     super.initState();
//     final config = FaceConfig(licenseKey: 'H4H9-ZH96-WJJJ-XJFA');
//     controller = FaceController(
//       config: config,
//       onFaceCapture: (Uint8List image) async {
//         FirebaseFirestore firestore = FirebaseFirestore.instance;
//         await firestore
//             .collection("Users")
//             .doc(UserModel().user.userId)
//             .update({"user_Face_Recognition": image});
//         print('Image: $image');
//       },
//     );
//   }
//
//   // void takeFace() async {
//   //   await controller.takeFace();
//   // }
//
//   void takeFace() async {
//     try {
//       await controller.takeFace();
//
//       // Fluttertoast.showToast(
//       //   msg: 'Face recognition data saved successfully!',
//       //   toastLength: Toast.LENGTH_SHORT,
//       //   gravity: ToastGravity.CENTER,
//       //   timeInSecForIosWeb: 2,
//       // );
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const InterestScreen()),
//           (route) => false);
//     } catch (e) {
//       // Handle other exceptions, indicating a failure
//       Fluttertoast.showToast(
//         msg: 'Face capture failed!',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 2,
//       );
//     }
//   }
//
// // ...
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Face Demo'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: takeFace,
//           child: const Text('Capture Face'),
//         ),
//       ),
//     );
//   }
// }

class FaceRecognitionScreen extends StatefulWidget {
  final User? user;
  const FaceRecognitionScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  _FaceRecognitionScreenState createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> {
  late FaceController controller;
  bool isFaceVerified = false;
  Uint8List? capturedImage;

  @override
  void initState() {
    super.initState();
    final config = FaceConfig(licenseKey: 'H4H9-ZH96-WJJJ-XJFA');
    controller = FaceController(
      config: config,
      onFaceCapture: (Uint8List image) {
        setState(() {
          capturedImage = image;
          uploadImageToFirebaseStorage(capturedImage!);
        });
      },
    );
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List image) async {
    try {
      final currentTime = DateTime.now();
      final imageName = 'image_${currentTime.millisecondsSinceEpoch}.jpg';
      final storageRef =
          FirebaseStorage.instance.ref().child('images').child(imageName);

      final uploadTask = storageRef.putData(image);

      // Wait for the upload to complete
      await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      final imageUrl = await storageRef.getDownloadURL();
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("Users")
          .doc(widget.user!
              .userId) //"2xBtrkKVflP4nt26THv1Ohnxl0y2" widget.user!.userId
          .update({
        "user_face_recognition": imageUrl,
      });
      // print("User Id :- ${widget.user!.userId}");
      Fluttertoast.showToast(
        msg: 'Face capture successfully!',
        toastLength: Toast.LENGTH_SHORT, // Set the duration of the toast
        gravity: ToastGravity.BOTTOM,
        // Set the toast position
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const InterestScreen()),
        (route) => false,
      );
      print('Image uploaded to Firebase Storage. Download URL: $imageUrl');
    } catch (e) {
      // Fluttertoast.showToast(
      //   msg: 'Face capture failed!',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 2,
      // );
      print('Error uploading image to Firebase Storage: $e');
    }
  }

  void takeFace() async {
    await controller.takeFace();
    // try {
    //   await controller.takeFace();
    //   // if (capturedImage != null) {
    //   //   // Upload the captured image to Firebase Storage
    //   //   // await uploadImageToFirebaseStorage(capturedImage!);
    //   //
    //   //   // Navigate to another screen or perform other actions if needed
    //   //   Navigator.of(context).pushAndRemoveUntil(
    //   //     MaterialPageRoute(builder: (context) => const InterestScreen()),
    //   //     (route) => false,
    //   //   );
    //   // } else {
    //   //   Fluttertoast.showToast(
    //   //     msg: 'No image captured.',
    //   //     toastLength: Toast.LENGTH_SHORT,
    //   //     gravity: ToastGravity.CENTER,
    //   //     timeInSecForIosWeb: 2,
    //   //   );
    //   // }
    // } catch (e) {
    //   // Handle other exceptions, indicating a failure
    //   Fluttertoast.showToast(
    //     msg: 'Face capture failed!',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 2,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // Add a back button to the app bar
        elevation: 0,
        leading: Container(
          height: 10,
          width: 40,
          margin: const EdgeInsets.only(left: 20, top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              size: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/profile.png",
            height: 120,
            width: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Enable Face ID",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          const FittedBox(
            fit: BoxFit.cover,
            child: Text(
              "This help us check that you,re really you. Identity",
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const FittedBox(
              fit: BoxFit.cover,
              child: Text(
                "verification is one of the ways we keep secure.",
                style: TextStyle(fontSize: 17, color: Colors.white),
              )),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(29, 162, 222, 1.0),
                    Color.fromRGBO(244, 179, 183, 1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Make the button background transparent
                ),
                onPressed: takeFace,
                child: const Text(
                  'Capture Face',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
