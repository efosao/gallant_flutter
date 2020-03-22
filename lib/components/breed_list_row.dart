import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doggopedia/components/breed_details.dart';
import 'package:flutter_doggopedia/models/breed_images.dart';
// import 'package:flutter_doggopedia/store/counter_store.dart';
import 'package:flutter_doggopedia/store/images_store.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../services.dart' as svcs;

class BreedListRow extends StatefulWidget {
  BreedListRow({Key key, this.name, this.secondaryBreeds}) : super(key: key);

  final List<String> secondaryBreeds;
  final String name;

  @override
  _BreedListRow createState() => _BreedListRow();
}

class _BreedListRow extends State<BreedListRow> {
  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    return Consumer<ImagesStore>(builder: (_, imagesStore, child) {
      final imagesList = imagesStore.breedImages[name] ?? [];

      Future<void> setDogImgUrl() async {
        BreedImages images = await svcs.getBreedImages(name);
        imagesStore.add(name, images.message);
      }

      var imgUrl = '';
      if ((imagesStore.breedImages[name] != null) &&
          (imagesStore.breedImages.length > 0)) {
        imgUrl = imagesStore.breedImages[name][0];
      }

      final secondaryBreeds = widget.secondaryBreeds;
      final breedCount = secondaryBreeds != null && secondaryBreeds.isEmpty ? 0 : secondaryBreeds.length;

      return VisibilityDetector(
        key: Key(name),
        child: Container(
          color: Colors.white70,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: SizedBox(
              height: 50,
              width: 50,
              child: Container(
                color: Colors.brown,
                child: imgUrl == ''
                    ? null
                    : CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 300),
                        imageUrl: imgUrl,
                        fit: BoxFit.cover,
                        height: 75,
                        width: 75,
                        placeholder: (context, url) => Padding(
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
              '${capitalize(name)} ${breedCount == 0 ? '' : '($breedCount)'}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: (secondaryBreeds.isEmpty
                ? Text('...')
                : Text(
                    secondaryBreeds
                        .take(4)
                        .map((s) => capitalize(s))
                        .join(', '),
                    overflow: TextOverflow.fade,
                  )),
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
                    secondaryBreeds: widget.secondaryBreeds,
                  ),
                ),
              ),
            },
          ),
        ),
        onVisibilityChanged: (VisibilityInfo info) {
          if (imagesList.isEmpty && info.visibleFraction > 0.2) {
            setDogImgUrl();
          }
        },
      );
    });
  }
}
