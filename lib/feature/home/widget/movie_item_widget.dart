import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_startup.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../auth/model/movie_model.dart';
import '../../root/route/routes.dart';
import 'like_widget.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieModel movie;
  const MovieItemWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<NavigationService>().toWithParameters(
            routeName: RootRoutes.detailsPage, args: {"movie": movie});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 150.h,
              width: 150.w,
              decoration: const BoxDecoration(color: Colors.grey
                  // image: DecorationImage(image: NetworkImage(items[index].image!)

                  // )
                  ),
              child: CachedNetworkImage(
                imageUrl: movie.image!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20.0.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title!,
                    style: TextStyle(
                        fontSize: 16.0.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    movie.title!,
                    style: TextStyle(
                        fontSize: 10.0.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  Row(
                    children: [
                      LabelWidget(
                        text: movie.rank!,
                      ),
                      SizedBox(
                        width: 10.0.w,
                      ),
                      LabelWidget(text: movie.rankUpDown!)
                    ],
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.message_rounded,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10.0.w,
                      ),
                      Text("2"),
                      Spacer(),
                      LikeWidget(
                        movieModel: movie,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? borderColor;
  const LabelWidget(
      {Key? key, required this.text, this.icon, this.color, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30.0.h,
        // width: 70.0.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: color ?? Colors.grey,
            border: Border.all(color: borderColor ?? Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Row(
            children: [
              Visibility(
                visible: icon != null,
                child: Row(
                  children: [
                    Icon(icon),
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    color: borderColor ?? Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
