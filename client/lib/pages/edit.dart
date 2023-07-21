import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/state/auth.state.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _displayName;
  late TextEditingController _bio;
  late TextEditingController _userName;
  late TextEditingController _localisation;
  File? _image;

  @override
  void initState() {
    _displayName = TextEditingController();
    _bio = TextEditingController();
    _localisation = TextEditingController();
    _userName = TextEditingController();
    AuthState state = Provider.of<AuthState>(context, listen: false);
    _displayName.text = state.userModel?.displayName ?? '';
    _bio.text = state.userModel?.bio ?? '';
    _userName.text = state.userModel?.userName ?? '';
    _localisation.text = state.userModel?.localisation ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _bio.dispose();
    _localisation.dispose();
    _userName.dispose();
    _displayName.dispose();
    super.dispose();
  }

  Future<void> getImage(BuildContext context, ImageSource source,
      Function(File) onImageSelected) async {
    ImagePicker()
        .pickImage(source: source, imageQuality: 100)
        .then((XFile? file) async {
      await ImageCropper.platform.cropImage(
        sourcePath: file!.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ).then((value) => setState(() {
            onImageSelected(File(value!.path));
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          toolbarHeight: 68,
          leading: Container(),
          flexibleSpace: Padding(
              padding: EdgeInsets.only(left: 5, top: 78),
              child: Column(
                children: [
                  FadeIn(
                      duration: Duration(milliseconds: 1000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18))),
                          GestureDetector(
                              onTap: _submitButton,
                              child: Text("Save",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)))
                        ],
                      )),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  )
                ],
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: FadeInRight(
              duration: Duration(milliseconds: 300),
              child: Text(
                "Modify profile",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))),
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        children: [
          Container(
            height: 30,
          ),
          GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoTheme(
                          data: CupertinoThemeData(
                            brightness:
                                Brightness.dark, // Définir le mode sombre
                          ),
                          child: CupertinoActionSheet(
                            title: Text('Change of profile picture'),
                            message: Text(
                                'Your profile picture is visible to everyone and will make it easier for your friends to add you'),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: Text('Photo library'),
                                onPressed: () {
                                  getImage(context, ImageSource.gallery,
                                      (file) {
                                    setState(() {
                                      _image = file;
                                    });
                                  });
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('Appareil photo'),
                                onPressed: () {
                                  getImage(context, ImageSource.camera, (file) {
                                    setState(() {
                                      _image = file;
                                    });
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text(
                                  'Delete you\'re profile picture',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ));
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 60,
                      backgroundImage: (_image != null
                          ? FileImage(_image!)
                          : CachedNetworkImageProvider(
                                  scale: 3,
                                  state.profileUserModel?.profilePic ??
                                      "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg")
                              as ImageProvider)),
                  Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                              height: 30,
                              width: 30,
                              child: Transform.scale(
                                  scale: 1.2,
                                  child: Image.asset(
                                    "assets/photo.png",
                                    fit: BoxFit.cover,
                                  )))))
                ],
              )),
          Container(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Container(
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text(
                        'Full Name  ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                          child: TextField(
                        cursorColor: Colors.white,
                        controller: _displayName,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 79, 79, 79))),
                      )),
                    ],
                  ),
                  Container(
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text(
                        'User name  ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                          child: TextField(
                        controller: _userName,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'User name',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 79, 79, 79))),
                      )),
                    ],
                  ),
                  Container(
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Row(
                      children: [
                        Text(
                          'Bio  ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                            child: TextField(
                          cursorColor: Colors.white,
                          controller: _bio,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Bio',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 79, 79, 79))),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text(
                        'Localization  ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                          child: TextField(
                        cursorColor: Colors.white,
                        controller: _localisation,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Localization',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 79, 79, 79))),
                      )),
                    ],
                  ),
                  Container(
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                ],
              ))
        ],
      ))),
    );
  }

  void _submitButton() {
    if (_displayName.text.length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        backgroundColor: Colors.white,
        content: Container(
            alignment: Alignment.center,
            height: 30,
            child: Text(
              'Max Len: 100 char',
              style: TextStyle(
                  fontFamily: "icons.ttf",
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            )),
      ));
      return;
    }
    if (_bio.text.length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        backgroundColor: Colors.white,
        content: Container(
            alignment: Alignment.center,
            height: 30,
            child: Text(
              'Max Len: 100 char',
              style: TextStyle(
                  fontFamily: "icons.ttf",
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            )),
      ));
      return;
    }
    var state = Provider.of<AuthState>(context, listen: false);
    var model = state.userModel!.copyWith(
      key: state.userModel!.userId,
      displayName: state.userModel!.displayName,
      userName: state.userModel!.userName,
      bio: state.userModel!.bio,
      localisation: state.userModel!.localisation,
      profilePic: state.userModel!.profilePic,
    );
    if (_userName.text.isNotEmpty) {
      model.displayName = _displayName.text;
    }
    model.bio = _bio.text;
    model.localisation = _localisation.text;
    state.updateUserProfile(
      model,
      image: _image,
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
