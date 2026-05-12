import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/widgets/custom_button.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';

class EditMessageSheet extends StatefulWidget {
  const EditMessageSheet({required this.message, super.key});

  final MessageEntity message;

  @override
  State<EditMessageSheet> createState() => _EditMessageSheetState();
}

class _EditMessageSheetState extends State<EditMessageSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.message.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Message',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.title,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                autofocus: true,
                cursorColor: AppColors.accent,
                style: TextStyle(color: AppColors.title),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.input,
                  hintText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Save Changes',
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isEmpty) {
                    return;
                  }
                  Navigator.pop(context, text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
