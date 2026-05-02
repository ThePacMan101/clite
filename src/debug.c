#include "debug.h"
#include <stdio.h>

void disassemble_chunk(Chunk* chunk, const char* name){
    printf("== %s ==\n",name);

    for(int offset = 0 ; offset < chunk->count;){
        offset = disassemble_instruction(chunk,offset);
    }
}

static int simple_instruction(const char* name, int offset){
    printf("%s\n", name);
    return offset+1;
}

static int constant_instruction(const char* name, Chunk* chunk, int offset){
    uint8_t constant = chunk->code[offset+1];
    printf("%-16s %4d '",name,constant);
    print_value(chunk->constants.values[constant]);
    printf("'\n");
    return offset+2;
}

int disassemble_instruction(Chunk* chunk, int offset){
#define SIMPLE_INSTRUCTION(instruction_name) \
case instruction_name: return  simple_instruction(#instruction_name,offset);
#define CONSTANT_INSTRUCTION(instruction_name) \
case instruction_name: return  constant_instruction(#instruction_name,chunk,offset);

    printf("%04d ",offset);
    if(offset>0 && chunk->lines[offset] == chunk->lines[offset-1]){
        printf("   | ");
    }else{
        printf("%4d ",chunk->lines[offset]);
    }
    uint8_t instruction = chunk->code[offset];
    switch (instruction) {
        SIMPLE_INSTRUCTION(OP_NEGATE);
        SIMPLE_INSTRUCTION(OP_RETURN);
        SIMPLE_INSTRUCTION(OP_ADD);
        SIMPLE_INSTRUCTION(OP_SUBTRACT);
        SIMPLE_INSTRUCTION(OP_MULTIPLY);
        SIMPLE_INSTRUCTION(OP_DIVIDE);
        CONSTANT_INSTRUCTION(OP_CONSTANT);
        default:
            printf("Unkown opcode %d\n",instruction);
            return offset+1;
    }
#undef SIMPLE_INSTRUCTION
#undef CONSTANT_INSTRUCTION
}