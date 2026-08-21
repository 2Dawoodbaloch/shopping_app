import 'package:flutter/material.dart';
import 'package:shopping_app/utils/constants/texts.dart';

class UChangeNameHeader extends StatelessWidget {
  const UChangeNameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// title 
  
        Text(
          UTexts.updateText,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
