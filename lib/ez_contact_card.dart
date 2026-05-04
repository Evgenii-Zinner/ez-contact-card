library ez_contact_card;

import 'package:ez_circle_avatar/ez_circle_avatar.dart';
import 'package:flutter/material.dart';

/// A card that displays an avatar, a name, an optional subtitle, and a tail widget.
///
/// The [EzContactCard] is a stateless widget that composes these elements into a
/// horizontal layout:
///
/// * [avatar]: Displayed on the left.
/// * [name]: The primary text, displayed in a column.
/// * [subtitle]: Optional secondary text below the name.
/// * [tail]: Optional widget displayed on the right.
///
/// ## Layout algorithm
///
/// The widget uses a [Row] to align its children. The text column is wrapped in
/// an [Expanded] widget to ensure that long names or subtitles are truncated
/// with an ellipsis instead of causing a layout overflow.
///
/// The spacing between the avatar, text column, and tail is controlled by the [gap]
/// property. The vertical alignment of the row is controlled by [verticalAlignment].
///
/// ## Styling
///
/// The card's container can be customized using [decoration] for background, borders,
/// and shadows, and [margin] for external spacing. The [contentPadding] property
/// controls the internal spacing around the content.
///
/// Text styles can be customized via [nameStyle] and [subtitleStyle]. If not provided,
/// they use sensible defaults from the current [Theme].
///
/// ## Examples
///
/// ### Basic usage
///
/// ```dart
/// EzContactCard(
///   name: 'Jane Doe',
///   avatar: EzCircleAvatar(name: 'Jane Doe'),
/// )
/// ```
///
/// ### Styled with action
///
/// ```dart
/// EzContactCard(
///   name: 'John Smith',
///   subtitle: 'Software Engineer',
///   avatar: EzCircleAvatar(name: 'John Smith'),
///   tail: IconButton(
///     icon: const Icon(Icons.phone),
///     onPressed: () {},
///   ),
///   decoration: BoxDecoration(
///     color: Colors.white,
///     borderRadius: BorderRadius.circular(12),
///     boxShadow: const [
///       BoxShadow(blurRadius: 4, color: Colors.black12),
///     ],
///   ),
/// )
/// ```
///
/// See also:
///
///  * [EzCircleAvatar], which is commonly used as the avatar widget.
///  * [ListTile], a standard Flutter widget with a similar layout.
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
  /// If [decoration] is provided, [backgroundColor], [border], [borderRadius],
  /// and [elevation] are ignored.
  final BoxDecoration? decoration;

  /// The background color of the card.
  /// Ignored if [decoration] is provided.
  final Color? backgroundColor;

  /// The border to draw around the card.
  /// Ignored if [decoration] is provided.
  final Border? border;

  /// The border radius of the card's corners.
  /// Ignored if [decoration] is provided.
  final BorderRadiusGeometry? borderRadius;

  /// The elevation of the card, which controls the size of the shadow.
  /// Defaults to 0. Ignored if [decoration] is provided.
  final double elevation;

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
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.elevation = 0,
    this.margin,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
    final BoxDecoration effectiveDecoration = decoration ??
        BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: borderRadius,
          boxShadow: elevation > 0
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: elevation,
                    offset: Offset(0, elevation / 2),
                  ),
                ]
              : null,
        );

    return Container(
      margin: margin,
      decoration: effectiveDecoration,
      clipBehavior: clipBehavior,
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
