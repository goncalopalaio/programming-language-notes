#include <SDL2/SDL.h>
#include <stdio.h>

int main(int argc, char **argv) {
    printf("Hi\n");

    SDL_Init(SDL_INIT_VIDEO);

    printf("Bye\n");
    return 0;
}
