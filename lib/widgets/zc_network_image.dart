import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ZCNetworkImage extends StatelessWidget {
  ZCNetworkImage(this.url,{this.fit = BoxFit.cover});
  final String url;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
