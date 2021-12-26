import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

customImage(String imageUrl, {BoxFit? boxFit}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => const CupertinoActivityIndicator(),
    fit: boxFit ?? BoxFit.fill,
  );
}