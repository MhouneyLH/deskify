import 'dart:convert';

import 'package:deskify/features/data/models/preset_model.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

const String presetFixtureInt = 'desk/preset_int.json';
const String presetFixtureDouble = 'desk/preset_double.json';

void main() {
  const PresetModel tPresetModel = PresetModel(
    id: '0',
    name: 'test',
    targetHeight: 0.0,
  );

  test(
    'should be a subclass of Preset',
    () async {
      // arrange
      expect(tPresetModel, isA<Preset>());
    },
  );

  group('fromMap', () {
    test(
      'should return a valid map when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture(presetFixtureInt));
        // act
        final result = PresetModel.fromMap(jsonMap);
        // assert
        expect(result, tPresetModel);
      },
    );

    test(
      'should return a valid map when the JSON number is a double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture(presetFixtureDouble));
        // act
        final result = PresetModel.fromMap(jsonMap);
        // assert
        expect(result, tPresetModel);
      },
    );
  });

  group('toMap', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final expectedMap = json.decode(fixture(presetFixtureDouble));
        // act
        final result = tPresetModel.toMap();
        // assert
        expect(result, expectedMap);
      },
    );
  });
}
