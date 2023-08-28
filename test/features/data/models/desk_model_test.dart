import 'dart:convert';

import 'package:deskify/features/data/models/desk_model.dart';
import 'package:deskify/features/domain/entities/desk.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

const String deskFixtureInt = 'desk/desk_int.json';
const String deskFixtureDouble = 'desk/desk_double.json';

void main() {
  final DeskModel tDeskModel = DeskModel(
    id: '0',
    name: 'test',
    height: 0.0,
    presets: const <Preset>[
      Preset(
        id: '0',
        name: 'test',
        targetHeight: 0.0,
      ),
      Preset(
        id: '1',
        name: 'test',
        targetHeight: 1.0,
      ),
    ],
  );

  test(
    'should be a subclass of Desk',
    () async {
      // arrange
      expect(tDeskModel, isA<Desk>());
    },
  );

  group(
    'fromMap',
    () {
      test(
        'should return a valid map when the JSON number is an integer',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture(deskFixtureInt));
          // act
          final result = DeskModel.fromMap(jsonMap);
          // assert
          expect(result, tDeskModel);
        },
      );

      test(
        'should return a valid map when the JSON number is a double',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture(deskFixtureDouble));
          // act
          final result = DeskModel.fromMap(jsonMap);
          // assert
          expect(result, tDeskModel);
        },
      );
    },
  );

  group(
    'toMap',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          // act
          final expectedMap = json.decode(fixture(deskFixtureDouble));
          // assert
          final result = tDeskModel.toMap();
          // assert
          expect(result, expectedMap);
        },
      );
    },
  );
}
