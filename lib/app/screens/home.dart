import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodbuddy/app/model/product.dart';
import 'package:foodbuddy/app/ui_widgets/add_product.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => const AddProduct()),
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('products').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Loading'),
                        SizedBox(
                          width: 15,
                        ),
                        CupertinoActivityIndicator(),
                      ],
                    ),
                  );
                } else if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data!.docs;
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Product product = Product.fromJson(data[index]);
                        return Card(
                          child: ListTile(
                            title: Text(product.productName!),
                            leading: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: product.imageUrl!,
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(),
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        );
                      });
                }

                return Container();
              },
            ),
            onRefresh: refresh));
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {});
  }
}
