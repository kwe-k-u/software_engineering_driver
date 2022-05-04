import 'dart:io';

import 'package:flutter/material.dart';


class ProfileImage extends StatelessWidget {
  final dynamic image;
  final void Function()? onTap;
  const ProfileImage({required this.image, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        maxRadius: 25,
        minRadius: 20,
        backgroundImage: showImage(),
        child: showImage() == null ? const Icon(Icons.account_circle_outlined) : null,
      ),
      onTap: onTap,
    );
  }

  ImageProvider? showImage(){
    switch (image.runtimeType){
      case File:
        return Image.file(image).image;
      case String:
        return Image.network(image).image;
      default:
        return null;
    }
  }
}
