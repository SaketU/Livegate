import 'package:flutter/material.dart';


class ReactionsDialogWidget extends StatelessWidget {
  final String id;
  final Widget messageWidget;
  final Function(String) onReactionTap;
  final Function(dynamic) onContextMenuTap;
  final Alignment widgetAlignment;

  const ReactionsDialogWidget({
    Key? key,
    required this.id,
    required this.messageWidget,
    required this.onReactionTap,
    required this.onContextMenuTap,
    this.widgetAlignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Align(
        alignment: widgetAlignment,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Reactions row
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildReactionButton('❤️', onReactionTap),
                      _buildReactionButton('👍', onReactionTap),
                      _buildReactionButton('😂', onReactionTap),
                      _buildReactionButton('😮', onReactionTap),
                      _buildReactionButton('😢', onReactionTap),
                      _buildReactionButton('➕', onReactionTap),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                // Context menu
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMenuItem('Reply', Icons.reply, onContextMenuTap),
                      _buildMenuItem('Copy', Icons.copy, onContextMenuTap),
                      _buildMenuItem('Report', Icons.flag, onContextMenuTap),
                      _buildMenuItem('Delete', Icons.delete, onContextMenuTap, isDelete: true),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                messageWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReactionButton(String emoji, Function(String) onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onTap(emoji),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            emoji,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String label, IconData icon, Function(dynamic) onTap, {bool isDelete = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          onTap(label.toLowerCase());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: isDelete ? Colors.red : null),
              const SizedBox(width: 12),
              Text(label, style: isDelete ? TextStyle(color: Colors.red) : null),
            ],
          ),
        ),
      ),
    );
  }
} 