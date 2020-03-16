import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import '../store/images.dart';

class BreedDetails extends StatefulWidget {
  BreedDetails({this.name});

  final String name;

  @override
  _BreedDetails createState() => _BreedDetails();
}

class _BreedDetails extends State<BreedDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesStore>(
      builder: (context, store, child) {
        var images = store.breedImages[widget.name];

        var imagesList = images.take(5).map(
              (url) => CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 300),
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, url) => SizedBox(
                  width: 80,
                  height: 80,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            );

        return Scaffold(
          appBar: AppBar(
            title: Text(capitalize(widget.name)),
          ),
          body: ListView(
            children: <Widget>[...imagesList],
          ),
        );
      },
    );
  }
}
