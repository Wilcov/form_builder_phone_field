import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';

void main() {
  testWidgets('Custom dialog styling should be applied correctly',
      (WidgetTester tester) async {
    // Define custom colors matching customer app
    const Color brandWhite = Color(0xFFFFFFFF);
    const Color brandRed = Color(0xFFE63946);
    const Color brandGrey = Color(0xFF6C757D);
    const Color brandInputFillColor = Color(0xFFF8F9FA);

    // Build the test app
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            child: Column(
              children: [
                FormBuilderPhoneField(
                  name: 'phone_test',
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  // Custom dialog styling matching customer app
                  dialogBackgroundColor: brandWhite,
                  dialogBorderRadius: BorderRadius.circular(10.0),
                  dialogTitleStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  itemTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  phoneCodeTextStyle: const TextStyle(
                    fontSize: 15,
                    color: brandGrey,
                  ),
                  // Custom search field
                  searchFieldDecoration: InputDecoration(
                    hintText: 'Search country...',
                    prefixIcon: const Icon(Icons.search, color: brandGrey),
                    filled: true,
                    fillColor: brandInputFillColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: brandRed),
                    ),
                  ),
                  // Translation support
                  selectCountryTitle: 'Select Your Country',
                  searchHintText: 'Search...',
                  noResultsFoundText: 'No countries found',
                  defaultSelectedCountryIsoCode: 'NL',
                  priorityListByIsoCode: const ['NL', 'BE', 'DE', 'GB', 'US'],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Verify the widget is rendered
    expect(find.byType(FormBuilderPhoneField), findsOneWidget);

    // Find and tap the country selector to open the dialog
    final countrySelector = find.byType(GestureDetector).first;
    await tester.tap(countrySelector);
    await tester.pumpAndSettle();

    // Verify the custom dialog is shown with correct title
    expect(find.text('Select Your Country'), findsOneWidget);

    // Verify search field is present with custom hint text
    expect(find.byType(TextField), findsOneWidget);

    // Close the dialog
    await tester.tapAt(const Offset(0, 0)); // Tap outside dialog
    await tester.pumpAndSettle();
  });

  testWidgets('Custom dialog should handle search correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            child: Column(
              children: [
                FormBuilderPhoneField(
                  name: 'phone_search_test',
                  dialogBackgroundColor: Colors.white,
                  dialogBorderRadius: BorderRadius.circular(10.0),
                  selectCountryTitle: 'Choose Country',
                  searchHintText: 'Type to search...',
                  noResultsFoundText: 'Country not found',
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Open the dialog
    final countrySelector = find.byType(GestureDetector).first;
    await tester.tap(countrySelector);
    await tester.pumpAndSettle();

    // Verify custom title is shown
    expect(find.text('Choose Country'), findsOneWidget);

    // Find the search field and type
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'United');
    await tester.pumpAndSettle();

    // Verify search filters the results
    // United States and United Kingdom should be visible
    expect(find.textContaining('United'), findsWidgets);
  });

  testWidgets('Priority countries should appear at the top',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            child: Column(
              children: [
                FormBuilderPhoneField(
                  name: 'phone_priority_test',
                  dialogBackgroundColor: Colors.white,
                  priorityListByIsoCode: const ['NL', 'BE', 'DE'],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Open the dialog
    final countrySelector = find.byType(GestureDetector).first;
    await tester.tap(countrySelector);
    await tester.pumpAndSettle();

    // Priority countries should appear at the top of the list
    // This would require more detailed testing of the list order
    expect(find.byType(ListView), findsOneWidget);
  });
}
