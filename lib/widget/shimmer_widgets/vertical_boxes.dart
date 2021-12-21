import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:shimmer/shimmer.dart';

shimmers() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        heightSpace(20),
        shimmerContainer(),
        heightSpace(20),
        shimmerContainer(),
        heightSpace(20),
        shimmerContainer(),
        heightSpace(20),
        shimmerContainer(),
        heightSpace(20),
        shimmerContainer(),
        heightSpace(20),
        shimmerContainer(),
        heightSpace(20),
        shimmerContainer(),
        heightSpace(20),
      ],
    ),
  );
}

shimmerContainer() => Shimmer.fromColors(
      baseColor: kGrayLight,
      highlightColor: kWhite,
      child: Container(
          width: 320,
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: kWhite)),
    );
