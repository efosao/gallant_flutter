import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import '../store/images_store.dart';

class BreedDetails extends StatefulWidget {
  BreedDetails({this.name, this.secondaryBreeds});

  final String name;
  final List<String> secondaryBreeds;

  @override
  _BreedDetails createState() => _BreedDetails();
}

class _BreedDetails extends State<BreedDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesStore>(
      builder: (context, store, child) {
        final images = store.breedImages[widget.name];
        final maxPhotos = 8;
        int count = 1;

        final photoList = images.take(maxPhotos).map(
              (url) => Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  children: [
                    CachedNetworkImage(
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
                    Container(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text('${capitalize(widget.name)} ${count++}'),
                      ),
                    )
                  ],
                ),
              ),
            );

        var secondaryBreeds = widget.secondaryBreeds;

        return Scaffold(
          appBar: AppBar(
            title: Text(capitalize(widget.name)),
          ),
          body: Container(
            color: Colors.brown[100],
            child: ListView(
              children: [
                secondaryBreeds.isEmpty
                    ? Container()
                    : Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        padding: EdgeInsets.all(20),
                        child: Text(secondaryBreeds
                            .map((s) => capitalize(s))
                            .join(', ')),
                      ),
                ...photoList,
              ],
            ),
          ),
        );
      },
    );
  }
}
