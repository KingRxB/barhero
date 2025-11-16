import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const StatRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label (e.g., "Total Kills")
          Flexible(
            flex: 2, // Give label 2/5 of the space
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 16), // Safety spacing
          // Value (e.g., "150")
          Flexible(
            flex: 3, // Give value 3/5 of the space
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
