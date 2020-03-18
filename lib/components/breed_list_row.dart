import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doggopedia/components/breed_details.dart';
import 'package:flutter_doggopedia/models/breed_images.dart';
import 'package:flutter_doggopedia/store/counter_store.dart';
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
    return Consumer<ImagesStore>(
      builder: (_, imagesStore, child) {
        return Consumer<CounterStore>(
          builder: (_, counterStore, child2) {
            final imagesList = imagesStore.breedImages[name];
            var imagesListSize = 0;
            if (imagesList != null) {
              imagesListSize = imagesList.length;
            }

            Future<void> setDogImgUrl() async {
              BreedImages images = await svcs.getBreedImages(name);
              imagesStore.add(name, images.message);
              counterStore.increment();
            }

            var imgUrl = '';
            if ((imagesStore.breedImages[name] != null) &&
                (imagesStore.breedImages.length > 0)) {
              imgUrl = imagesStore.breedImages[name][0];
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
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                    ),
                  ),
                  title: Text(
                    '${capitalize(name)} (${counterStore.count})',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(widget.secondaryBreeds.map((s) => capitalize(s)).join(', ')),
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
                if (imagesListSize == 0 && info.visibleFraction > 0.2) {
                  setDogImgUrl();
                }
              },
            );
          },
        );
      },
    );
  }
}
