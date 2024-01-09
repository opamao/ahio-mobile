import 'dart:convert';
import 'dart:io';

import 'package:ahio/themes/themes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/widgets.dart';
import '../residence.dart';

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    required this.isUploaded,
    required this.uploading,
    required this.imageFile,
    required this.imageUrl,
  });
}

class PhotoScreen extends StatefulWidget {
  final List<int>? equipement;
  final String? adresse, rue, quartier, type;
  int? pays, ville, personne, chambre, lit, salle;

  PhotoScreen({
    super.key,
    this.equipement,
    this.adresse,
    this.rue,
    this.quartier,
    this.type,
    this.pays,
    this.ville,
    this.personne,
    this.chambre,
    this.lit,
    this.salle,
  });

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late List<ImageUploadModel> images;
  List<List<int>> imageBase64List = [];
  List<String> imageType = [];
  List<String> imageNom = [];

  @override
  void initState() {
    super.initState();
    images = [];
  }

  Future<void> _selectImage(int index) async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();

      setState(() {
        if (index < images.length) {
          images[index] = ImageUploadModel(
            isUploaded: false,
            uploading: false,
            imageFile: File(imageFile.path),
            imageUrl: '',
          );
        } else {
          images.add(
            ImageUploadModel(
              isUploaded: false,
              uploading: false,
              imageFile: File(imageFile.path),
              imageUrl: '',
            ),
          );
        }
        final extension = imageFile.path.split('.').last;
        final nom = imageFile.path.split('/').last;
        imageBase64List.add(bytes);
        imageType.add(extension);
        imageNom.add(nom);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Hero(
            tag: "photo",
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Text(
                    "Pour mieux mettre en avant votre résidence, merci de sélection au moins 4 photos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Ajouter des photos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    children: List.generate(images.length + 1, (index) {
                      if (index < images.length) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: <Widget>[
                              Image.file(
                                images[index].imageFile,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: InkWell(
                                  child: const Icon(
                                    Icons.remove_circle,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return DottedBorder(
                          dashPattern: const [10, 6],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(15),
                          color: const Color(0xFF707070),
                          strokeWidth: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(.6),
                            ),
                            width: double.infinity,
                            height: double.infinity,
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 50,
                              ),
                              onPressed: () {
                                _selectImage(index);
                              },
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  const Gap(10),
                  SubmitButton(
                    "Suivant",
                    onPressed: () {
                      if (imageBase64List.length >= 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisponibiliteScreen(
                              equipement: widget.equipement!,
                              adresse: widget.adresse!,
                              rue: widget.rue!,
                              quartier: widget.quartier!,
                              type: widget.type!,
                              pays: widget.pays,
                              ville: widget.ville,
                              personne: widget.personne,
                              chambre: widget.chambre,
                              lit: widget.lit,
                              salle: widget.salle,
                              photos: imageBase64List,
                              photosType: imageType,
                              photosNom: imageNom,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Erreur",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                "Veuillez sélectionner au moins 4 photos.",
                                style: TextStyle(
                                  color: colorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      color: colorBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
