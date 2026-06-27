import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/typedefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:phone_number/phone_number.dart';

//TODO: Switch country_pickers for country_code_picker
/// Field for international phone number input.
class FormBuilderPhoneField extends FormBuilderFieldDecoration<String> {
  //TODO: Add documentation
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final MaxLengthEnforcement maxLengthEnforcement;
  final int? maxLength;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final double cursorWidth;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder? buildCounter;
  final bool expands;
  final int? minLines;
  final bool? showCursor;
  final VoidCallback? onTap;

  // For country dialog
  final String? searchText;
  final EdgeInsets? titlePadding;
  final bool? isSearchable;
  final Text? dialogTitle;

  // Custom styling parameters
  final Color? dialogBackgroundColor;
  final BorderRadius? dialogBorderRadius;
  final TextStyle? dialogTitleStyle;
  final InputDecoration? searchFieldDecoration;
  final TextStyle? itemTextStyle;
  final TextStyle? phoneCodeTextStyle;

  // Translation support
  final String? selectCountryTitle;
  final String? searchHintText;
  final String? noResultsFoundText;

  /// Default country iso code selected in dropdown
  ///
  /// By default `US`
  final String defaultSelectedCountryIsoCode;
  final List<String>? priorityListByIsoCode;
  final List<String>? countryFilterByIsoCode;
  final TextStyle? dialogTextStyle;
  final bool isCupertinoPicker;
  final double? cupertinoPickerSheetHeight;
  final TextAlignVertical? textAlignVertical;

  ///The [itemExtent] of [CupertinoPicker]
  /// The uniform height of all children.
  ///
  /// All children will be given the [BoxConstraints] to match this exact
  /// height. Must not be null and must be positive.
  final double pickerItemHeight;

  ///The height of the picker
  final double pickerSheetHeight;

  ///The TextStyle that is applied to Text widgets inside item
  final TextStyle? textStyle;

  /// Relative ratio between this picker's height and the simulated cylinder's diameter.
  ///
  /// Smaller values creates more pronounced curvatures in the scrollable wheel.
  ///
  /// For more details, see [ListWheelScrollView.diameterRatio].
  ///
  /// Must not be null and defaults to `1.1` to visually mimic iOS.
  final double diameterRatio;

  /// Background color behind the children.
  ///
  /// Defaults to a gray color in the iOS color palette.
  ///
  /// This can be set to null to disable the background painting entirely; this
  /// is mildly more efficient than using [Colors.transparent].
  final Color backgroundColor;

  /// {@macro flutter.rendering.wheelList.offAxisFraction}
  final double offAxisFraction;

  /// {@macro flutter.rendering.wheelList.useMagnifier}
  final bool useMagnifier;

  /// {@macro flutter.rendering.wheelList.magnification}
  final double magnification;

  final Country? initialCountry;

  /// A [FixedExtentScrollController] to read and control the current item.
  ///
  /// If null, an implicit one will be created internally.
  final FixedExtentScrollController? scrollController;

  /// [Comparator] to be used in sort of country list
  final Comparator<Country>? sortComparator;

  /// List of countries that are placed on top
  final List<Country>? priorityList;

  ///Callback that is called with selected item of type Country which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  /// Set a custom widget in left side of flag, (country selector)
  ///
  /// By default this widget is `const Icon(Icons.arrow_drop_down)`
  final Widget? iconSelector;

  /// View to display when search found no result
  final Widget? searchEmptyView;

  /// Country picker button
  final Widget Function(
    Widget flag,
    String countryCode,
  )? countryPicker;

  /// Creates field for international phone number input.
  FormBuilderPhoneField({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode,
    super.onReset,
    super.focusNode,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforcement = MaxLengthEnforcement.enforced,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType = TextInputType.phone,
    this.style,
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.searchText,
    this.titlePadding,
    this.dialogTitle,
    this.isSearchable,
    this.defaultSelectedCountryIsoCode = 'US',
    this.priorityListByIsoCode,
    this.countryFilterByIsoCode,
    this.dialogTextStyle,
    this.isCupertinoPicker = false,
    this.cupertinoPickerSheetHeight,
    this.textAlignVertical,
    this.pickerItemHeight = defaultPickerItemHeight,
    this.pickerSheetHeight = defaultPickerSheetHeight,
    this.textStyle,
    this.diameterRatio = 1.35,
    this.backgroundColor = const Color(0xFFD2D4DB),
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.initialCountry,
    this.scrollController,
    this.sortComparator,
    this.priorityList,
    this.itemBuilder,
    this.iconSelector,
    this.countryPicker,
    this.searchEmptyView,
    this.dialogBackgroundColor,
    this.dialogBorderRadius,
    this.dialogTitleStyle,
    this.searchFieldDecoration,
    this.itemTextStyle,
    this.phoneCodeTextStyle,
    this.selectCountryTitle,
    this.searchHintText,
    this.noResultsFoundText,
  })  : assert(initialValue == null || controller == null),
        super(
          builder: (FormFieldState<String?> field) {
            final state = field as _FormBuilderPhoneFieldState;

            return InputDecorator(
              decoration: decoration,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: state.enabled
                        ? () {
                            state.focus();
                            isCupertinoPicker
                                ? state._openCupertinoCountryPicker()
                                : state._openCountryPickerDialog();
                          }
                        : null,
                    child: countryPicker != null
                        ? countryPicker(
                            CountryPickerUtils.getDefaultFlagImage(
                              state._selectedDialogCountry,
                            ),
                            '+${state._selectedDialogCountry.phoneCode} ',
                          )
                        : Row(
                            children: <Widget>[
                              CountryPickerUtils.getDefaultFlagImage(
                                state._selectedDialogCountry,
                              ),
                              const SizedBox(width: 10),
                              iconSelector ?? const Icon(Icons.arrow_drop_down),
                              const SizedBox(width: 10),
                              Text(
                                '+${state._selectedDialogCountry.phoneCode} ',
                                style: Theme.of(state.context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(style),
                              ),
                            ],
                          ),
                  ),
                  Expanded(
                    child: TextField(
                      enabled: state.enabled,
                      style: style,
                      focusNode: state.effectiveFocusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: decoration.hintText,
                        hintStyle: decoration.hintStyle,
                        fillColor: decoration.fillColor,
                      ),
                      onChanged: (value) {
                        // Use setValue instead didChange to avoid parseNumber
                        state.setValue(value);
                      },
                      maxLines: 1,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
                      onEditingComplete: onEditingComplete,
                      controller: state._effectiveController,
                      autocorrect: autocorrect,
                      autofocus: autofocus,
                      buildCounter: buildCounter,
                      cursorColor: cursorColor,
                      cursorRadius: cursorRadius,
                      cursorWidth: cursorWidth,
                      enableInteractiveSelection: enableInteractiveSelection,
                      maxLength: maxLength,
                      inputFormatters: inputFormatters,
                      keyboardAppearance: keyboardAppearance,
                      maxLengthEnforcement: maxLengthEnforcement,
                      scrollPadding: scrollPadding,
                      textAlign: textAlign,
                      textCapitalization: textCapitalization,
                      textDirection: textDirection,
                      textInputAction: textInputAction,
                      strutStyle: strutStyle,
                      //readOnly: state.readOnly, -- Does this need to be exposed?
                      expands: expands,
                      minLines: minLines,
                      showCursor: showCursor,
                      onTap: onTap,
                      textAlignVertical: textAlignVertical,
                    ),
                  ),
                ],
              ),
            );
          },
        );

  @override
  FormBuilderFieldDecorationState<FormBuilderPhoneField, String>
      createState() => _FormBuilderPhoneFieldState();
}

abstract class FormBuilderPhoneFieldState {
  String get fullNumber;
}

class _FormBuilderPhoneFieldState
    extends FormBuilderFieldDecorationState<FormBuilderPhoneField, String>
    implements FormBuilderPhoneFieldState {
  late TextEditingController _effectiveController;
  late Country _selectedDialogCountry;

  @override
  String get fullNumber {
    // When there is no phone number text, the field is empty -- the country
    // prefix is only prepended when a phone number is specified.
    final phoneText = _effectiveController.text;
    return phoneText.isNotEmpty
        ? '+${_selectedDialogCountry.phoneCode}$phoneText'
        : phoneText;
  }

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.controller ?? TextEditingController();
    _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(
        widget.defaultSelectedCountryIsoCode);
    _parsePhone();
  }

  @override
  void dispose() {
    if (null == widget.controller) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _effectiveController = widget.controller ?? TextEditingController();
    _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(
        widget.defaultSelectedCountryIsoCode);
    _parsePhone();
  }

  Future<void> _parsePhone({String? newPhone}) async {
    final phone = newPhone ?? initialValue ?? '';
    if (phone.isNotEmpty) {
      try {
        final parseResult = await PhoneNumberUtil().parse(phone);
        setState(() {
          _selectedDialogCountry =
              CountryPickerUtils.getCountryByIsoCode(parseResult.regionCode);
        });
        _effectiveController.text = parseResult.nationalNumber;
      } catch (error) {
        if (phone.contains('+')) {
          _effectiveController.text = phone.replaceFirst('+', '');
        }
        debugPrint(error.toString());
      }
    }
  }

  @override
  void didChange(String? value) async {
    super.didChange(value);
    await _parsePhone(newPhone: value);
  }

  void _openCupertinoCountryPicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: widget.cupertinoPickerSheetHeight ?? 300.0,
          onValuePicked: (Country country) {
            effectiveFocusNode.requestFocus();
            setState(() => _selectedDialogCountry = country);
            didChange(fullNumber);
          },
          itemFilter: widget.countryFilterByIsoCode != null
              ? (c) => widget.countryFilterByIsoCode!.contains(c.isoCode)
              : null,
          priorityList: widget.priorityListByIsoCode != null
              ? List.generate(
                  widget.priorityListByIsoCode!.length,
                  (index) {
                    return CountryPickerUtils.getCountryByIsoCode(
                      widget.priorityListByIsoCode![index],
                    );
                  },
                )
              : null,
          offAxisFraction: widget.offAxisFraction,
          backgroundColor: widget.backgroundColor,
          diameterRatio: widget.diameterRatio,
          initialCountry: widget.initialCountry,
          magnification: widget.magnification,
          sortComparator: widget.sortComparator,
          useMagnifier: widget.useMagnifier,
          itemBuilder: widget.itemBuilder,
          pickerItemHeight: widget.pickerItemHeight,
          scrollController: widget.scrollController,
          textStyle: widget.textStyle,
        );
      },
    );
  }

  void _openCountryPickerDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return _CustomCountryPickerDialog(
          backgroundColor: widget.dialogBackgroundColor ?? Colors.white,
          borderRadius:
              widget.dialogBorderRadius ?? BorderRadius.circular(20.0),
          title: widget.selectCountryTitle ?? 'Select Your Phone Code',
          titleStyle: widget.dialogTitleStyle ??
              widget.dialogTextStyle ??
              widget.style ??
              const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
          searchHintText:
              widget.searchHintText ?? widget.searchText ?? 'Search...',
          searchFieldDecoration: widget.searchFieldDecoration,
          noResultsText: widget.noResultsFoundText ?? 'No results found',
          itemTextStyle: widget.itemTextStyle,
          phoneCodeTextStyle: widget.phoneCodeTextStyle,
          cursorColor: widget.cursorColor,
          isSearchable: widget.isSearchable ?? true,
          onCountrySelected: (Country country) {
            setState(() => _selectedDialogCountry = country);
            didChange(fullNumber);
            Navigator.of(context).pop();
          },
          countryFilter: widget.countryFilterByIsoCode != null
              ? (c) => widget.countryFilterByIsoCode!.contains(c.isoCode)
              : null,
          priorityCountries: widget.priorityListByIsoCode != null
              ? List.generate(
                  widget.priorityListByIsoCode!.length,
                  (index) {
                    return CountryPickerUtils.getCountryByIsoCode(
                        widget.priorityListByIsoCode![index]);
                  },
                )
              : null,
          sortComparator: widget.sortComparator,
        );
      },
    );
  }
}

// Custom Country Picker Dialog Widget
class _CustomCountryPickerDialog extends StatefulWidget {
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final String title;
  final TextStyle titleStyle;
  final String searchHintText;
  final InputDecoration? searchFieldDecoration;
  final String noResultsText;
  final TextStyle? itemTextStyle;
  final TextStyle? phoneCodeTextStyle;
  final Color? cursorColor;
  final bool isSearchable;
  final Function(Country) onCountrySelected;
  final bool Function(Country)? countryFilter;
  final List<Country>? priorityCountries;
  final Comparator<Country>? sortComparator;

  const _CustomCountryPickerDialog({
    Key? key,
    required this.backgroundColor,
    required this.borderRadius,
    required this.title,
    required this.titleStyle,
    required this.searchHintText,
    this.searchFieldDecoration,
    required this.noResultsText,
    this.itemTextStyle,
    this.phoneCodeTextStyle,
    this.cursorColor,
    required this.isSearchable,
    required this.onCountrySelected,
    this.countryFilter,
    this.priorityCountries,
    this.sortComparator,
  }) : super(key: key);

  @override
  _CustomCountryPickerDialogState createState() =>
      _CustomCountryPickerDialogState();
}

class _CustomCountryPickerDialogState
    extends State<_CustomCountryPickerDialog> {
  late List<Country> _allCountries;
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with all ISO codes to get all countries
    _allCountries = _getAllCountries();

    // Apply filter if provided
    if (widget.countryFilter != null) {
      _allCountries = _allCountries.where(widget.countryFilter!).toList();
    }

    // Sort countries
    if (widget.sortComparator != null) {
      _allCountries.sort(widget.sortComparator);
    } else {
      _allCountries.sort((a, b) => a.name.compareTo(b.name));
    }

    // Add priority countries at the top
    if (widget.priorityCountries != null) {
      final priorityList = widget.priorityCountries!;
      _allCountries.removeWhere((country) =>
          priorityList.any((priority) => priority.isoCode == country.isoCode));
      _allCountries.insertAll(0, priorityList);
    }

    _filteredCountries = List.from(_allCountries);
    _searchController.addListener(_filterCountries);
  }

  // Helper method to get all countries using ISO codes
  List<Country> _getAllCountries() {
    // List of ISO country codes (ISO 3166-1 alpha-2)
    final List<String> isoCodes = [
      'AF',
      'AL',
      'DZ',
      'AS',
      'AD',
      'AO',
      'AI',
      'AQ',
      'AG',
      'AR',
      'AM',
      'AW',
      'AU',
      'AT',
      'AZ',
      'BS',
      'BH',
      'BD',
      'BB',
      'BY',
      'BE',
      'BZ',
      'BJ',
      'BM',
      'BT',
      'BO',
      'BA',
      'BW',
      'BR',
      'BN',
      'BG',
      'BF',
      'BI',
      'KH',
      'CM',
      'CA',
      'CV',
      'KY',
      'CF',
      'TD',
      'CL',
      'CN',
      'CO',
      'KM',
      'CG',
      'CD',
      'CK',
      'CR',
      'CI',
      'HR',
      'CU',
      'CY',
      'CZ',
      'DK',
      'DJ',
      'DM',
      'DO',
      'EC',
      'EG',
      'SV',
      'GQ',
      'ER',
      'EE',
      'ET',
      'FK',
      'FO',
      'FJ',
      'FI',
      'FR',
      'GF',
      'PF',
      'GA',
      'GM',
      'GE',
      'DE',
      'GH',
      'GI',
      'GR',
      'GL',
      'GD',
      'GP',
      'GU',
      'GT',
      'GN',
      'GW',
      'GY',
      'HT',
      'HN',
      'HK',
      'HU',
      'IS',
      'IN',
      'ID',
      'IR',
      'IQ',
      'IE',
      'IL',
      'IT',
      'JM',
      'JP',
      'JO',
      'KZ',
      'KE',
      'KI',
      'KP',
      'KR',
      'KW',
      'KG',
      'LA',
      'LV',
      'LB',
      'LS',
      'LR',
      'LY',
      'LI',
      'LT',
      'LU',
      'MO',
      'MK',
      'MG',
      'MW',
      'MY',
      'MV',
      'ML',
      'MT',
      'MH',
      'MQ',
      'MR',
      'MU',
      'YT',
      'MX',
      'FM',
      'MD',
      'MC',
      'MN',
      'ME',
      'MS',
      'MA',
      'MZ',
      'MM',
      'NA',
      'NR',
      'NP',
      'NL',
      'NC',
      'NZ',
      'NI',
      'NE',
      'NG',
      'NU',
      'NF',
      'MP',
      'NO',
      'OM',
      'PK',
      'PW',
      'PS',
      'PA',
      'PG',
      'PY',
      'PE',
      'PH',
      'PN',
      'PL',
      'PT',
      'PR',
      'QA',
      'RE',
      'RO',
      'RU',
      'RW',
      'SH',
      'KN',
      'LC',
      'PM',
      'VC',
      'WS',
      'SM',
      'ST',
      'SA',
      'SN',
      'RS',
      'SC',
      'SL',
      'SG',
      'SK',
      'SI',
      'SB',
      'SO',
      'ZA',
      'ES',
      'LK',
      'SD',
      'SR',
      'SZ',
      'SE',
      'CH',
      'SY',
      'TW',
      'TJ',
      'TZ',
      'TH',
      'TL',
      'TG',
      'TK',
      'TO',
      'TT',
      'TN',
      'TR',
      'TM',
      'TC',
      'TV',
      'UG',
      'UA',
      'AE',
      'GB',
      'US',
      'UY',
      'UZ',
      'VU',
      'VA',
      'VE',
      'VN',
      'VG',
      'VI',
      'WF',
      'EH',
      'YE',
      'ZM',
      'ZW'
    ];

    List<Country> countries = [];
    for (String isoCode in isoCodes) {
      try {
        final country = CountryPickerUtils.getCountryByIsoCode(isoCode);
        countries.add(country);
      } catch (e) {
        // Skip if country not found
      }
    }
    return countries;
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = List.from(_allCountries);
      } else {
        _filteredCountries = _allCountries.where((country) {
          return country.name.toLowerCase().contains(query) ||
              country.phoneCode.contains(query) ||
              country.isoCode.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: widget.titleStyle,
                ),
              ),
              // Search Field
              if (widget.isSearchable)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    cursorColor: widget.cursorColor,
                    decoration: widget.searchFieldDecoration ??
                        InputDecoration(
                          hintText: widget.searchHintText,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[100],
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
                            borderSide: BorderSide(
                              color: widget.cursorColor ??
                                  Theme.of(context).primaryColor,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                  ),
                ),
              const SizedBox(height: 8.0),
              // Country List
              Expanded(
                child: _filteredCountries.isEmpty
                    ? Center(
                        child: Text(
                          widget.noResultsText,
                          style: widget.itemTextStyle ??
                              const TextStyle(fontSize: 16.0),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          return InkWell(
                            onTap: () => widget.onCountrySelected(country),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                              child: Row(
                                children: [
                                  CountryPickerUtils.getDefaultFlagImage(
                                      country),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Text(
                                      country.name,
                                      style: widget.itemTextStyle ??
                                          const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    '+${country.phoneCode}',
                                    style: widget.phoneCodeTextStyle ??
                                        TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.grey[600],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
