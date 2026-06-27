import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:form_builder_phone_field/form_builder_phone_field.dart';

void main() {
  group('by FormFieldKey -', () {
    testWidgets('should reset value when call reset', (tester) async {
      final formFieldKey = GlobalKey<FormBuilderFieldState>();
      const fieldName = 'phone';
      final testWidget =
          FormBuilderPhoneField(name: fieldName, key: formFieldKey);
      const validPhone = '642337488';
      const validCodePhone = '+34';
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formFieldKey.currentState?.setValue('$validCodePhone$validPhone');
      await tester.pumpAndSettle();
      formFieldKey.currentState?.reset();

      expect(formFieldKey.currentState?.value, null);
    });
    testWidgets('should reset value to initial value when call reset',
        (tester) async {
      final formFieldKey = GlobalKey<FormBuilderFieldState>();
      const fieldName = 'phone';
      const initialValue = '12345';
      final testWidget = FormBuilderPhoneField(
        name: fieldName,
        key: formFieldKey,
        initialValue: initialValue,
      );
      const validPhone = '642337488';
      const validCodePhone = '+34';
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formFieldKey.currentState?.setValue('$validCodePhone$validPhone');
      await tester.pumpAndSettle();
      formFieldKey.currentState?.reset();

      expect(formFieldKey.currentState?.value, initialValue);
    });
    testWidgets('should update value when call set value', (tester) async {
      final formFieldKey = GlobalKey<FormBuilderFieldState>();
      const fieldName = 'phone';
      const validPhone = '691375833';
      const validCodePhone = '+34';
      final testWidget =
          FormBuilderPhoneField(name: fieldName, key: formFieldKey);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formFieldKey.currentState?.didChange('$validCodePhone$validPhone');
      await tester.pumpAndSettle();

      expect(formFieldKey.currentState?.value, '$validCodePhone$validPhone');
    });
  });
  group('by FormKey -', () {
    testWidgets('should reset value when call reset', (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      const fieldName = 'phone';
      final testWidget = FormBuilderPhoneField(name: fieldName);
      await tester
          .pumpWidget(buildTestableFieldWidget(testWidget, formKey: formKey));

      formKey.currentState?.patchValue({fieldName: '+34649294281'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.instantValue, {fieldName: null});
    });
    testWidgets('should reset to initial value value when call reset',
        (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      const fieldName = 'phone';
      const initialValue = '1235';
      final testWidget = FormBuilderPhoneField(name: fieldName);
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        formKey: formKey,
        initialValue: {fieldName: initialValue},
      ));

      formKey.currentState?.patchValue({fieldName: '+34649294281'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.instantValue, {fieldName: initialValue});
    });
    testWidgets('should update valid phone when call patch value',
        (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      const fieldName = 'phone';
      const validPhone = '602299271';
      const validCodePhone = '+34';
      final testWidget = FormBuilderPhoneField(name: fieldName);
      await tester
          .pumpWidget(buildTestableFieldWidget(testWidget, formKey: formKey));

      formKey.currentState
          ?.patchValue({fieldName: '$validCodePhone$validPhone'});
      await tester.pumpAndSettle();

      expect(formKey.currentState?.instantValue,
          {fieldName: '$validCodePhone$validPhone'});
    });
  });

  group('country code visibility -', () {
    testWidgets(
        'should include country code in form value when user types national number',
        (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      const fieldName = 'phone';

      await tester.pumpWidget(buildTestableFieldWidget(
        FormBuilderPhoneField(
          name: fieldName,
          defaultSelectedCountryIsoCode: 'NL',
        ),
        formKey: formKey,
      ));

      await tester.enterText(find.byType(TextField).first, '642811094');
      await tester.pump();

      expect(
        formKey.currentState?.instantValue,
        {fieldName: '+31642811094'},
      );
    });

    testWidgets(
        'should not prepend country code to visible text when country changes',
        (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      const fieldName = 'phone';

      await tester.pumpWidget(buildTestableFieldWidget(
        FormBuilderPhoneField(
          name: fieldName,
          defaultSelectedCountryIsoCode: 'NL',
          countryFilterByIsoCode: const ['NL', 'DE'],
        ),
        formKey: formKey,
      ));

      // Use '0' — single digit, guaranteed to fail phone_number parsing for any
      // country, which is exactly the path that triggered the accumulation bug.
      await tester.enterText(find.byType(TextField).first, '0');
      await tester.pump();

      // Tap the country-code text '+31 ' (trailing space distinguishes it from
      // the '+31' labels inside the picker dialog) to open the picker.
      await tester.tap(find.text('+31 '));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Germany'));
      await tester.pumpAndSettle();

      // After the dialog closes there is exactly one TextField: the phone input.
      // Its controller text must still be '0' (the national number), not '490'.
      final controller =
          tester.firstWidget<TextField>(find.byType(TextField).first).controller!;
      expect(controller.text, '0');
    });

    testWidgets(
        'should update country code in form value when country changes',
        (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      const fieldName = 'phone';

      await tester.pumpWidget(buildTestableFieldWidget(
        FormBuilderPhoneField(
          name: fieldName,
          defaultSelectedCountryIsoCode: 'NL',
          countryFilterByIsoCode: const ['NL', 'DE'],
        ),
        formKey: formKey,
      ));

      await tester.enterText(find.byType(TextField).first, '0');
      await tester.pump();

      // Change from Netherlands (+31) to Germany (+49)
      await tester.tap(find.text('+31 '));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Germany'));
      await tester.pumpAndSettle();

      expect(
        formKey.currentState?.instantValue,
        {fieldName: '+490'},
      );
    });

    testWidgets(
        'should not accumulate country codes when changing country multiple times',
        (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      const fieldName = 'phone';

      await tester.pumpWidget(buildTestableFieldWidget(
        FormBuilderPhoneField(
          name: fieldName,
          defaultSelectedCountryIsoCode: 'NL',
          countryFilterByIsoCode: const ['NL', 'DE', 'FR'],
        ),
        formKey: formKey,
      ));

      await tester.enterText(find.byType(TextField).first, '0');
      await tester.pump();

      // Change NL → DE
      await tester.tap(find.text('+31 '));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Germany'));
      await tester.pumpAndSettle();

      // Change DE → FR (country selector now shows '+49 ')
      await tester.tap(find.text('+49 '));
      await tester.pumpAndSettle();
      await tester.tap(find.text('France'));
      await tester.pumpAndSettle();

      final controller =
          tester.firstWidget<TextField>(find.byType(TextField).first).controller!;

      // Visible text must still be only the national number (not '490' or '33490').
      expect(controller.text, '0');

      // Form value must use the last selected country code (+33), not accumulated codes.
      // Bug would produce '+33490' after two changes.
      expect(
        formKey.currentState?.instantValue,
        {fieldName: '+330'},
      );
    });
  });
}

Widget buildTestableFieldWidget(
  Widget widget, {
  GlobalKey<FormBuilderState>? formKey,
  Map<String, dynamic> initialValue = const {},
}) {
  return MaterialApp(
    home: Scaffold(
      body: FormBuilder(
        key: formKey ?? GlobalKey<FormBuilderFieldState>(),
        initialValue: initialValue,
        child: Column(children: [widget]),
      ),
    ),
  );
}
