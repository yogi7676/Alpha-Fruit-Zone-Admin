import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  File? pickedFile;
  final GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();

  openBottomSheet(bool adding) {
    scaffoldKey.currentState!.showBottomSheet((context) => SizedBox(
      height:500,
      child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Center(
                          child: Text(
                        'Add New Product',
                        style: GoogleFonts.roboto(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('Add Image')),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              hintText: 'enter product name',
                              fillColor: Colors.grey.shade300),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(onPressed: (){}, child: Text('Cancel')),
                            ElevatedButton(onPressed: (){}, child: Text('Cancel')),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
    ));
    /*showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (context) => Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Center(
                        child: Text(
                      'Add New Product',
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add Image')),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            hintText: 'enter product name',
                            fillColor: Colors.grey.shade300),
                      )
                    ],
                  ),
                )
              ],
            ));*/
    //showBottomSheet(context: context, builder: (context) => Container());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: const Text('Products')),
      floatingActionButton: FloatingActionButton(
          onPressed: () => openBottomSheet(false),
          child: const Icon(Icons.add_rounded)),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Products').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    leading: CircleAvatar(
                      child: CachedNetworkImage(
                          imageUrl: data[index]['imageUrl'],
                          placeholder: (context, url) =>
                              const CupertinoActivityIndicator()),
                    ),
                    title: Text(data[index].id),
                  ));
                });
          }

          return Container();
        },
      ),
    );
    /*return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    child: const Text(
                      'Add New Product',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Note : All Fields are mandatory.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: pickedFile != null
                              ? MainAxisAlignment.spaceAround
                              : MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Pick Image')),
                            pickedFile != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    child: Image(
                                      image: FileImage(pickedFile!),
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Text('Name : '),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                                filled: true,
                                hintText: 'enter product name',
                                fillColor: Colors.grey.shade200,
                                border: InputBorder.none),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add')),
                        width: double.infinity,
                      )
                    ],
                  )),
                ),
              ],
            ),
            const Divider(
               thickness: 2,
            ),
            const SizedBox(
              width: double.infinity,
              child: Card(color: Colors.teal,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Text('Our Products',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future:
                        FirebaseFirestore.instance.collection('Products').get(),
                    builder: (context, snap) {
                      if (snap.hasData &&
                          snap.connectionState == ConnectionState.done) {
                        final d = snap.data!.docs;
                        return ListView.builder(
                            itemCount: d.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          /*CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      "assets/gif/loading.gif",
                                                  image: d[index]['imageUrl'])),*/

                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: CachedNetworkImage(
                                              imageUrl: d[index]['imageUrl'],
                                              placeholder: (context, url) =>
                                                  Container(
                                                width: 10,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/gif/loading.gif'))),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(d[index].id),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blueGrey,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      return Container();
                    }))
          ],
        )
        );*/
  }
}
