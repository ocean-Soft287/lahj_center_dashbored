import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageList extends StatefulWidget {
  final bool isWide;

  const ImageList({super.key, required this.isWide});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  int selectedIndex = 0;

  final List<String> imageUrls = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdTaY5LvNFr-1pvAvWJ0ZSThKM87WYqM86Kw&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdTaY5LvNFr-1pvAvWJ0ZSThKM87WYqM86Kw&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdTaY5LvNFr-1pvAvWJ0ZSThKM87WYqM86Kw&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdTaY5LvNFr-1pvAvWJ0ZSThKM87WYqM86Kw&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdTaY5LvNFr-1pvAvWJ0ZSThKM87WYqM86Kw&s",
  ];

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return ListView.separated(
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            height: width<500? 60:100,
            decoration: BoxDecoration(
              color: isSelected ? Color(0xff65C565).withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [

              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrls[index],
                width:width<500? 60:100,
                height:width<500?  60:100,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: 30,);

    },
    );
  }
}
