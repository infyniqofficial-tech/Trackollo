import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  // State for View Mode (Grid vs List)
  var isGridView = true.obs;

  // State for Tabs (0 = All, 1 = Image, 2 = Video)
  var selectedTabIndex = 0.obs;

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Getter to filter items based on selected tab
  List<Map<String, dynamic>> get filteredItems {
    if (selectedTabIndex.value == 1) {
      return allMediaItems.where((item) => item['type'] == 'IMG').toList();
    } else if (selectedTabIndex.value == 2) {
      return allMediaItems.where((item) => item['type'] == 'VID').toList();
    }
    return allMediaItems;
  }

  // Updated Mock Data with details for List View
  final List<Map<String, dynamic>> allMediaItems = [
    {
      "title": "product-shot-01.jpg",
      "date": "Dec 1",
      "type": "IMG",
      "tags": ["#product", "#summer", "#fashion"],
      "url": "https://images.unsplash.com/photo-1523381210434-271e8be1f52b?q=80&w=300",
    },
    {
      "title": "bts-reel.mp4",
      "date": "Dec 2",
      "type": "VID",
      "tags": ["#video", "#bts", "#reel"],
      "url": "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=300",
    },
    {
      "title": "holiday-promo.jpg",
      "date": "Dec 3",
      "type": "IMG",
      "tags": ["#holiday", "#sale", "#promo"],
      "url": "https://images.unsplash.com/photo-1513885535751-8b9238bd345a?q=80&w=300",
    },
    {
      "title": "clearance-ad.jpg",
      "date": "Dec 4",
      "type": "IMG",
      "tags": ["#ad", "#clearance", "#sale"],
      "url": "https://images.unsplash.com/photo-1611591437281-460bfbe1220a?q=80&w=300",
    },
    {
      "title": "testimonial.jpg",
      "date": "Dec 5",
      "type": "IMG",
      "tags": ["#testimonial", "#customer"],
      "url": "https://images.unsplash.com/photo-1556742049-0cfed4f7a07d?q=80&w=300",
    },
    {
      "title": "spring-collection.jpg",
      "date": "Dec 6",
      "type": "IMG",
      "tags": ["#spring", "#fashion"],
      "url": "https://images.unsplash.com/photo-1534126511673-b6899657816a?q=80&w=300",
    },
    {
      "title": "nature-vibe.mp4",
      "date": "Dec 7",
      "type": "VID",
      "tags": ["#nature", "#vibes"],
      "url": "https://images.unsplash.com/photo-1518609878373-06d740f60d8b?q=80&w=300",
    },
  ];

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}