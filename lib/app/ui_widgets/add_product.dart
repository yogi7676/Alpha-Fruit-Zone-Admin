import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodbuddy/app/helper/assets_path.dart';
import 'package:foodbuddy/app/helper/notification_service.dart';
import 'package:foodbuddy/app/model/product.dart';
import 'package:foodbuddy/app/provider/repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  XFile? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  pickImage(source) async {
    XFile? pickimage = await Repository().selectImage(source);
    setState(() {
      image = pickimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Add New Product'),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ListTile(
                          title: Text('Note :'),
                          contentPadding: EdgeInsets.all(8),
                          subtitle: Text(
                              'Upload images with .png extension or transparent background from your gallery.'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Get.snackbar('Choose Image', '',
                                  snackPosition: SnackPosition.BOTTOM,
                                  messageText: Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text('Gallery'),
                                        onTap: () =>
                                            pickImage(ImageSource.gallery),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: const Text('Camera'),
                                        onTap: () =>
                                            pickImage(ImageSource.camera),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.cancel_sharp),
                                        title: const Text('Remove'),
                                        onTap: () {
                                          setState(() {
                                            image = null;
                                          });
                                        },
                                      ),
                                    ],
                                  ));
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1.0, color: Colors.grey)),
                              child: image != null
                                  ? ClipOval(
                                      child: SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Image(
                                            image: FileImage(File(image!.path)),
                                            fit: BoxFit.fill,
                                          )))
                                  : const Icon(Icons.image),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('Product Name'),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              hintText: 'e.g. Apple, Orange',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Product Name is Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (image != null &&
                                      formKey.currentState!.validate()) {
                                    UploadTask task = await Repository()
                                        .uploadFileToStorage(image!);
                                    task.snapshotEvents.listen((event) {
                                      NotificationService()
                                          .showProgressNotification(
                                              0,
                                              'Uploading Product Image',
                                              '',
                                              event.totalBytes.toInt(),
                                              event.bytesTransferred.toInt());
                                    });
                                    await task.whenComplete(() async {
                                      /*imageUrl = await task.snapshot.ref
                                          .getDownloadURL();*/

                                      await Repository()
                                          .addDataToDb(
                                              'Products',
                                              Product(
                                                  imageUrl: await task
                                                      .snapshot.ref
                                                      .getDownloadURL(),
                                                  productName:
                                                      nameController.text))
                                          .whenComplete(() {
                                        setState(() {
                                          image = null;

                                          NotificationService()
                                              .cancelAllNotifications();
                                          NotificationService()
                                              .showSimpleNotification(
                                                  0,
                                                  'Product ${nameController.text} Added Successfully',
                                                  '');
                                          nameController.clear();
                                        });
                                      });
                                    });
                                  } else if (image == null) {
                                    Get.snackbar('Product Image Info',
                                        'Image cannot be empty.',
                                        colorText: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                },
                                child: const Text('Done')))
                      ],
                    ))
              ],
            )));
  }
}

/*
ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(
              width: double.infinity,
              height: 200,
              child: Image(image: AssetImage(AssetsPath.image4))),
          const ListTile(
            title: Text('Note :'),
            contentPadding: EdgeInsets.all(8),
            subtitle: Text(
                'Upload images with .png extension or transparent background from your gallery.'),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
                onPressed: () async {
                  XFile? pickimage =
                      await Repository().selectImage(ImageSource.gallery);
                  setState(() {
                    image = pickimage;
                  });
                },
                child: const Text('Pick image')),
          ),
          image != null
              ? SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(
                    image: FileImage(File(image!.path)),
                    fit: BoxFit.fitWidth,
                  ),
                )
              : Container(),
          const SizedBox(
            height: 20,
          ),
          const Text('Product Name'),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
                hintText: 'e.g. Apple, Orange',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Product Name is Required';
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await Repository().uploadFileToStorage(image!);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () async {
                    await Repository().uploadFileToStorage(image!);
                  },
                  child: const Text('Done')),
            ],
          )
        ],
      ),
      */