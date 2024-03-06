import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/src/home_screen/model/news_model.dart';

import '../../utils/app_color.dart';
import '../home_screen/controller/home_controller.dart';

class NewsDetailScreen extends StatefulWidget {
  Articles artical;

  NewsDetailScreen({super.key, required this.artical});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.find();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Image.network(
                  widget.artical.urlToImage!,
                  height: 400,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 18.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        size: 32,
                        color: AppColor.white,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.share,
                      size: 20,
                      color: AppColor.white,
                    ),
                    const SizedBox(width: 28),
                    GestureDetector(
                      onTap: () {
                        newsController.setAsFavouriteByItem(widget.artical);
                      },
                      child: Obx(() {
                        return Icon(
                          widget.artical.isFavourite.value ? Icons.bookmark : Icons.bookmark_border,
                          color: AppColor.dark_orange,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                  child: Row(
                    children: [
                      Text(
                        Jiffy.parseFromDateTime(DateTime.parse(widget.artical.publishedAt!)).fromNow(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.comment,
                        size: 20,
                        color: AppColor.white,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '12',
                        style: TextStyle(color: AppColor.white, fontSize: 12),
                      ),
                      const SizedBox(width: 24),
                      const Icon(
                        Icons.remove_red_eye,
                        size: 20,
                        color: AppColor.white,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '916',
                        style: TextStyle(color: AppColor.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // const SizedBox(height: 12),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        color: AppColor.dark_orange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(widget.artical.title ?? '')),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.artical.content ?? '',
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
