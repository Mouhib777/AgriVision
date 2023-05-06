import 'dart:io';

import 'package:tflite/tflite.dart';

class TreeRecognition {
  static Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/TensorFlow/model.tflite',
      labels: 'assets/label.txt',
    );
  }

  static Future<String> recognizeTree(File imageFile) async {
    final output = await Tflite.runModelOnImage(
      path: imageFile.path,
      numResults: 1,
      threshold: 0.1,
    );
    return output!.isNotEmpty ? output.first['label'] : 'Unknown';
  }

  static Future<void> disposeModel() async {
    await Tflite.close();
  }
}

























































// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

// class TfliteModel extends StatefulWidget {
//   const TfliteModel({super.key});

//   @override
//   State<TfliteModel> createState() => _TfliteModelState();
// }

// class _TfliteModelState extends State<TfliteModel> {
//   ImagePicker? imagePicker;
//   File? _pickedImage;
//   String? imageUrl;
//   final ImagePicker _picker = ImagePicker();
//   late List _resultat ; 
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadModel();
//   }

//   Future loadModel() async {
//     Tflite.close();
//     String resultat;
//     resultat = (await Tflite.loadModel(
//         model: "assets/TensorFlow/model.tflite",
//         labels: "assets/TensorFlow/label.txt"))!;
//     print('Models loading statuts : $resultat');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Classification'),
//       ),
//       body: ListView(
//         children: [],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//       ),
//     );
//   }
//   Future imageClassification(File _pickedImage  )async{
//     var recognitions = await Tflite.runPix2PixOnImage(path:  )
//   }

//   handle_image_camera() async {
//     XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     _pickedImage = File(pickedFile!.path);
//     imageClassification(_pickedImage); 

//     if (_pickedImage != null) {
//       setState(() {
//         _pickedImage;
//       });
//     } else {
//       EasyLoading.showError('No image selected');
//     }
//   }

//   handle_image_gallery() async {
//     XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     _pickedImage = File(pickedFile!.path);

//     if (_pickedImage != null) {
//       setState(() {
//         _pickedImage;
//       });
//     } else {
//       EasyLoading.showError('No image selected');
//     }
//   }
// }
