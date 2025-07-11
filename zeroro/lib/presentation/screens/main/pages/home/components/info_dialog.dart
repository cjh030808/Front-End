import 'package:flutter/material.dart';

class CustomInfoDialog extends StatefulWidget {
  final String title;
  final String content;
  final ValueChanged<bool> onClose;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onClose,
  });

  @override
  State<CustomInfoDialog> createState() => _CustomInfoDialogState();
}

class _CustomInfoDialogState extends State<CustomInfoDialog> {
  bool _dontShowAgain = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.content,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left, // 설명문 왼쪽 정렬
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _dontShowAgain = !_dontShowAgain;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _dontShowAgain ? Colors.green : Colors.transparent,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _dontShowAgain
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      const Text('다시 보지 않기'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onClose(_dontShowAgain);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('닫기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
