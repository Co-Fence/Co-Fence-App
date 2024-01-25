import 'package:co_fence/common/const/colors.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onSearchPressed;
  const SearchButton({
    super.key,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSearchPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: const BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
        child: const Center(
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
