import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Styled Phone Field',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CustomStyledPhoneFieldExample(),
    );
  }
}

class CustomStyledPhoneFieldExample extends StatefulWidget {
  @override
  _CustomStyledPhoneFieldExampleState createState() =>
      _CustomStyledPhoneFieldExampleState();
}

class _CustomStyledPhoneFieldExampleState
    extends State<CustomStyledPhoneFieldExample> {
  final _formKey = GlobalKey<FormBuilderState>();

  // Define custom colors matching customer app
  static const Color brandWhite = Color(0xFFFFFFFF);
  static const Color brandRed = Color(0xFFE63946);
  static const Color brandGrey = Color(0xFF6C757D);
  static const Color brandGrey3 = Color(0xFFE9ECEF);
  static const Color brandInputFillColor = Color(0xFFF8F9FA);

  // Define custom text styles using Google Fonts
  TextStyle get bodyLargeStyle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      );

  TextStyle get titleMediumStyle => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  TextStyle get phoneCodeStyle => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: brandGrey,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Styled Phone Field'),
        backgroundColor: brandWhite,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              // Example 1: Matching customer app dialog style
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer App Style',
                        style: titleMediumStyle,
                      ),
                      SizedBox(height: 16),
                      FormBuilderPhoneField(
                        name: 'phone_customer_style',
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: 'Enter your phone number',
                          filled: true,
                          fillColor: brandInputFillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: brandGrey3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: brandGrey3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: brandRed, width: 2),
                          ),
                        ),
                        // Custom dialog styling
                        dialogBackgroundColor: brandWhite,
                        dialogBorderRadius: BorderRadius.circular(10.0),
                        dialogTitleStyle: titleMediumStyle,
                        itemTextStyle: bodyLargeStyle,
                        phoneCodeTextStyle: phoneCodeStyle,
                        // Custom search field decoration
                        searchFieldDecoration: InputDecoration(
                          hintText: 'Search country...',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: brandGrey,
                          ),
                          prefixIcon: Icon(Icons.search, color: brandGrey),
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
                            borderSide: BorderSide(color: brandRed),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                        // Translation support
                        selectCountryTitle: 'Select Your Country',
                        searchHintText: 'Search...',
                        noResultsFoundText: 'No countries found',
                        defaultSelectedCountryIsoCode: 'NL',
                        priorityListByIsoCode: ['NL', 'BE', 'DE', 'GB', 'US'],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Example 2: Alternative style with different colors
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alternative Style',
                        style: titleMediumStyle,
                      ),
                      SizedBox(height: 16),
                      FormBuilderPhoneField(
                        name: 'phone_alternative_style',
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Your mobile number',
                          border: UnderlineInputBorder(),
                        ),
                        // Alternative dialog styling
                        dialogBackgroundColor: Colors.grey[50],
                        dialogBorderRadius: BorderRadius.circular(20.0),
                        dialogTitleStyle: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                        itemTextStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        phoneCodeTextStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo,
                        ),
                        searchFieldDecoration: InputDecoration(
                          hintText: 'Type to search...',
                          prefixIcon: Icon(Icons.search, color: Colors.indigo),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                        ),
                        selectCountryTitle: 'Choose Country',
                        searchHintText: 'Find your country...',
                        noResultsFoundText: 'Country not found',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              // Submit button matching customer app style
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    debugPrint(_formKey.currentState?.value.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Form submitted successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandRed,
                  foregroundColor: brandWhite,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
