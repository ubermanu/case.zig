# case.zig

A set of functions to change the case of a string.

## Install

```sh
zig fetch --save git+https://github.com/ubermanu/case.zig
```

```zig
const case_mod = b.dependency("case", .{});
exe.addImport("case", case_mod.module("case"));
```

## Usage

```zig
const case = @import("case");

test {
    const allocator = std.testing.allocator;

    const str = try case.toPascalCase(allocator, "Some string");
    defer allocator.free(str);

    try std.testing.expectEqualStrings("SomeString", str);
}
```
