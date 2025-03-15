const std = @import("std");
const Allocator = std.mem.Allocator;

const splitWords = @import("word.zig").splitWords;

fn allocCapitalString(allocator: Allocator, ascii_string: []const u8) ![]u8 {
    var lower_str = try std.ascii.allocLowerString(allocator, ascii_string);

    if (lower_str.len > 0) {
        lower_str[0] = std.ascii.toUpper(lower_str[0]);
    }

    return lower_str;
}

const WordCase = enum {
    lower,
    upper,
    capital,

    pub fn allocPrint(self: WordCase, allocator: Allocator, str: []const u8) ![]u8 {
        return switch (self) {
            .lower => try std.ascii.allocLowerString(allocator, str),
            .upper => try std.ascii.allocUpperString(allocator, str),
            .capital => try allocCapitalString(allocator, str),
        };
    }
};

/// Split words in an ascii string and return a new string.
/// If delimiter is `null`, ignores it.
pub fn formatString(allocator: Allocator, ascii_string: []const u8, first_case: WordCase, rest_case: WordCase, delimiter: ?u8) ![]u8 {
    var ret = std.ArrayList(u8).init(allocator);
    defer ret.deinit();

    var it = splitWords(ascii_string);

    const first = try first_case.allocPrint(allocator, it.first());
    defer allocator.free(first);
    try ret.appendSlice(first);

    while (it.next()) |next| {
        if (delimiter) |d| {
            try ret.append(d);
        }

        const str = try rest_case.allocPrint(allocator, next);
        defer allocator.free(str);
        try ret.appendSlice(str);
    }

    return try ret.toOwnedSlice();
}
