const std = @import("std");

// Notes:
// Created with: zig init-exe

// Use:
// export ZIG_SYSTEM_LINKER_HACK=1
// Until zig linker issues in osx are fixed.

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("build-system-test", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);

    exe.linkSystemLibrary("c");
    _ = exe.addLibPath("/opt/homebrew/lib/");
    exe.linkSystemLibrary("SDL2");
    _ = exe.addIncludeDir("/opt/homebrew/Cellar/sdl2/2.0.14_1/include/"); // Normally wouldn't be necessary, but homebrew isn't putting stuff in the right place?

    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
