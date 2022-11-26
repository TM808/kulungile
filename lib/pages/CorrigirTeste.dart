import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CorrigirTest extends StatefulWidget {
  const CorrigirTest({super.key});

  @override
  _CorrigirTestState createState() => _CorrigirTestState();
}

class _CorrigirTestState extends State<CorrigirTest> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SizedBox(
          child: Column(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            width: 400,
            child: controller == null
                ? const Center(child: Text("Procurando camera ..."))
                : !controller!.value.isInitialized
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CameraPreview(controller!)),
        ElevatedButton.icon(
          //image capture button
          onPressed: () async {
            try {
              if (controller != null) {
                //check if contrller is not null
                if (controller!.value.isInitialized) {
                  //check if controller is initialized
                  image = await controller!.takePicture(); //capture image4
                  File tempImg = File(image!.path);

                  // getting a directory path for saving
                  final String path = (await getExternalStorageDirectory())!.path;

                  // copy the file to a new path
                  final File newImage = await tempImg.copy('$path/${image!.name}');
                  
                                     if (newImage.path != null) {
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text(newImage.path),
                      ));
                    }
                    {
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text("path: ${image!.path}"),
                      ));
                    }
                }
              }
            } catch (e) {
              print(e); //show error
            }
          },
          icon: const Icon(Icons.camera),
          label: const Text("Fotografar teste"),
        ),
      ])),
    );
  }
}
