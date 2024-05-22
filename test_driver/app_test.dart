import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('CRUD App', () {
    final counterTextFinder = find.byValueKey('counter');
    final incrementButtonFinder = find.byValueKey('increment');
    final resetButtonFinder = find.byValueKey('reset_counter');
    final textFieldFinder = find.byValueKey('textfield');
    final validateButtonFinder = find.byValueKey('validate_button');

    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 0', () async {
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('increments the counter', () async {
      await driver.tap(incrementButtonFinder);
      expect(await driver.getText(counterTextFinder), "1");
    });

    test('resets the counter', () async {
      await driver.tap(incrementButtonFinder);
      await driver.tap(resetButtonFinder);
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('text update in text field', () async {
      await driver.tap(textFieldFinder);
      await driver.enterText('Hello!');
      await driver.waitFor(find.text('Hello!'));
      await Future.delayed(Duration(seconds: 2));
      await driver.enterText('World!');
      await driver.waitFor(find.text('World!'));
    });

    test('validate form with invalid input', () async {
      await driver.tap(textFieldFinder);
      await driver.enterText('Hello123');
      await driver.tap(validateButtonFinder);
      await driver.waitFor(find.text('Please enter only letters'));
    });

    test('validate form with valid input', () async {
      await driver.tap(textFieldFinder);
      await driver.enterText('Valid');
      await driver.tap(validateButtonFinder);
      await driver.waitFor(find.text('Form is valid!'));
    });

    // This test will intentionally fail
    test('intentional failure test', () async {
      await driver.tap(textFieldFinder);
      await driver.enterText('IntentionalFail');
      expect(await driver.getText(find.text('This will fail')), "This will fail");
    });
  });
}
