
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_from_api/screens/widgets/app_appbar.dart';

import '../models/photos.dart';
import 'imagedetails.dart';

class PhotoGalary extends StatefulWidget {
  const PhotoGalary({super.key});

  @override
  State<PhotoGalary> createState() => _PhotoGalaryState();
}

class _PhotoGalaryState extends State<PhotoGalary> {
  @override
  void initState() {
    super.initState();
    _getImage();
  }
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: const ApplicationAppBar(title: 'Photo Galary App',),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20, top: 1),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1),
          ),
          child: photos.isEmpty
              ? const CircularProgressIndicator(
                  color: Colors.orange,
              )
              : ListView.separated(
              itemBuilder: (context, index){

                return _imageholder(photos[index], context);
              },
              separatorBuilder: (BuildContext context, int index) => orientation == Orientation.portrait? const SizedBox(
                height: 0,
              ):const SizedBox(
                height: 15,
              ),
              itemCount: photos.length
          ),
        )
    );
  }

  Widget _imageholder(Photos image, BuildContext context ){
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailsPage(
              imageUrl: image.url,
              imageTitle: image.title,
              imageId: image.id,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.1,
              child: Container(
                width:100,
                height: 100,
                decoration:BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image.thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: orientation == Orientation.portrait ? 3 : 5,
            child: Container(
              height: 100,
              width: screenWidth * .80,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              color: const Color.fromRGBO(250, 250, 250, 1),
              child: Text(
                image.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:  FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getImage()async{
    setState(() {
      photos.clear();
    });
    const String apiUrl = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(apiUrl);
    try{
      final http.Response response = await http.get(uri);
      if(response.statusCode == 200 ){
        List<dynamic> jsonImages = jsonDecode(response.body);
        List<Photos> loadedPhotos = [];
        for(Map<String, dynamic> image in jsonImages){
          Photos loadablePhotos = Photos(
              albumId: image['albumId'] ?? 0,
              id: image['id'] ?? 0,
              title: image['title']?? '',
              url: image['url'] ?? '',
              thumbnailUrl: image['thumbnailUrl'] ?? '',
          );

          loadedPhotos.add(loadablePhotos);
        }
        setState(() {
          photos = loadedPhotos;
        });
      }else{
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong...')),
          );
        }
      }
    }catch(e){
       if(mounted){
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('An error occurred: $e')),
         );
       }
    }
  }

}

