import 'package:flutter/material.dart';

class ApplicationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const ApplicationAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ) ,
      ),
      titleSpacing: 10,
      backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 1,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);
}
