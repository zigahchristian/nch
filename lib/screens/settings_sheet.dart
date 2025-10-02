import 'package:flutter/material.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:provider/provider.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HymnalModel>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Text size'),
              Expanded(
                child: Slider(
                  value: model.textScale,
                  min: 0.8,
                  max: 2.0,
                  onChanged: (v) => model.setTextScale(v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
