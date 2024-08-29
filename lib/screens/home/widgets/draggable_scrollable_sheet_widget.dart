import 'package:flutter/material.dart';

class DraggableScrollableSheetWidget extends StatefulWidget {
  const DraggableScrollableSheetWidget({super.key});

  @override
  _DraggableScrollableSheetWidgetState createState() =>
      _DraggableScrollableSheetWidgetState();
}

class _DraggableScrollableSheetWidgetState
    extends State<DraggableScrollableSheetWidget> {
  int selectedAvatarIndex = -1; // -1 means no avatar is selected

  final double maxScrollHeight = 0.9;
  final double minScrollHeight = 0.8;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: maxScrollHeight,
      minChildSize: minScrollHeight,
      maxChildSize: maxScrollHeight,
      snap: true,
      expand: false,
      snapAnimationDuration: const Duration(milliseconds: 150),
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Color(0xFFFFFFFF), // White background
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar indicator
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Back')),
                    const Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Done')),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nickname',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Pluddie',
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Avatar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  padding: const EdgeInsets.only(top: 8),
                  children: List.generate(8, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatarIndex = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: selectedAvatarIndex == index
                            ? Colors.blueAccent
                            : Colors.blueGrey[100],
                        child: Icon(
                          Icons.person,
                          color: selectedAvatarIndex == index
                              ? Colors.white
                              : Colors.grey[700],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
