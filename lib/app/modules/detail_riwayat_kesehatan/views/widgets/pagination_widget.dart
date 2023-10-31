import 'package:flutter/material.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class PaginationWidget extends StatelessWidget {
  final VoidCallback? next;
  final VoidCallback? previous;
  final int pageCount;
  final int totalItem;
  final int currentPage;
  final int limit;

  const PaginationWidget({
    super.key,
    this.next,
    this.previous,
    required this.pageCount,
    required this.limit,
    required this.currentPage,
    required this.totalItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Builder(builder: (context) {
          int offset = (currentPage - 1) * limit + 1;
          int offsetSampai = offset + limit - 1;
          return Text(
            "$offset - ${offsetSampai > totalItem ? totalItem : offsetSampai} dari $totalItem",
            style: const TextStyle(fontSize: 15),
          );
        }),
        Container(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              // Icon button
              if (currentPage != 1)
                GestureDetector(
                  onTap: previous,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ]),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                        color: AppColors.secondaryColor,
                      )),
                ),
              const SizedBox(
                width: 10.0,
              ),

              if (currentPage < pageCount)
                GestureDetector(
                  onTap: next,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ]),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 30,
                        color: AppColors.secondaryColor,
                      )),
                ),
            ],
          ),
        )
      ],
    );
  }
}
