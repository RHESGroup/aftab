#!/usr/bin/env python3
import sys
import os
from pathlib import Path



def slm_to_mem(slm_file,mem_file):
    o_stdout = sys.stdout
    sys.stdout = mem_file
    file1 = open(slm_file, 'r')
    file2 = open(mem_file, 'w')
    sys.stdout = file2
    s = 0

    for line1 in file1:
        if "<.text>" in line1:
            s = 1
        else:
            if s == 1:
                if line1 == "\n":
                    break
                else:
                    print(line1, end='')
    sys.stdout = o_stdout
    file1.close()



asm_path = Path(sys.argv[1])
pre, ext = os.path.splitext(asm_path)
object_path = pre + ".o"
slm_path = pre + ".slm"
mem_path = pre + ".s.mem"


os.system("riscv32-unknown-elf-as  " + str(asm_path) + " -o " + str(object_path))
os.system("riscv32-unknown-elf-objdump -D " + str(object_path) + " > " + str(slm_path))
slm_to_mem(str(slm_path),str(mem_path)) 
os.remove(object_path)


