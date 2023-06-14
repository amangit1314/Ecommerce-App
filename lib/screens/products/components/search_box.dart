import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onClear,
  }) : super(key: key);

  final TextEditingController searchController;
  final Function(String query) onSearch;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 50,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 12),
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search for products ...',
                hintStyle: TextStyle(fontSize: 12),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 15,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
              ),
              onSubmitted: onSearch,
            ),
          ),
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () => onSearch(searchController.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
