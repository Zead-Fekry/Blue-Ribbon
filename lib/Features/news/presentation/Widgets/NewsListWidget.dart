import 'package:flutter/material.dart';

import '../../data/models/news.dart';

class NewsListWidget extends StatelessWidget {
  final List<NewsArticle> news;

  const NewsListWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final article = news[index];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: article.urlToImage.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(article.urlToImage, width: 80, height: 80, fit: BoxFit.cover),
            )
                : const Icon(Icons.image_not_supported, size: 80),
            title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(
                  "Published: ${article.publishedAt.toLocal()}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            onTap: () {
              // Handle news article click (e.g., open in WebView)
            },
          ),
        );
      },
    );
  }
}
