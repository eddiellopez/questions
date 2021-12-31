import 'package:flutter_test/flutter_test.dart';
import 'package:questions/extensions.dart';

void main() {
  test("zipWithNext empty", () {
    // When we apply to an empty collection:
    var result = [].zipWithNext((prev, next) => prev + next);

    // We expect an empty result.
    expect(result, []);
  });

  test("zipWithNext one element", () {
    // When we apply to an single element collection:
    var result = [1].zipWithNext((prev, next) => prev + next);

    // We expect an empty result.
    expect(result, []);
  });

  test("zipWithNext two elements", () {
    // When we apply to two elements:
    var result = [1, 2].zipWithNext((prev, next) => prev + next);

    // We expect a single.
    expect(result, [3]);
  });

  test("zipWithNext some", () {
    // When we apply to more elements:
    var result = [1, 2, 3, 4, 5].zipWithNext((prev, next) => prev + next);

    // We expect a single.
    expect(result, [3, 5, 7, 9]);
  });

  test("filter empty", () {
    // When we apply to an empty set:
    var result = [].filter((element) => element > 10);

    // We expect an empty result.
    expect(result, []);
  });

  test("filter none", () {
    // When we apply to elements that do not satisfy the predicate:
    var result = [1, 2, 3, 4, 5].filter((element) => element > 10);

    // We expect an empty result.
    expect(result, []);
  });

  test("filter all", () {
    // When we apply to elements that satisfy the predicate:
    var result = [20, 30, 40].filter((element) => element > 10);

    // We expect the correct result.
    expect(result, [20, 30, 40]);
  });

  test("filter some", () {
    // When we apply to a mixed sample:
    var result = [1, 2, 3, 4, 10, 20, 30, 40].filter((element) => element > 10);

    // We expect the correct result.
    expect(result, [20, 30, 40]);
  });
}
