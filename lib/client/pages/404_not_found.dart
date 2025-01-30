import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mined_2025/client/providers/bucket_provider.dart';
import 'package:mined_2025/client/utils/text_feild/custom_text_feild.dart';
import 'package:provider/provider.dart';


class NotFound extends StatefulWidget {
  static const route = "/error";
  static const fullRoute = "/error";
  const NotFound({super.key});

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BucketsProvider>(builder: (context, bucketProvider, child) {
      return Container();
    });
  }
}
