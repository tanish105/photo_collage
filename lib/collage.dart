import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DisplayPhotosScreen extends StatefulWidget {
  const DisplayPhotosScreen({Key? key, this.selectedPhotos}) : super(key: key);

  final List<XFile>? selectedPhotos;

  @override
  _DisplayPhotosScreenState createState() => _DisplayPhotosScreenState();
}

class _DisplayPhotosScreenState extends State<DisplayPhotosScreen> {
  List<XFile>? _selectedPhotos;

  @override
  void initState() {
    super.initState();
    _selectedPhotos = widget.selectedPhotos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Photos'),
      ),
      body: _selectedPhotos != null && _selectedPhotos!.isNotEmpty
          ? _buildCollage(context, _selectedPhotos!)
          : Center(
              child: Text('No photos selected.'),
            ),
    );
  }

  Widget _buildCollage(BuildContext context, List<XFile> photos) {
    if (photos.length == 1) {
      return _buildSinglePhotoCollage(context, photos.first);
    } else if (photos.length == 2) {
      return _buildTwoPhotosCollage(context, photos);
    } else if (photos.length == 3) {
      return _buildThreePhotosCollage(context, photos);
    } else if (photos.length > 3) {
      return _buildThreeOrMorePhotosCollage(context, photos);
    } else {
      return const Center(
        child: Text('Only 1-3 photos are supported.'),
      );
    }
  }

  Widget _buildSinglePhotoCollage(BuildContext context, XFile photo) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Image.file(
            File(photo.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(
                File(photo.path),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.height / 2 - 200,
                height: MediaQuery.of(context).size.height / 2 - 200,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTwoPhotosCollage(BuildContext context, List<XFile> photos) {
    final firstPhoto = photos[0];
    final secondPhoto = photos[1];

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Image.file(
            File(firstPhoto.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(40.0), // Adjust padding
          child: Stack(
            children: [
              Positioned(
                top: 150,
                left: 30,
                child: Transform.rotate(
                  angle: -0.05, // Adjust angle for tilt
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make square shape
                    child: Image.file(
                      File(firstPhoto.path),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      height: MediaQuery.of(context).size.height / 2 - 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 150,
                right: 30,
                child: Transform.rotate(
                  angle: 0.1, // Adjust angle for tilt
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make square shape
                    child: Image.file(
                      File(secondPhoto.path),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      height: MediaQuery.of(context).size.height / 2 - 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThreePhotosCollage(BuildContext context, List<XFile> photos) {
    final firstPhoto = photos[0];
    final secondPhoto = photos[1];
    final thirdPhoto = photos[2];

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Image.file(
            File(firstPhoto.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(40.0), // Adjust padding
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 20,
                child: Transform.rotate(
                  angle: -0.15, // Adjust angle for tilt
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make square shape
                    child: Image.file(
                      File(secondPhoto.path),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      height: MediaQuery.of(context).size.height / 2 - 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                right: 20,
                child: Transform.rotate(
                  angle: 0.1,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make square shape
                    child: Image.file(
                      File(thirdPhoto.path),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      height: MediaQuery.of(context).size.height / 2 - 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 80,
                // right: 150,
                bottom: 200,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // Make square shape
                  child: Image.file(
                    File(firstPhoto.path),
                    width: MediaQuery.of(context).size.width / 2 - 50,
                    height: MediaQuery.of(context).size.height / 2 - 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThreeOrMorePhotosCollage(
      BuildContext context, List<XFile> photos) {
    final firstPhoto = photos[0];
    final secondPhoto = photos[1];
    final thirdPhoto = photos[2];
    final remainingPhotos = photos.length - 3;

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Image.file(
            File(firstPhoto.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(40.0), // Adjust padding
          child: Stack(
            children: [
              Positioned(
                top: 150,
                left: 30,
                child: Transform.rotate(
                  angle: 0, // Adjust angle for tilt
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make square shape
                    child: Image.file(
                      File(thirdPhoto.path),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      height: MediaQuery.of(context).size.height / 2 - 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 400,
                left: 30,
                child: Transform.rotate(
                  angle: 0.0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make square shape
                    child: Image.file(
                      File(secondPhoto.path),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      height: MediaQuery.of(context).size.height / 2 - 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 230,
                left: 150,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // Make square shape
                  child: Image.file(
                    File(firstPhoto.path),
                    width: MediaQuery.of(context).size.width / 2 - 50,
                    height: MediaQuery.of(context).size.height / 2 - 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "+ $remainingPhotos",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
