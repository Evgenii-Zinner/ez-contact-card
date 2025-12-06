# EZ Contact Card

A **customizable, composition-based** Flutter widget that creates contact-style cards with an avatar, headline, subtitle, and action area.

## 🛑 The Problem

Building list items or contact cards often results in repetitive and messy code:
1.  **Duplicate Layouts:** You constantly rewrite the same `Row` -> `Avatar` -> `Column` -> `Text` hierarchy.
2.  **Inconsistent Spacing:** Managing gaps between avatars, text, and action buttons often leads to inconsistent UI across different lists.
3.  **Styling Boilerplate:** Applying the same decoration, padding, and text styles to multiple cards bloats your widget tree.
4.  **Handling Overflows:** Forgetting to handle long names or subtitles often breaks layouts on smaller screens.

## ✅ The EZ Solution

`EzContactCard` creates a production-ready card with a single line of code:
-   **Standardized Layout:** Enforces a clean "Avatar - Content - Action" interaction pattern.
-   **Defensive Design:** Automatically handles text truncation, ensuring your UI never breaks with long names.
-   **Smart Defaults:** Comes with sensible padding, gap, and alignment defaults that look good out of the box.
-   **Total Control:** While opinionated about layout, it exposes **every styling property** (decoration, margin, text styles) so you can match your app's design system perfectly.

## ✨ Features

*   **Flexible Composition:** Works seamlessly with `EzCircleAvatar` or any custom avatar widget.
*   **Rich Styling API:** Customize background decoration, borders, shadows, and margins.
*   **Interaction Ready:** Built-in `onTap`, `onLongPress`, and splash color support.
*   **Layout Control:** Adjustable gaps and vertical alignment (center/start/end).
*   **Type-Safe Styling:** Define text styles and max lines explicitly.

## 📦 Installation

```shell
flutter pub add ez_contact_card
```

## 🚀 Usage

### Basic (Avatar & Name)
Simplest form. Auto-truncates long names depending on available space.
```dart
EzContactCard(
  name: 'Jane Doe',
  avatar: EzCircleAvatar(name: 'Jane Doe'),
)
```

### With Subtitle & Action
Common pattern for user lists (e.g., "Call", "Message").
```dart
EzContactCard(
  name: 'John Smith',
  subtitle: 'Software Engineer',
  avatar: EzCircleAvatar(name: 'John Smith'),
  tail: IconButton(
    icon: Icon(Icons.phone),
    onPressed: () => _call(context),
  ),
  onTap: () => _viewProfile(context),
)
```

### Fully Styled (Custom Design)
Match your specific design requirements while keeping the code clean.
```dart
EzContactCard(
  name: 'Admin User',
  subtitle: 'System Administrator',
  avatar: EzCircleAvatar(name: 'AU'),
  
  // Container Styling
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(blurRadius: 4, color: Colors.black12),
    ],
  ),
  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  contentPadding: EdgeInsets.all(16),
  
  // Text Styling
  nameStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  subtitleStyle: TextStyle(color: Colors.grey),
)
```

## 🤝 Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request on [GitHub](https://github.com/Evgenii-Zinner/ez_contact_card).

## 📜 License

MIT License - see the [LICENSE](LICENSE) file for details.
