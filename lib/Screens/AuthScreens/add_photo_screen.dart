import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_modal_progress_hud.dart';
import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Models/user_registration.dart';
import '../../provider/user_provider.dart';
import '../../remote/response.dart';
import '../../widgets/image_portrait.dart';
import '../../widgets/rounded_icon_button.dart';
import '../bottom_navigation_screens/bottom_navigation_screen.dart';

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen({super.key, required this.userRegistration});
  final UserRegistration userRegistration;

  @override
  AddPhotoScreenState createState() => AddPhotoScreenState();
}

class AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  String? _imagePath;

  bool _isLoading = false;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  void registerUser(context) async {
    setState(() {
      _isLoading = true;
    });

    await _userProvider
        .registerUser(widget.userRegistration, _imagePath, context)
        .then((response) {
      if (response is Success) {
        Navigator.pop(context);
        Navigator.pushNamed(context, BottomNavigationScreen.id);
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  Future pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          shadowColor: Colors.black,
          backgroundColor: Colors.black,
          title: Text(
            'Profile Picture',
            style: TextStyle(color: yellow),
          ),
        ),
        body: CustomModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add photo',
                style: TextStyle(color: yellow, fontSize: 30),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: _imagePath == null
                              ? const ImagePortrait(imageType: ImageType.NONE)
                              : ImagePortrait(
                                  imagePath: _imagePath,
                                  imageType: ImageType.FILE_IMAGE,
                                ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: _imagePath == null
                                ? RoundedIconButton(
                                    onPressed: pickImageFromGallery,
                                    iconData: Icons.add,
                                    buttonColor: Colors.grey,
                                    iconSize: 20,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CRoundButton(
                function: () {
                  print(widget.userRegistration.localProfilePhotoPath);
                  _imagePath == null
                      ? showSnackBar('please select the image', context)
                      : registerUser(context);
                },
                text: 'Sign Up',
                color: yellow,
                textColor: black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
