const std = @import("std");

const sdl = @cImport({
    @cInclude("SDL2/SDL.h");
});

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = &gpa.allocator;
    defer {
        const leaked = gpa.deinit();
        std.debug.assert(!leaked);
    }

    if (sdl.SDL_Init(sdl.SDL_INIT_VIDEO) != 0) {
        return error.SDLErrorInit;
    }
}

fn theRest() void {
    // Follows: https://gitlab.com/DonRyuDragoni/mandelbrotgen/-/blob/zig-sdl2/src/state.zig
    const title = try std.fmt.allocPrintZ(allocator, "Test? {s}", .{"Hey"});
    defer allocator.destroy(&title);

    const window_w: c_int = 400;
    const window_h: c_int = 400;

    const window: *sdl.SDL_Window = sdl.SDL_CreateWindow(title.ptr, sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED, window_w, window_h, sdl.SDL_WINDOW_SHOWN) orelse return error.SdlErrorCreateWindow;

    const renderer: *sdl.SDL_Renderer = sdl.SDL_CreateRenderer(window, -1, 0) orelse return error.SDLErrorCreateRenderer;

    defer {
        sdl.SDL_DestroyRenderer(renderer);
        sdl.SDL_DestroyWindow(window);
        sdl.SDL_Quit();
    }

    sdl.SDL_SetWindowTitle(window, title.ptr);

    var event: sdl.SDL_Event = undefined;
    var is_running = true;
    running: while (true) {
        while (sdl.SDL_PollEvent(&event) != 0) {
            switch (event.type) {
                sdl.SDL_QUIT => break :running,
                else => {},
            }
        }

        sdl.SDL_RenderPresent(renderer);
    }
}
