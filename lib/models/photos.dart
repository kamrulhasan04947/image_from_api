class Photos {
  final int albumId, id;
  final String title, url, thumbnailUrl;

  const Photos({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

}

List<Photos> photos = [];