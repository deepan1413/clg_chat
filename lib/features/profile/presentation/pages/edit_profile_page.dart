import 'dart:io';
import 'dart:typed_data';

import 'package:clg_chat/components/my_text_field.dart';
import 'package:clg_chat/features/profile/domain/entities/profile_user.dart';
import 'package:clg_chat/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:clg_chat/features/profile/presentation/cubits/profile_states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  PlatformFile? imagePickedFile;
  Uint8List? webImage;

  final bioTextController = TextEditingController();

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );
    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;
        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  Future<void> _updateBio() async {
    final user = context.read<ProfileCubit>();
    final String uid = widget.user.uid;
    final imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    final imageWebByte = kIsWeb ? imagePickedFile?.bytes : null;

    user.updateProfile(
      uid: widget.user.uid,
      newBio: bioTextController.text,
      imageMobilePath: imageMobilePath,
      imageWebBytes: imageWebByte,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        //
        if (state is ProfileLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: _updateBio, icon: Icon(Icons.upcoming)),
              ],
            ),
            body: Column(
              children: [
                MyTextfield(
                  controller: bioTextController,
                  hintText: widget.user.bio,
                ),
                TextButton(onPressed: pickImage, child: Text('data'))
              ],
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is ProfilelLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }
}
