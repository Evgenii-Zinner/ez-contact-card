library ez_contact_card;

import 'package:flutter/material.dart';
import 'package:ez_circle_avatar/ez_circle_avatar.dart';

/// A customizable contact card widget composed of an avatar, name, subtitle, and an optional tail widget.
///
/// This widget follows the composition of:
/// [Avatar] - [Gap] - [Name + Subtitle] - [Gap] - [Tail]
///
/// It provides extensive customization options for styling, interaction, and layout.
class EzContactCard extends StatelessWidget {
  /// The name to display as the main headline.
  final String name;

  /// An optional subtitle to display below the name.
  final String? subtitle;

  /// The avatar widget to display on the left.
  /// Usually an [EzCircleAvatar].
  final Widget avatar;

  /// An optional widget to display on the right side (e.g., an icon or button).
  final Widget? tail;

  // --- Interaction ---

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Callback when the card is long-pressed.
  final VoidCallback? onLongPress;

  /// The splash color of the ink response.
  final Color? splashColor;

  /// The highlight color of the ink response.
  final Color? highlightColor;

  /// The hover color of the ink response.
  final Color? hoverColor;

  /// The focus color of the ink response.
  final Color? focusColor;

  // --- Container Styling ---

  /// The decoration to paint behind the child.
  /// Use this to add background color, border, borderRadius, box shadow, etc.
  final BoxDecoration? decoration;

  /// Empty space to surround the [decoration] and child.
  final EdgeInsetsGeometry? margin;

  /// The padding for the content inside the card.
  /// Defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)`.
  final EdgeInsetsGeometry contentPadding;

  /// The clip behavior when [decoration] is not null.
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  // --- Text Styling ---

  /// The style to use for the name text.
  /// If null, defaults to `Theme.of(context).textTheme.titleMedium` with `FontWeight.w500`.
  final TextStyle? nameStyle;

  /// The style to use for the subtitle text.
  /// If null, defaults to `Theme.of(context).textTheme.bodyMedium` with `ColorScheme.onSurfaceVariant`.
  final TextStyle? subtitleStyle;

  /// The maximum number of lines for the name. Defaults to 1.
  final int nameMaxLines;

  /// The maximum number of lines for the subtitle. Defaults to 1.
  final int subtitleMaxLines;

  // --- Layout ---

  /// The gap between the avatar, the text column, and the tail.
  /// Defaults to 16.0.
  final double gap;

  /// How the children should be placed along the cross axis.
  /// Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment verticalAlignment;

  /// Creates an [EzContactCard].
  const EzContactCard({
    super.key,
    // Content
    required this.name,
    this.subtitle,
    required this.avatar,
    this.tail,

    // Interaction
    this.onTap,
    this.onLongPress,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    this.focusColor,

    // Container Styling
    this.decoration,
    this.margin,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.clipBehavior = Clip.hardEdge,

    // Text Styling
    this.nameStyle,
    this.subtitleStyle,
    this.nameMaxLines = 1,
    this.subtitleMaxLines = 1,

    // Layout
    this.gap = 16.0,
    this.verticalAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: decoration,
      clipBehavior: decoration != null ? clipBehavior : Clip.none,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          splashColor: splashColor,
          highlightColor: highlightColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
          child: Padding(
            padding: contentPadding,
            child: Row(
              crossAxisAlignment: verticalAlignment,
              children: [
                avatar,
                SizedBox(width: gap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: nameStyle ??
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                        maxLines: nameMaxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: subtitleStyle ??
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                          maxLines: subtitleMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (tail != null) ...[
                  SizedBox(width: gap),
                  tail!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
