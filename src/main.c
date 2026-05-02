#include <stdlib.h>
#include <stdio.h>
#include "common.h"
#include "chunk.h"
#include "debug.h"
#include "vm.h"

int main(int argc, const char* argv[]) {
    init_VM();

    Chunk chunk;
    init_chunk(&chunk);
    int constant = add_constant(&chunk,4.2);
    write_chunk(&chunk,OP_CONSTANT,12);
    write_chunk(&chunk,constant,12);
    write_chunk(&chunk,OP_RETURN,12);

    disassemble_chunk(&chunk,"test chunk");
    interpret(&chunk);
    free_VM();
    free_chunk(&chunk);

    return 0;
}