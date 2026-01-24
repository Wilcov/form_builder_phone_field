# Form Builder Phone Field

International phone number field for [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) package.

[![Pub Version](https://img.shields.io/pub/v/form_builder_phone_field?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_phone_field)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/flutter-form-builder-ecosystem/form_builder_phone_field/base.yaml?branch=main&logo=github&style=for-the-badge)](https://github.com/flutter-form-builder-ecosystem/form_builder_phone_field/actions/workflows/base.yaml)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/flutter-form-builder-ecosystem/form_builder_phone_field?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/flutter-form-builder-ecosystem/form_builder_phone_field)
[![Codecov](https://img.shields.io/codecov/c/github/flutter-form-builder-ecosystem/form_builder_phone_field?logo=codecov&style=for-the-badge)](https://codecov.io/gh/flutter-form-builder-ecosystem/form_builder_phone_field/)

___

- [Features](#features)
- [Usage](#usage)
  - [Setup](#setup)
  - [Basic use](#basic-use)
- [Support](#support)
  - [Contribute](#contribute)
  - [Questions and answers](#questions-and-answers)
  - [Donations](#donations)
- [Roadmap](#roadmap)
- [Ecosystem](#ecosystem)
- [Thanks to](#thanks-to)

## Features

- Country selector with search functionality
- Automatic parsing of international numbers
- Fully customizable dialog appearance
- Translation support for all text strings
- Priority country list support
- Custom styling to match your app's design system

## Usage

### Setup

Configure dependency phone_number. More details [here](https://pub.dev/packages/phone_number#setup)

### Basic use

```dart
FormBuilderPhoneField(
  name: 'phone_number',
  decoration: const InputDecoration(
    labelText: 'Phone Number',
    hintText: 'Enter your phone number',
  ),
  priorityListByIsoCode: ['US', 'GB', 'CA'],
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(),
  ]),
),
```

### Custom Styling

The phone field now supports extensive customization for the country picker dialog to match your app's design system:

```dart
FormBuilderPhoneField(
  name: 'phone_number',
  decoration: const InputDecoration(
    labelText: 'Phone Number',
  ),
  
  // Custom dialog styling
  dialogBackgroundColor: Colors.white,
  dialogBorderRadius: BorderRadius.circular(10.0),
  dialogTitleStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  itemTextStyle: const TextStyle(
    fontSize: 16,
    color: Colors.black87,
  ),
  phoneCodeTextStyle: TextStyle(
    fontSize: 15,
    color: Colors.grey[600],
  ),
  
  // Custom search field
  searchFieldDecoration: InputDecoration(
    hintText: 'Search country...',
    prefixIcon: Icon(Icons.search, color: Colors.grey),
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
  ),
  
  // Translation support
  selectCountryTitle: 'Select Your Country',
  searchHintText: 'Type to search...',
  noResultsFoundText: 'No countries found',
  
  // Priority countries appear at the top
  priorityListByIsoCode: ['US', 'GB', 'CA', 'AU'],
  defaultSelectedCountryIsoCode: 'US',
),
```

### Styling Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `dialogBackgroundColor` | `Color?` | Background color of the dialog (default: white) |
| `dialogBorderRadius` | `BorderRadius?` | Corner radius of the dialog (default: 20px) |
| `dialogTitleStyle` | `TextStyle?` | Style for the dialog title |
| `searchFieldDecoration` | `InputDecoration?` | Complete customization of search field |
| `itemTextStyle` | `TextStyle?` | Style for country names in the list |
| `phoneCodeTextStyle` | `TextStyle?` | Style for phone codes in the list |
| `selectCountryTitle` | `String?` | Custom dialog title text |
| `searchHintText` | `String?` | Hint text for search field |
| `noResultsFoundText` | `String?` | Text shown when no results found |

See [pub.dev example tab](https://pub.dev/packages/form_builder_phone_field/example) or [github code](example/lib/main.dart) for more details

## Support

### Contribute

You have some ways to contribute to this packages

- Beginner: Reporting bugs or request new features
- Intermediate: Implement new features (from issues or not) and created pull requests
- Advanced: Join the [organization](#ecosystem) like a member and help coding, manage issues, dicuss new features and other things

 See [contribution guide](https://github.com/flutter-form-builder-ecosystem/.github/blob/main/CONTRIBUTING.md) for more details

### Questions and answers

You can question or search answers on [Github discussion](https://github.com/flutter-form-builder-ecosystem/form_builder_phone_field/discussions) or on [StackOverflow](https://stackoverflow.com/questions/tagged/flutter-form-builder)

### Donations

Donate or become a sponsor of Flutter Form Builder Ecosystem

[![Become a Sponsor](https://opencollective.com/flutter-form-builder-ecosystem/tiers/sponsor.svg?avatarHeight=56)](https://opencollective.com/flutter-form-builder-ecosystem)

## Roadmap

- [Add complete web support](https://github.com/flutter-form-builder-ecosystem/form_builder_phone_field/issues/11)
- [Add visual examples](https://github.com/flutter-form-builder-ecosystem/form_builder_phone_field/issues/12) (images, gifs, videos, sample application)
- [Solve open issues](https://github.com/flutter-form-builder-ecosystem/form_builder_phone_field/issues), [prioritizing bugs](https://github.com/flutter-form-builder-ecosystem/form_builder_phone_field/labels/bug)

## Ecosystem

Take a look to [our awesome ecosystem](https://github.com/flutter-form-builder-ecosystem) and all packages in there

## Thanks to

[All constributors](https://github.com/flutter-form-builder-ecosystem/form_builder_phone_field/graphs/contributors)
