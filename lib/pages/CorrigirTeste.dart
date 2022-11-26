import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
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
