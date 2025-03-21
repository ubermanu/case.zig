const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("case", .{
        .root_source_file = b.path("src/case.zig"),
    });

    const test_step = b.step("test", "Run all tests.");

    const tests = b.addTest(.{
        .root_source_file = b.path("src/case.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_tests = b.addRunArtifact(tests);
    test_step.dependOn(&run_tests.step);
}
