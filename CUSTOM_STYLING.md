# Custom Styling Guide for FormBuilderPhoneField

This guide explains how to customize the appearance of the phone field's country picker dialog to match your app's design system.

## New Styling Parameters

The `FormBuilderPhoneField` now supports extensive customization options for the country picker dialog:

### Dialog Appearance
- `dialogBackgroundColor` - Set the background color of the dialog
- `dialogBorderRadius` - Customize the corner radius of the dialog
- `dialogTitleStyle` - Style for the dialog title text
- `searchFieldDecoration` - Complete customization of the search field
- `itemTextStyle` - Style for country names in the list
- `phoneCodeTextStyle` - Style for phone codes in the list

### Translation Support
- `selectCountryTitle` - Custom title for the dialog (default: "Select Your Phone Code")
- `searchHintText` - Hint text for the search field
- `noResultsFoundText` - Text shown when no search results are found

## Example: Customer App Style

This example shows how to match the style from your customer app with white background, rounded corners, and custom fonts:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';

// Define your brand colors
const Color brandWhite = Color(0xFFFFFFFF);
const Color brandRed = Color(0xFFE63946);
const Color brandGrey = Color(0xFF6C757D);
const Color brandInputFillColor = Color(0xFFF8F9FA);

// Define text styles
final bodyLargeStyle = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.black87,
);

final titleMediumStyle = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

// Use in your widget
FormBuilderPhoneField(
  name: 'phone',
  decoration: InputDecoration(
    labelText: 'Phone Number',
    filled: true,
    fillColor: brandInputFillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  
  // Dialog styling to match your app
  dialogBackgroundColor: brandWhite,
  dialogBorderRadius: BorderRadius.circular(10.0),
  dialogTitleStyle: titleMediumStyle,
  itemTextStyle: bodyLargeStyle,
  phoneCodeTextStyle: TextStyle(
    fontSize: 15,
    color: brandGrey,
  ),
  
  // Custom search field
  searchFieldDecoration: InputDecoration(
    hintText: 'Search country...',
    prefixIcon: Icon(Icons.search, color: brandGrey),
    filled: true,
    fillColor: brandInputFillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
  ),
  
  // Translations (for internationalization)
  selectCountryTitle: 'Select Your Country',
  searchHintText: 'Search...',
  noResultsFoundText: 'No countries found',
  
  // Default country and priority list
  defaultSelectedCountryIsoCode: 'NL',
  priorityListByIsoCode: ['NL', 'BE', 'DE', 'GB', 'US'],
)
```

## Matching the Logout Dialog Style

To achieve the exact same look as your logout dialog (white background with rounded corners):

```dart
FormBuilderPhoneField(
  name: 'phone',
  
  // Match the AlertDialog appearance
  dialogBackgroundColor: Colors.white,
  dialogBorderRadius: BorderRadius.all(Radius.circular(10.0)),
  
  // Match the title style
  dialogTitleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
    fontWeight: FontWeight.bold,
  ),
  
  // Other styling...
)
```

## Complete Example with Multiple Languages

For apps supporting multiple languages, you can use translation packages:

```dart
import 'package:get/get.dart'; // or your preferred i18n solution

FormBuilderPhoneField(
  name: 'phone',
  
  // Use translated strings
  selectCountryTitle: 'select_country_title'.tr,
  searchHintText: 'search_hint'.tr,
  noResultsFoundText: 'no_results'.tr,
  
  // Apply your theme's text styles
  dialogTitleStyle: Theme.of(context).textTheme.titleMedium,
  itemTextStyle: Theme.of(context).textTheme.bodyLarge,
  
  // ... other parameters
)
```

## Migration from Default Style

If you're currently using the default style and want to migrate to custom styling:

### Before (Default Style)
```dart
FormBuilderPhoneField(
  name: 'phone',
  dialogTitle: Text('Select Your Phone Code'),
  searchText: 'Search...',
)
```

### After (Custom Style)
```dart
FormBuilderPhoneField(
  name: 'phone',
  
  // Enhanced styling
  dialogBackgroundColor: Colors.white,
  dialogBorderRadius: BorderRadius.circular(10.0),
  
  // Custom text styles
  dialogTitleStyle: GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  itemTextStyle: GoogleFonts.inter(fontSize: 16),
  phoneCodeTextStyle: GoogleFonts.inter(
    fontSize: 15,
    color: Colors.grey,
  ),
  
  // Improved search field
  searchFieldDecoration: InputDecoration(
    hintText: 'Search country...',
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  
  // Translation-ready strings
  selectCountryTitle: 'Select Your Country',
  searchHintText: 'Type to search...',
  noResultsFoundText: 'No matching countries',
)
```

## Tips for Best Results

1. **Consistency**: Use the same text styles and colors as the rest of your app
2. **Accessibility**: Ensure sufficient color contrast for readability
3. **Localization**: Always use translatable strings for international apps
4. **Performance**: Define styles as constants or theme data to avoid recreating them
5. **Testing**: Test the dialog appearance on different screen sizes and orientations

## Troubleshooting

### Dialog not showing custom styles
Make sure you're passing the correct parameters and that your colors/styles are properly defined.

### Search field not styled
The `searchFieldDecoration` parameter accepts a complete `InputDecoration` object, allowing full customization.

### Text styles not applying
Ensure your `TextStyle` objects are properly created and that fonts are loaded (for Google Fonts, ensure internet connectivity on first run).

## See Also

- [Example implementation](example/lib/custom_styled_example.dart)
- [Flutter Form Builder documentation](https://pub.dev/packages/flutter_form_builder)
- [Google Fonts package](https://pub.dev/packages/google_fonts)