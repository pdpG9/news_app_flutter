
import 'package:flutter/material.dart';
import 'package:news_app_flutter/utils/colors.dart';

class SearchView extends StatelessWidget {
  final String hint;
  final bool isEnable;
  final TextEditingController controller;
  const SearchView({Key? key, required this.hint,required this.controller, required this.isEnable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: backgroundColor, width: 1)),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:  SizedBox(
        height: 16,
        child: Center(
          child: TextField(
            enabled: isEnable,
            controller: controller,
            maxLines: 1,
            style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: lightGrey),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: lightGrey),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
