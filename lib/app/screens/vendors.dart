import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodbuddy/app/config/constants.dart';
import 'package:foodbuddy/app/model/product.dart';
import 'package:foodbuddy/app/model/vendor.dart';
import 'package:foodbuddy/app/ui_widgets/custom_image.dart';
import 'package:foodbuddy/app/ui_widgets/custom_text.dart';
import 'package:foodbuddy/app/ui_widgets/space.dart';

class Vendors extends StatefulWidget {
  const Vendors({Key? key}) : super(key: key);

  @override
  _VendorsState createState() => _VendorsState();
}

class _VendorsState extends State<Vendors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('vendors').get(),
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
                      Vendor vendor = Vendor.fromFirestore(data[index]);
                      return Container(
                          alignment: Alignment.center,
                          height: 150,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    offset: const Offset(3, 2),
                                    blurRadius: 7)
                              ]),
                          child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 90,
                                    height: 90,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: customImage(
                                        vendor.imageUrl!,
                                      ),
                                    ),
                                  ),
                                  const Space(),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        CustomText(
                                            text: vendor.businessName!,
                                            weight: FontWeight.w600,
                                            size: 15),
                                        const Space(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              size: 15,
                                            ),
                                            const Space(),
                                            CustomText(
                                                text: vendor.getFullName(),
                                                size: 12)
                                          ],
                                        ),
                                        const Space(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 15,
                                            ),
                                            const Space(),
                                            Flexible(
                                              child: CustomText(
                                                  text: vendor.getAddress(),
                                                  overflow: TextOverflow.clip,
                                                  size: 12),
                                            )
                                          ],
                                        ),
                                        const Space(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              size: 15,
                                            ),
                                            const Space(),
                                            CustomText(
                                                text: vendor.phoneNumber!,
                                                size: 12)
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )));
                      /*
                      return Card(
                        child: ListTile(
                          title:
                              Text(Product.fromJson(data[index]).productName!),
                          /*trailing: IconButton(
                                onPressed: () async {
                                  await Repository()
                                      .deleteProduct(
                                          Product.fromJson(data[index])
                                              .imageUrl!)
                                      .whenComplete(() async {
                                    String name = Product.fromJson(data[index])
                                        .productName!;
                                    await FirebaseFirestore.instance
                                        .collection('Products')
                                        .doc(data[index].id)
                                        .delete()
                                        .whenComplete(() {
                                      NotificationService()
                                          .cancelAllNotifications();
                                      NotificationService()
                                          .showSimpleNotification(
                                              0, 'Product $name Deleted', '');
                                      setState(() {});
                                    });
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                )),
                            */
                          leading: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: Product.fromJson(data[index]).imageUrl!,
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      );
                    */
                    });
              }

              return Container();
            },
          ),
          onRefresh: refresh),
    );
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {});
  }
}
