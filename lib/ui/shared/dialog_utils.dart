import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Are you sure about that?'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}
/*
Hàm showDialog(context, builder): hiển thị một hộp thoại 
phía trên nội dung hiện thời. Tham số builder là hàm tạo widget Dialog.
Hai dạng widget Dialog phổ biến: AlertDialog và SimpleDialog. Các
thuộc tính quan trọng của một AlertDialog là title: tựa đề hội thoại, 
content: nội dung chính hội thoại
và actions: dòng các nút tương tác với hội thoại.
*/