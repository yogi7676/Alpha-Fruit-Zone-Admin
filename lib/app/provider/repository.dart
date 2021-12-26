import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodbuddy/app/model/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  late Reference reference;
  late FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late FirebaseFirestore firestore = FirebaseFirestore.instance;
  late FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Product product;

  ImagePicker picker = ImagePicker();

  Future<XFile?> selectImage(ImageSource source) async {
    XFile? file = await picker.pickImage(source: source);
    return file;
  }

  Future<UploadTask> uploadFileToStorage(XFile file) async {
    reference = firebaseStorage.ref().child("Products").child(file.name);
    UploadTask task = reference.putFile(File(file.path));
    //task.snapshotEvents.listen((event) {});

    return task;

    /*await task.whenComplete(() async {
      return await task.snapshot.ref.getDownloadURL();
    });

    return null;*/
  }

  Future createUser(String email, String password) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future login(String email, String password) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<DocumentReference> addDataToDb(
      String collection, Product model) async {
    product = model;
    return await firestore.collection(collection).add(product.toMap(product)!);
  }

  Future deleteProduct(String imageUrl) async{
    return await firebaseStorage.refFromURL(imageUrl).delete();
  }
}
