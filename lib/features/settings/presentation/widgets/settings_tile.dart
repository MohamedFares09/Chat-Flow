import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class SettingsTile extends StatefulWidget {
  const SettingsTile({
    required this.icon,
    required this.title,
    this.hasSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    super.key,
  });

  final IconData icon;
  final String title;
  final bool hasSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.switchValue;
  }

  @override
  void didUpdateWidget(covariant SettingsTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.switchValue != widget.switchValue) {
      value = widget.switchValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(widget.icon, color: AppColors.body, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.title,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
            if (widget.hasSwitch)
              Switch(
                value: value,
                activeColor: Colors.white,
                activeTrackColor: AppColors.accent,
                inactiveThumbColor: AppColors.body,
                inactiveTrackColor: AppColors.input,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (newValue) {
                  setState(() => value = newValue);
                  widget.onSwitchChanged?.call(newValue);
                },
              )
            else
              Icon(
                Icons.chevron_right,
                color: AppColors.body,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
