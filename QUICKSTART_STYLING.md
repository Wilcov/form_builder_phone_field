# Quick Start: Custom Styling for FormBuilderPhoneField

## What's New

The `FormBuilderPhoneField` widget now supports extensive customization to match your app's design system, including:
- Custom dialog background and border radius
- Full control over text styles
- Customizable search field
- Translation support for all text strings

## Basic Usage with Custom Styling

```dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';

FormBuilderPhoneField(
  name: 'phone_number',
  
  // Match your app's dialog style (like the logout dialog)
  dialogBackgroundColor: Colors.white,
  dialogBorderRadius: BorderRadius.circular(10.0),
  
  // Custom text styles
  dialogTitleStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  itemTextStyle: TextStyle(fontSize: 16),
  phoneCodeTextStyle: TextStyle(
    fontSize: 15,
    color: Colors.grey[600],
  ),
  
  // Translation support
  selectCountryTitle: 'Select Your Country',
  searchHintText: 'Search...',
  noResultsFoundText: 'No countries found',
)
```

## Matching Your Customer App Style

To match the exact style from your customer app (with `common.dart` styles):

```dart
import 'package:your_app/common.dart' as common;
import 'package:get/get.dart'; // for translations

FormBuilderPhoneField(
  name: 'phone',
  
  // Use your brand colors
  dialogBackgroundColor: common.brandWhite,
  dialogBorderRadius: BorderRadius.circular(10.0),
  
  // Use your app's text styles
  dialogTitleStyle: common.titleMediumStyle,
  itemTextStyle: common.bodyLargeStyle,
  phoneCodeTextStyle: TextStyle(
    fontSize: 15,
    color: common.brandGrey,
  ),
  
  // Custom search field matching your input style
  searchFieldDecoration: InputDecoration(
    hintText: 'search_hint'.tr,
    prefixIcon: Icon(Icons.search, color: common.brandGrey),
    filled: true,
    fillColor: common.brandInputFillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: common.brandGrey3),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: common.brandRed),
    ),
  ),
  
  // Translated strings
  selectCountryTitle: 'select_country_title'.tr,
  searchHintText: 'search_country'.tr,
  noResultsFoundText: 'no_results_found'.tr,
  
  // Default to Netherlands with priority countries
  defaultSelectedCountryIsoCode: 'NL',
  priorityListByIsoCode: ['NL', 'BE', 'DE', 'GB', 'US'],
)
```

## All New Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `dialogBackgroundColor` | `Color?` | Background color of the dialog |
| `dialogBorderRadius` | `BorderRadius?` | Corner radius of the dialog |
| `dialogTitleStyle` | `TextStyle?` | Style for the dialog title |
| `searchFieldDecoration` | `InputDecoration?` | Complete customization of search field |
| `itemTextStyle` | `TextStyle?` | Style for country names |
| `phoneCodeTextStyle` | `TextStyle?` | Style for phone codes |
| `selectCountryTitle` | `String?` | Custom dialog title text |
| `searchHintText` | `String?` | Hint text for search field |
| `noResultsFoundText` | `String?` | Text when no results found |

## Before and After

### Before (Default Style)
- Generic white dialog with sharp corners
- Default system fonts
- Basic search field
- English-only text

### After (Custom Style)
- Matches your app's design system
- Rounded corners (10px radius)
- Custom fonts (Google Fonts Inter)
- Styled search field with your brand colors
- Full translation support

## Tips

1. **Import your common styles**: Use your existing `common.dart` file for consistency
2. **Use translations**: All text strings support translation via Get.tr or similar
3. **Match your theme**: Use `Theme.of(context).textTheme` for automatic theming
4. **Test on devices**: The dialog adapts to different screen sizes automatically

## Example Project

See the complete example in `example/lib/custom_styled_example.dart` for a working implementation with multiple style variations.