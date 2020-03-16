import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doggopedia/components/breed_details.dart';
import 'package:flutter_doggopedia/models/breed_images.dart';
import 'package:flutter_doggopedia/store/images.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../services.dart' as svcs;

class BreedListRow extends StatefulWidget {
  BreedListRow({Key key, this.name}) : super(key: key);

  final String name;

  @override
  _BreedListRow createState() => _BreedListRow(name: this.name);
}

class _BreedListRow extends State<BreedListRow> {
  String name;

  _BreedListRow({this.name});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesStore>(
      builder: (context, store, child) {
        final imagesList = store.breedImages[name];
        var imagesListSize = 0;
        if (imagesList != null) {
          imagesListSize = imagesList.length;
        }

        Future<void> setDogImgUrl() async {
          BreedImages images = await svcs.getBreedImages(this.name);
          store.add(name, images.message);
        }

        var imgUrl = '';
        if ((store.breedImages[name] != null) &&
            (store.breedImages.length > 0)) {
          imgUrl = store.breedImages[name][0];
        }

        return VisibilityDetector(
          key: Key(name),
          child: Container(
            color: Colors.brown[50],
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                height: 100,
                width: 100,
                child: ColoredBox(
                  color: Colors.brown[200],
                  child: imgUrl == ''
                      ? null
                      : CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 300),
                          imageUrl: imgUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: CircularProgressIndicator()),
                              ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                ),
              ),
              title: Text(
                capitalize(name),
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              trailing: Icon(
                Icons.play_arrow,
                color: Colors.brown[700],
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BreedDetails(
                      name: name,
                    ),
                  ),
                ),
              },
            ),
          ),
          onVisibilityChanged: (VisibilityInfo info) {
            if (imagesListSize == 0 && info.visibleFraction > 0.2) {
              setDogImgUrl();
            }
          },
        );
      },
    );
  }
}
