#!/usr/bin/python3

# **************************************************************************************
#  Filename: test_asm_instr_generator.py  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  History:
#  Date:     29 March, 2022  #
#
# Copyright (C) 2022 CINI Cybersecurity National Laboratory and University of Teheran
#
# This source file may be used and distributed without
# restriction provided that this copyright statement is not
# removed from the file and that any derivative work contains
# the original copyright notice and the associated disclaimer.
#
# This source file is free software; you can redistribute it
# and/or modify it under the terms of the GNU Lesser General
# Public License as published by the Free Software Foundation;
# either version 3.0 of the License, or (at your option) any
# later version.
#
# This source is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General
# Public License along with this source; if not, download it
# from https://www.gnu.org/licenses/lgpl-3.0.txt
#
# **************************************************************************************
#
#  File content description:
#  Python script for auto generation of test_asm_arithmetic, test_asm_branches,
#  test_asm_data_transfer and test_asm_logical_shift_lui.
#  Golden dumps are also created inside /sw/build/apps/<app_name>/slm_files.  #
#
# **************************************************************************************

import numpy as np
import re 
import os, tempfile
from datetime import datetime as dt

import warnings

ADDR=0x100000
OFFSET=0x0


def print_main():
    s_file.write("\n    .text\n")
    s_file.write("    .globl	main\n")
    s_file.write("    .type	main, @function\n")
    s_file.write("main:\n")

def set_regs():
  global s_file 
  for n in range(2,26):
        if  (REGS[n] > 0x7FF):
            l = np.uint32(REGS[n] << 20) >> 20
            h = (REGS[n] >> 12)
            s_file.write("    lui  x"+str(n)+","+str(hex(h))+"\n")
            s_file.write("    addi x"+str(n)+",x"+str(n)+","+str(hex(l))+"\n")
        else:
            s_file.write("    li x"+str(n)+","+str(hex(REGS[n]))+"\n")
  s_file.write("\n")
  s_file.write("\n")

def test_load_store():
    global ADDR
    global s_file 
    global gm_file
    set_regs()
    s_file.write("    sw    x2,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[2]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x3,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[3]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x4 ,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[4]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x5,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[5]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x6,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[6]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sb    x7,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    res = (np.uint32(REGS[7]) << np.uint32(24) ) >> 24
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sh    x8,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    res =(np.uint32(REGS[8]) << np.uint32(16) ) >> 16
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("\n")
    s_file.write("\n")

    s_file.write("    li   x24,28\n")
    s_file.write("    sub  x1,x1,x24\n")
    
    s_file.write("\n")
    s_file.write("\n")
    s_file.write("    lw    x9,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    s_file.write("    lh    x10,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    s_file.write("    lhu   x11,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    s_file.write("    lb    x12,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    s_file.write("    lbu   x13,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    s_file.write("    lw   x14,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    s_file.write("    lw   x15,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    s_file.write("\n")
    s_file.write("\n")

    s_file.write("    sw    x9,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[2]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x10,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[3]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x11 ,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(REGS[4]),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x12,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    res = (REGS[5] << 24 ) >> 24
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x13,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    res = (np.uint32(REGS[6]) << np.uint32(24) ) >> 24
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.int32(res),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x14,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    res = (np.uint32(REGS[7])) >> np.uint32(24)
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.int32(res),'08x').upper()+"\n")
    ADDR=ADDR+4
    s_file.write("    sw    x15,0(x1)\n")
    s_file.write("    addi  x1,x1,4\n")
    res =  (np.uint32(REGS[8])) >> np.uint32(16)
    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.int32(res),'08x').upper()+"\n")
    ADDR=ADDR+4

    s_file.write("")
    s_file.write("")




    

def test_RR(op):
  set_regs()
  global OFFSET
  global ADDR
  global gm_file
  global s_file 
  for n in range(2,13):
        s_file.write("    "+op+"   x"+str(n)+",x"+str(n+1)+",x"+str(n+2)+"\n")
        s_file.write("    sw    x"+str(n)+","+str(np.uint32(OFFSET))+"(x1)\n")
        #s_file.write("    addi  x1,x1,4\n")

        res=0
        if op == "add":
            res =  np.int32(REGS[n+1] + REGS[n+2])
        elif op == "sub":
            res =  REGS[n+1] - REGS[n+2]
        elif op == "slt":
            res =  1 if REGS[n+1] < REGS[n+2] else 0
        elif op == "sltu":
            res =  1 if np.uint32(REGS[n+1]) < np.uint32(REGS[n+2]) else 0
        elif op == "mul":
            res =  REGS[n+1] * REGS[n+2]
        elif op == "mulh":
            res =  (np.int64(REGS[n+1]) * np.int64(REGS[n+2])) >> 32 #  rs1 -> signed   , rs2 -> signed. 
        elif op == "mulhu":
            res =  (np.uint64(REGS[n+1]) * np.uint64(REGS[n+2])) >> np.uint32(32) #  rs1 -> unsigned , rs2 -> unsigned. 
        elif op == "mulhsu":
            res = np.uint64(np.int32(REGS[n+1]) * np.uint32(REGS[n+2])) >> np.uint32(32) #  rs1 -> signed   , rs2 -> unsigned. 
        elif op == "div":
            res =   REGS[n+1] / REGS[n+2]
        elif op == "divu":
            res =  np.uint32(REGS[n+1]) / np.uint32(REGS[n+2])
        elif op == "rem":   
            rdv = np.int32(REGS[n+1] / REGS[n+2])
            res = np.int32(REGS[n+1]) - rdv*REGS[n+2]
        elif op == "remu":
            res =  np.uint32(REGS[n+1]) % np.uint32(REGS[n+2])
        elif op == "and":
            res =  REGS[n+1] & REGS[n+2]
        elif op == "or":
            res =  REGS[n+1] | REGS[n+2]
        elif op == "xor":
            res =  REGS[n+1] ^ REGS[n+2]
        elif op == "sll":
            shamnt = np.uint32(np.uint32(REGS[n+2]) << 27) >> np.uint32(27)
            res =  np.uint32(REGS[n+1]) << shamnt
        elif op == "srl":
            shamnt = np.uint32(np.uint32(REGS[n+2]) << 27) >> np.uint32(27)
            res =  (np.uint32(REGS[n+1]) & 0xFFFFFFFF ) >> shamnt
        elif op == "sra":
            shamnt = np.uint32(np.uint32(REGS[n+2]) << 27) >> np.uint32(27)
            res =  np.int32(REGS[n+1]) >>  np.int32(shamnt)

        gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res),'08x').upper()+"\n")
        OFFSET+=4
        ADDR+=4
        if OFFSET == 0x7FC:
            s_file.write("    addi  x1,x1,0x7FC\n")
            OFFSET=0

    
  s_file.write("")
  s_file.write("")

def test_RI(op):
    set_regs()
    global OFFSET
    global ADDR
    global gm_file
    global s_file 
    for n in range(2,18):
            
            imm_map=0
            res=0
            if op == "addi":
                imm_map = IMM[n]
                res =  REGS[n+1] + IMM[n]
            elif op == "slti":
                imm_map = IMM[n]
                res =  1 if REGS[n+1] < IMM[n] else 0
            elif op == "sltiu":
                imm_map = np.uint32(IMM[n])
                res =  1 if np.uint32(REGS[n+1]) < np.uint32(IMM[n]) else 0
            elif op == "andi":
                imm_map = IMM[n]
                res =  REGS[n+1] & IMM[n]
            elif op == "ori":
                imm_map = IMM[n]
                res =  REGS[n+1] | IMM[n] 
            elif op == "xori":
                imm_map = IMM[n]
                res =  REGS[n+1] ^ IMM[n] 
            elif op == "slli":
                imm_map= abs(IMM[n]) if abs(IMM[n])< 31 else 31
                res =  REGS[n+1] << imm_map
            elif op == "srli":
                imm_map= abs(IMM[n]) if abs(IMM[n])< 31 else 31
                res =  (REGS[n+1] & 0xFFFFFFFF ) >> imm_map
            elif op == "srai":
                imm_map= abs(IMM[n]) if abs(IMM[n])< 31 else 31
                res =  REGS[n+1] >> imm_map

            s_file.write("    "+op+"   x"+str(n)+",x"+str(n+1)+","+hex(imm_map)+"\n")
            s_file.write("    sw    x"+str(n)+","+str(np.uint32(OFFSET))+"(x1)\n")
            #s_file.write("    addi  x1,x1,4\n")



            gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res),'08x').upper()+"\n")
            OFFSET+=4
            ADDR+=4
            if OFFSET == 0x7FC:
                s_file.write("    addi  x1,x1,0x7FC\n")
                OFFSET=0

def test_LUI(op):
    set_regs()
    global ADDR
    global OFFSET
    global gm_file
    global s_file
    global PC 
    PC = PC + (4*27)
    for n in range(2,20):
            s_file.write("    "+op+"   x"+str(n)+","+str(np.uint16(IMM[n]))+"\n")
            s_file.write("    sw    x"+str(n)+","+str(np.uint32(OFFSET))+"(x1)\n")
            #s_file.write("    addi  x1,x1,4\n")
           

            res=0
            if op == "lui":
                res =  np.uint32(np.uint16(IMM[n])) <<  np.uint32(12)
            if op == "auipc":
                res =  (np.uint32(np.uint16(IMM[n])) <<  np.uint32(12)) + np.uint32(PC)

            gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res),'08x').upper()+"\n")
            PC = PC + 8
            OFFSET+=4
            ADDR+=4
            if OFFSET == 0x7FC:
                s_file.write("    addi  x1,x1,0x7FC\n")
                OFFSET=0
                PC = PC + 4

def test_B(op):
        set_regs()
        global ADDR
        global TARGET
        global OFFSET
        global gm_file
        global s_file
       
        rgs = [2,3]
        for n in range(2,20):
            s_file.write("    "+op+"   x"+str(n)+",x"+str(n+1)+",target"+str(TARGET)+"\n")
            res=0
            if op == "beq":
                res = 1 if REGS[n] == REGS[n+1] else 0
            if op == "bne":
                res = 1 if REGS[n] != REGS[n+1] else 0
            if op == "blt":
                res = 1 if REGS[n] < REGS[n+1] else 0
            if op == "bge":
                res = 1 if REGS[n] >= REGS[n+1] else 0
            if op == "bltu":
                res = 1 if np.uint32(REGS[n]) < np.uint32(REGS[n+1]) else 0
            if op == "bgeu":
                res = 1 if np.uint32(REGS[n]) >= np.uint32(REGS[n+1]) else 0

            s_file.write("    sw    x"+str(rgs[not(res)])+","+str(np.uint32(OFFSET))+"(x1)\n")
            s_file.write("    j     t"+str(TARGET)+"\n")
            s_file.write("target"+str(TARGET)+":\n")
            s_file.write("    sw    x"+str(rgs[res])+","+str(np.uint32(OFFSET))+"(x1)\n")
            s_file.write("t"+str(TARGET)+":\n")
            #s_file.write("    addi  x1,x1,4\n")

            TARGET=TARGET+1

            gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(1),'08x').upper()+"\n")
            OFFSET+=4
            ADDR+=4
            if OFFSET == 0x7FC:
                s_file.write("    addi  x1,x1,0x7FC\n")
                OFFSET=0

def test_J(op):
        set_regs() 
        global ADDR
        global TARGET
        global gm_file
        global OFFSET
        global s_file
        global PC
        rgs = [2,3]
        PC = PC + (4*27)
        for n in range(4,20):
            if op == "jal":
                s_file.write("    "+op+"   x"+str(n)+",target"+str(TARGET)+"\n")
                res1 = 1
                res2 = PC + 4
                PC = PC + 4 
            if op == "jalr":
                i = PC + 16
                s_file.write("    li       x4,"+str(i)+"\n")
                s_file.write("    "+op+"   x"+str(n)+","+str(np.uint32(0))+"(x4)\n")
                res1 = 1
                res2 = PC + 8
                PC = PC + 8
            
            s_file.write("    sw    x"+str(rgs[0])+","+str(np.uint32(OFFSET))+"(x1)\n")
            s_file.write("    j     t"+str(TARGET)+"\n")
            s_file.write("target"+str(TARGET)+":\n")
            s_file.write("    sw    x"+str(rgs[1])+","+str(np.uint32(OFFSET))+"(x1)\n")
            s_file.write("t"+str(TARGET)+":\n")
            #s_file.write("    addi  x1,x1,4\n")
            

            gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res1),'08x').upper()+"\n")
            OFFSET+=4
            ADDR+=4
            if OFFSET == 0x7FC:
                s_file.write("    addi  x1,x1,0x7FC\n")
                PC = PC + 4
                OFFSET=0

            s_file.write("    sw    x"+str(n)+","+str(np.uint32(OFFSET))+"(x1)\n")
            #s_file.write("    addi  x1,x1,4\n")

            gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res2),'08x').upper()+"\n")
            OFFSET+=4
            ADDR+=4
            if OFFSET == 0x7FC:
                s_file.write("    addi  x1,x1,0x7FC\n")
                PC = PC + 4
                OFFSET=0

            PC = PC + 16
                

            TARGET=TARGET+1

            


# Registers content from  R0 to R31

REGS = np.array([0x0,               #R0
                 0x0,               #R1        
                 0x0,               #R2
                 0x1,               #R3
                 0x2,               #R4
                 -1,                #R5
                 -2,                #R6
                 -0x1,              #R7
                 -0x1,              #R8
                 0x7F87F8,          #R9
                 0x7FF7FF,          #R10
                 0x70F70F,          #R11
                 -100,              #R12
                 100,               #R13
                 49,                #R14
                 7,                 #R15
                 34,                #R16
                 21,                #R17
                 255,               #R18
                 17,                #R19
                 12,                #R20
                 128,               #R21
                 20,                #R22
                 0x3FF,             #R23
                 5,                 #R24
                 0x3FF,             #R25
                 5,                 #R26
                 10,                #R27
                 112,               #R28
                 142,               #R29
                 57,                #R30
                 17,                #R31
                 ],                 #R22 
                 np.int32)


IMM = np.array([ 0x0,               #I0
                 0x0,               #I1        
                 0x0,               #I2
                 0x1,               #I3
                 0x2,               #I4
                 -1,                #I5
                 -2,                #I6
                 -0x1,              #I7
                 -0x1,              #I8 
                 0x7F8,             #I9
                 0x7FF,             #I10
                 0x70F,             #I11
                 -100,              #I12
                 10,                #I13
                 9,                 #I14
                 7,                 #I15
                 2,                 #I16
                 2,                 #I17
                 25,                #I18
                 1,                 #I19
                 12,                #I20
                 18,                #I21
                 17,                #I22
                 0x3FF,             #I23
                 5,                 #I24
                 0x3FF,             #I24
                 5,                 #I26
                 1,                 #I27
                 2,                 #I28
                 14,                #I29
                 7,                 #I30
                 17,                #I31
                 ],                  
                 np.int32)


warnings.filterwarnings('ignore')

gd_a  = open("../build/apps/test_asm_arithmetic/slm_files/golden_dump.txt", "w")
gd_dt = open("../build/apps/test_asm_data_transfer/slm_files/golden_dump.txt", "w")
gd_ls = open("../build/apps/test_asm_logical_shift_lui/slm_files/golden_dump.txt", "w")
gd_br = open("../build/apps/test_asm_branches/slm_files/golden_dump.txt", "w")


test_a  = open("../apps/test_asm_arithmetic/test_asm_arithmetic.s", "w")
test_dt = open("../apps/test_asm_data_transfer/test_asm_data_transfer.s", "w")
test_ls = open("../apps/test_asm_logical_shift_lui/test_asm_logical_shift_lui.s", "w")
test_br = open("../apps/test_asm_branches/test_asm_branches.s", "w")

### Arithmetic test -----------------------------------------------------



gm_file = gd_a
s_file  = test_a

print_main()

OFFSET=0x0
ADDR=0x100000
s_file.write("   lui x1,0x100\n")
s_file.write("")
s_file.write("")
test_RR("add")
test_RR("sub")
test_RI("addi")
test_RR("slt")
test_RR("sltu")
test_RI("slti")
test_RI("sltiu")
test_RR("mul")
test_RR("mulh")
test_RR("mulh")
test_RR("mulhsu")
test_RR("div")
test_RR("divu")
test_RR("rem")
test_RR("remu")

s_file.write("stop: j stop")  

### Load and store test -----------------------------------------------------

gm_file = gd_dt
s_file  = test_dt

print_main()

OFFSET=0x0
ADDR=0x100000
s_file.write("     lui x1,0x100\n")
s_file.write("")
s_file.write("")
test_load_store()

s_file.write("stop: j stop")   

### Logical, Shift test and LUI -----------------------------------------------------
##
## FOR auipc we consider that PC at the beginning of the main is PC -> 0x90

gm_file = gd_ls
s_file  = test_ls

print_main()

OFFSET=0x0
ADDR=0x100000
s_file.write("     lui x1,0x100\n")   
s_file.write("")
s_file.write("")

PC = np.uint32(0x108)
test_LUI("auipc"); ## TEST_AUIPC as first instruction after lui
test_LUI("lui") 
test_RR("and")
test_RR("or")
test_RR("xor")
test_RI("andi")
test_RI("ori")
test_RI("xori")
test_RR("sll")
test_RR("srl")
test_RR("sra")
test_RI("slli")
test_RI("srli")
test_RI("srai")

s_file.write("stop: j stop")    

### Conditional and  -----------------------------------------------------

gm_file = gd_br
s_file  = test_br

print_main()

OFFSET=0x0
TARGET=0
ADDR=0x100000
s_file.write("     lui x1,0x100\n")
s_file.write("")
s_file.write("")
PC = np.uint32(0x108)
test_J("jal")
test_J("jalr")
test_B("beq")
test_B("blt")
test_B("bge")
test_B("bltu")
test_B("bgeu")

s_file.write("stop: j stop") 



gd_a.close()
gd_dt.close()
gd_ls.close()
gd_br.close()


test_a.close()
test_dt.close()
test_ls.close()
test_br.close()



