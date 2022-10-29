import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ErrorConatiner {
  getContainer(ErrorMessage, context) {
    return ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(
      content: Container(
        padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFFC72c41),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Align(
              alignment: Alignment(0, 0.3),
              child: Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Text(
              ErrorMessage,
              textDirection: TextDirection.rtl,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
