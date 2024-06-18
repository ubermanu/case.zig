const std = @import("std");

const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;

const formatString = @import("format_string.zig").formatString;

/// Convert a string to `camelCase`.
/// Caller owns returned string and must free with `allocator`.
pub fn toCamelCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .lower, .capital, null);
}

test "camel" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "two words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("twoWords", try toCamelCase(allocator, "Two-Words"));
}

/// Convert a string to `Capital Case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toCapitalCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .capital, .capital, ' ');
}

test "capital" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "two words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("Two Words", try toCapitalCase(allocator, "Two-Words"));
}

/// Convert a string to `CONSTANT_CASE`.
/// Caller owns returned string and must free with `allocator`.
pub fn toConstantCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .upper, .upper, '_');
}

test "constant" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "two words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("TWO_WORDS", try toConstantCase(allocator, "Two-Words"));
}

/// Convert a string to `dot.case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toDotCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .lower, .lower, '.');
}

test "dot" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "two words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("two.words", try toDotCase(allocator, "Two-Words"));
}

/// Convert a string to `kebab-case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toKebabCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .lower, .lower, '-');
}

test "kebab" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "two words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("two-words", try toKebabCase(allocator, "Two-Words"));
}

/// Convert a string to `no case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toNoCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .lower, .lower, ' ');
}

test "no" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "two words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("two words", try toNoCase(allocator, "Two-Words"));
}

/// Convert a string to `PascalCase`.
/// Caller owns returned string and must free with `allocator`.
pub fn toPascalCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .capital, .capital, null);
}

test "pascal" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "two words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("TwoWords", try toPascalCase(allocator, "Two-Words"));
}

/// Convert a string to `Pascal_Snake_Case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toPascalSnakeCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .capital, .capital, '_');
}

test "pascal snake" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "two words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("Two_Words", try toPascalSnakeCase(allocator, "Two-Words"));
}

/// Convert a string to `path/case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toPathCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .lower, .lower, '/');
}

test "path" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "two words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("two/words", try toPathCase(allocator, "Two-Words"));
}

/// Convert a string to `Sentence case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toSentenceCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .capital, .lower, ' ');
}

test "sentence" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "two words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("Two words", try toSentenceCase(allocator, "Two-Words"));
}

/// Convert a string to `snake_case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toSnakeCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .lower, .lower, '_');
}

test "snake" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "two words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("two_words", try toSnakeCase(allocator, "Two-Words"));
}

/// Convert a string to `Train-Case`.
/// Caller owns returned string and must free with `allocator`.
pub fn toTrainCase(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    return formatString(allocator, ascii_string, .capital, .capital, '_');
}

test "train" {
    var arena = ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "twoWords"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "Two Words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "TWO_WORDS"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "two.words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "two-words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "two words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "Two_Words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "two/words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "Two words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "two_words"));
    try std.testing.expectEqualStrings("Two_Words", try toTrainCase(allocator, "Two-Words"));
}

test {
    _ = @import("word_iterator.zig");
    _ = @import("format_string.zig");
}
