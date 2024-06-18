# case.zig

A set of functions to change the case of a string.

## Install

```sh
zig fetch --save git+https://github.com/ubermanu/case.zig
```

```zig
const case_mod = b.dependency("case", .{});
exe.root_module.addImport("case", case_mod.module("case"));
```
