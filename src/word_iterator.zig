const std = @import("std");

const WordIterator = struct {
    split: enum { word, delimiter },
    buffer: []const u8,
    index: ?usize,

    pub fn first(self: *WordIterator) []const u8 {
        std.debug.assert(self.index == 0);
        return self.next().?;
    }

    pub fn next(self: *WordIterator) ?[]const u8 {
        const start = self.index orelse return null;
        var end: usize = start;

        while (end < self.buffer.len) : (end += 1) {
            const c = self.buffer[end];
            switch (self.split) {
                .word => {
                    if (std.ascii.isAlphabetic(c) and std.ascii.isUpper(c) and end != start) {
                        self.index = end;
                        break;
                    }
                },
                .delimiter => {
                    if (std.ascii.isAlphanumeric(c) == false) {
                        self.index = end + 1;
                        break;
                    }
                },
            }
        }

        if (end == self.buffer.len) {
            self.index = null;
        }

        return self.buffer[start..end];
    }
};

pub fn splitWords(ascii_string: []const u8) WordIterator {
    var it = WordIterator{
        .split = .delimiter,
        .buffer = ascii_string,
        .index = 0,
    };

    // Split on words if there are no delimiters and the string as multiple cases (except capitalized)
    if (std.mem.indexOfAny(u8, ascii_string, "./_- ") == null) {
        const has_upper = std.mem.indexOfAny(u8, ascii_string, "ABCDEFGHIJKLMNOPQRSTUVWXYZ") != null;
        const has_lower = std.mem.indexOfAny(u8, ascii_string, "abcdefghijklmnopqrstuvwxyz") != null;

        if (has_upper and has_lower and isCapitalized(ascii_string) == false) {
            it.split = .word;
        }
    }

    return it;
}

/// Returns true if the string is capitalized.
fn isCapitalized(str: []const u8) bool {
    if (str.len == 0) {
        return false;
    }

    if (std.ascii.isUpper(str[0]) == false) {
        return false;
    }

    if (str.len > 1) {
        for (1..str.len) |i| {
            if (std.ascii.isLower(str[i]) == false) {
                return false;
            }
        }
    }

    return true;
}

test "split words" {
    var it = splitWords("TwoWords");
    try std.testing.expect(it.split == .word);
    try std.testing.expectEqualStrings("Two", it.next().?);
    try std.testing.expectEqualStrings("Words", it.next().?);
    try std.testing.expectEqual(null, it.next());

    it = splitWords("Two-Words");
    try std.testing.expect(it.split == .delimiter);
    try std.testing.expectEqualStrings("Two", it.next().?);
    try std.testing.expectEqualStrings("Words", it.next().?);
    try std.testing.expectEqual(null, it.next());

    it = splitWords("--");
    try std.testing.expect(it.split == .delimiter);
    try std.testing.expectEqualStrings("", it.next().?);
    try std.testing.expectEqualStrings("", it.next().?);
    try std.testing.expectEqualStrings("", it.next().?);
    try std.testing.expectEqual(null, it.next());

    it = splitWords("WORD");
    try std.testing.expectEqualStrings("WORD", it.next().?);
    try std.testing.expectEqual(null, it.next());

    it = splitWords("Word");
    try std.testing.expectEqualStrings("Word", it.next().?);
    try std.testing.expectEqual(null, it.next());

    it = splitWords("word");
    try std.testing.expectEqualStrings("word", it.next().?);
    try std.testing.expectEqual(null, it.next());

    it = splitWords("twoWords");
    try std.testing.expectEqualStrings("two", it.next().?);
    try std.testing.expectEqualStrings("Words", it.next().?);
    try std.testing.expectEqual(null, it.next());
}
