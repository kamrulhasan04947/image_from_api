import 'package:flutter/material.dart';
import 'package:image_from_api/screens/widgets/app_appbar.dart';

class ImageDetailsPage extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;
  final int imageId;
  const ImageDetailsPage({
    super.key,
    required this.imageId,
    required this.imageUrl,
    required this.imageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApplicationAppBar(title: 'Photo Details',),
      body: OrientationBuilder(builder: (BuildContext context, Orientation orientation){
        return (orientation == Orientation.portrait) ? _potraitView(orientation): _landscapeView(orientation);
      }),
    );
  }

  Widget _potraitView(Orientation orientation){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: Container(
                height: 600,
                width: 600,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Title: $imageTitle',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'ID: $imageId',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _landscapeView(Orientation orientation){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Container(
                  height: 600,
                  width: 600,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Title: $imageTitle',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'ID: $imageId',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
