rm a.out
rm -rf a.out.dSYM
# GLFLAG="-framework OpenGL"
#CFLAGS="-Wall -std=c11 -pedantic `sdl2-config --libs` -I/opt/homebrew/Cellar/sdl2/2.0.14_1/include/ $GLFLAG -lm -O3 -g"
CFLAGS="-L/opt/homebrew/lib -lSDL2 -I/opt/homebrew/Cellar/sdl2/2.0.14_1/include/"

echo "Using flags: "$CFLAGS

gcc main.c $CFLAGS