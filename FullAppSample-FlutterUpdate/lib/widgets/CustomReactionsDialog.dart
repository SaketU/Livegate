import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';  // Add this import for BackdropFilter

class CustomReactionsDialog extends StatefulWidget {
  final String id;
  final Widget messageWidget;
  final Function(String) onReactionTap;
  final Function(String) onContextMenuTap;
  final Alignment widgetAlignment;

  const CustomReactionsDialog({
    Key? key,
    required this.id,
    required this.messageWidget,
    required this.onReactionTap,
    required this.onContextMenuTap,
    this.widgetAlignment = Alignment.center,
  }) : super(key: key);

  @override
  State<CustomReactionsDialog> createState() => _CustomReactionsDialogState();
}

class _CustomReactionsDialogState extends State<CustomReactionsDialog> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _slideAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _fadeAnimations;
  
  final List<String> _reactions = ['❤️', '👍', '😂', '😮', '😢', '😡', 'add'];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controllers = List.generate(
      _reactions.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    _slideAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 15.0, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();

    _scaleAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();

    // Stagger the animations
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildReactionButton(String emoji, BuildContext context, int index) {
    return AnimatedBuilder(
      animation: _controllers[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimations[index].value),
          child: Transform.scale(
            scale: _scaleAnimations[index].value,
            child: Opacity(
              opacity: _fadeAnimations[index].value,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onReactionTap(emoji);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: emoji == 'add' 
                      ? Icon(CupertinoIcons.add, size: 25)
                      : Text(
                          emoji,
                          style: const TextStyle(fontSize: 25),
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(String label, IconData icon, BuildContext context, {bool isDelete = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          widget.onContextMenuTap(label.toLowerCase());
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: isDelete ? Colors.red : null,
                ),
              ),
              Icon(icon, size: 20, color: isDelete ? Colors.red : null),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height * 0.3,
                child: Hero(
                  tag: widget.id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Reactions row
                          GestureDetector(
                            onTap: () {}, // Prevent tap propagation
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  _reactions.length,
                                  (index) => _buildReactionButton(_reactions[index], context, index),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Message in the middle
                          GestureDetector(
                            onTap: () {}, // Prevent tap propagation
                            child: widget.messageWidget,
                          ),
                          const SizedBox(height: 8),
                          // Context menu
                          GestureDetector(
                            onTap: () {}, // Prevent tap propagation
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMenuItem('Reply', CupertinoIcons.reply, context),
                                  _buildMenuItem('Edit', CupertinoIcons.pencil_outline, context),
                                  _buildMenuItem('Delete', CupertinoIcons.delete, context, isDelete: true),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 