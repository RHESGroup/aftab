#!/usr/bin/python3

# **************************************************************************************
#  Filename: test_asm_csr_generator.py  #
#  Project:  CNL_RISC-V
#  Version:  1.0
#  Date:     1 April, 2022  #
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
#  Python script for auto generation of test_asm_csr.
#  Golden dumps are also created inside build/apps/test_asm_csr/slm_files. #
#
# **************************************************************************************

# NB:
# DO NOT REMOVE  "####\n" test_csr: ... "####\n" 
# from file ../ref/ctr0.boot_MU_test_csr.S 
# this script uptades that file thanks to that pattern. 


import numpy as np
import re 
import os, tempfile

from datetime import datetime as dt

ADDR=0x100000
OFFSET=0x0

used = [4,5,6,7]

def start_csr_test():
    global s_file 
    s_file.write("test_csr:\n")

def end_csr_test():
    global s_file 
    s_file.write("    jalr x0, x1\n")


def test_illegal():
    global OFFSET
    global ADDR
    global gm_file
    global s_file 
    s_file.write("    \n\
    # In file sw/apps/CMakeLists.txt uncomment: set(BOOT_MODE \"crt0_boot_MU_test_csr\")\n\
    csrrw  x0,0xC10,x4\n\
    sw     x9,512(x18)\n\
    li     x9,0 \n\
    csrrc  x4,0xC10,x4\n\
    sw     x9,516(x18)\n\
    li     x9,0\n\
    csrrs  x4,0xC10,x4\n\
    sw     x9,520(x18)\n\
    li     x9,0    \n\
    csrrwi x4,0xC10,3 \n\
    sw     x9,524(x18)\n\
    li     x9,0\n\
    csrrci x4,0xC10,3\n\
    sw     x9,528(x18)\n\
    li     x9,0\n\
    csrrsi x4,0xC10,3\n\
    sw     x9,532(x18)\n\
    li     x9,0\n\
    csrrw  x4,mie,x0\n\
    sw     x9,536(x18)\n\
    li     x9,0\n\
    csrrc  x4,mie,x0\n\
    sw     x9,540(x18)\n\
    li     x9,0\n\
    csrrs  x4,mie,x0 \n\
    sw     x9,544(x18)\n\
    li     x9,0    \n\
    csrrwi x4,mie,0\n\
    sw     x9,548(x18)\n\
    li     x9,0\n\
    csrrci x4,mie,0\n\
    sw     x9,552(x18)\n\
    li     x9,0\n\
    csrrsi x4,mie,0\n\
    sw     x9,556(x18)\n\
    li     x9,0\n  \
    ret")

    for i in range(1,13):
        gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(1),'08x').upper()+"\n")
        OFFSET+=4
        ADDR+=4


def test_CSR(op,csr,op2,ri):
    
    global OFFSET
    global ADDR
    global gm_file
    global s_file 
    s_file.write("    jal     x1, set_regs\n")
    it = iter(used)
    next_ = next(it)
    illegal=0 

    prev = next_

    if ( op2 == "r" and csr != "0xC10" ):
        s_file.write("    csrrw   x0,"+str(csr)+",x21\n") # Set register value

    if ( op == "csrrs" and  ri == "i" and op2 != "r" ):
        s_file.write("    csrrc   x0,"+str(csr)+",x20\n")  

    for n in used:
        if (n != used[len(used)-1]):
                ImmRes = 0
                next_ = next(it)
                res=0
                mask = 0
                rs1 = "x"+str(next_)
                rs1_val = REGS[next_]
                res = REGS[n]
                dstore = str(n)
                write = 0
                read = 0

                if ri == "i":
                    rs1 = str(IMM[n])
                    rs1_val = IMM[n]
                    res = IMM[prev]
                    ImmRes = IMM[prev] 

                if  op2 == "r":
                    res = 100

                if  op == "csrrci" and n!= 4 :
                    res = 0xFF
                
                if    csr =="mstatus":
                    res = res
                    ImmRes = ImmRes
                elif  csr == "mtvec":   
                    res =   0x00000401
                elif  csr == "mepc":    # All bits RW
                     res =  res 
                     mask = res 
                elif  csr == "mcause":  # 31 and [4:0] are rw
                    res = res & 0x8000001F
                    ImmRes = ImmRes & 0x8000001F
                elif  csr == "0xC10":   # All R only
                    if op2 == "rw" or op2 == "w":
                        illegal = 1
                    elif ( op2 == "r") :
                        res = 3                    
                else :
                    illegal = 1

                mask = res

                # if  csr == "mtvec": 
                #     mask = mask & 0xFFFFFFFE 

                if  op == "csrrci" and n!= 4 :
                    mask = ImmRes

                if op2 == "r":
                        mask = 0

              
                if  op == "csrrw":
                    if op2 == "w" and illegal == 0 :
                        write = 1
                        dstore = str(next_)
                    if ri == "i":
                         op = "csrrwi"

                elif op == "csrrc" or  op == "csrrs" or op == "csrrci" or op == "csrrsi":
                    if  op2 == "r" and ri == "r":
                        rs1 = "x0"                        
                    elif op2 == "r" and ri == "i":
                        rs1 = "0"
                    if op == "csrrc" or op == "csrrci" :
                        
                        if ri == "i":
                            op ="csrrci"
                            if n == 4 : 
                                s_file.write("    csrrw   x0,"+str(csr)+",x22\n") # Set register value
                        res =  res & ~mask
                    
                         
                    elif  op == "csrrs" or op == "csrrsi":
                        res =  res | mask 
                        if ri == "i":
                            op = "csrrsi"

                    # res =  1 if REGS[n+1] < IMM[n] else 0

                if write == 1:
                    s_file.write("    "+op+"   x0,"+str(csr)+","+rs1+"\n")
                    res = REGS[next_]
                    write == 0 

                

                     

                s_file.write("    "+op+"   x"+str(n)+","+str(csr)+","+rs1+"\n")

                if  csr == "mtvec":   
                    res =   0x00000401    

                if illegal == 0: 
                    if n != 4 :
                        if  csr == "mtvec":   
                            s_file.write("    li      x"+dstore+",0x401\n")  

                        s_file.write("    sw      x"+dstore+","+str(np.uint32(OFFSET))+"(x18)\n")

                        if ( op == "csrrs" or op == "csrrsi") and op2 != "r":
                            s_file.write("    csrrc   x0,"+str(csr)+",x20\n") # Clear all bits before setting
                            s_file.write("    "+op+"   x"+str(n)+","+str(csr)+","+rs1+"\n")
                        if op == "csrrci":
                           s_file.write("    csrrw   x0,"+str(csr)+",x22\n") 
                           s_file.write("    "+op+"   x"+str(n)+","+str(csr)+","+rs1+"\n")         
                    
                    
                else:
                    s_file.write("    sw      x9,"+str(np.uint32(OFFSET))+"(x18)\n")
                    s_file.write("    li      x9,0\n")
                    res=1
                    
                if n != 4 or illegal == 1  :
                    gm_file.write(format(ADDR,'08x').upper()+"_"+format(np.uint32(res),'08x').upper()+"\n")
                    OFFSET+=4
                    ADDR+=4
                    illegal=0 
                    if OFFSET == 0x7FC:
                        s_file.write("    addi  x18,x8,0x7FC\n")
                        OFFSET=0

                prev = n



def test_CSRR(op,ri):
    
    op2="w"
    if op == "csrrc" or op == "csrrci" or op == "csrrs" or op == "csrrsi" :
         op2="r"

    
    # read mstatus
    s_file.write("    csrrci  x19,mstatus,0\n")

    test_CSR(op,"mstatus","rw",ri)
    test_CSR(op,"mstatus",op2,ri)

    # restore mstatus 
    s_file.write("    csrrw   x0,mstatus,x19\n")

    test_CSR(op,"mtvec","rw",ri)
    test_CSR(op,"mtvec",op2,ri)

    test_CSR(op,"mcause","rw",ri)
    test_CSR(op,"mcause",op2,ri)

    test_CSR(op,"mepc","rw",ri)
    test_CSR(op,"mepc",op2,ri)

    test_CSR(op,"0xC10","rw",ri)
    test_CSR(op,"0xC10",op2,ri)
                



IMM = np.array([ 0x0,               #I0
                 0x0,               #I1        
                 0x0,               #I2
                 0x1,               #I3
                 0x2,               #I4
                 1,                 #I5
                 2,                 #I6
                 0x1,              #I7
                 0x1,              #I8 
                 0x7F8,            #I9
                 0x7FF,            #I10
                 0x70F,            #I11
                 100,              #I12
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
                 0x3FF,            #I23
                 5,                 #I24
                 0x3FF,            #I24
                 5,                 #I26
                 1,                 #I27
                 2,                 #I28
                 14,                #I29
                 7,                 #I30
                 17,                #I31
                 ],                  
                 np.int32)


REGS = np.array([0x0,               #R0
                 0x0,               #R1        
                 0x0,               #R2
                 0x1,               #R3
                 0x2,               #R4
                 -1,                #R5
                 -2,                #R6
                 -0x1,              #R7
                 -0x1,              #R8
                 0x7F87F8,             #R9
                 0x7FF7FF,             #R10
                 0x70F70F,             #R11
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


def print_main():
    s_file.write("\n    .text\n")
    s_file.write("    .globl    main\n")
    s_file.write("    .type main, @function\n")
    s_file.write("main:\n")



def set_regs():
  global s_file 
  s_file.write("\n")
  s_file.write("\n    .text\n")
  s_file.write("    .globl  set_regs\n")
  s_file.write("    .type   set_regs, @function\n")
  s_file.write("set_regs:\n")
  for n in used:
        if  (REGS[n] > 0x7FF):
            l = np.uint32(REGS[n] << 20) >> 20
            h = (REGS[n] >> 12)
            s_file.write("    lui  x"+str(n)+","+str(hex(h))+"\n")
            s_file.write("    addi x"+str(n)+",x"+str(n)+","+str(hex(l))+"\n")
        else:
            s_file.write("    li x"+str(n)+","+str(hex(REGS[n]))+"\n")
  s_file.write("    jalr x0, x1\n")
  s_file.write("\n")

# Open files

license_intro =  open("license_intro.txt", "r")
timestamp = dt.timestamp(dt.now())
date_time = dt.fromtimestamp(timestamp)


read_license = license_intro.read()
license_intro.close()

file_name = "crt0.boot_MU_test_csr.S"
license_boot = re.sub(r"Filename:.*?#", "Filename: "+file_name+"  #", read_license, 0, re.DOTALL)
data = date_time.strftime("%d %B, %Y")
license_boot = re.sub(r"Date:.*?#", "Date:     "+data+"  #", license_boot, 0, re.DOTALL)
description = "Machine-User bootloader customized for Control and Status Registers test."
license_boot = re.sub(r"File content description:.*?#\n", "File content description:\n#  "+description+"  ", license_boot, 0, re.DOTALL)
   
file_name = "test_asm_csr.s"
license_test_asm = re.sub(r"Filename:.*?#", "Filename: "+file_name+"  #", read_license, 0, re.DOTALL)
data = date_time.strftime("%d %B, %Y")
license_test_asm = re.sub(r"Date:.*?#", "Date:     "+data+"  #", license_test_asm, 0, re.DOTALL)
description = "Assembly test of illegal csr-instruction for missing privileges."
license_test_asm = re.sub(r"File content description:.*?#\n", "File content description:\n#  "+description+"  ", license_test_asm, 0, re.DOTALL)



gd_c  = open("../build/apps/test_asm_csr/slm_files/golden_dump.txt", "w+")
test_c  = open("../apps/test_asm_csr/test_asm_csr.s", "w+")

tmp = open("../ref/tmp.S", "a")
test_c_bootloader  = open("../ref/crt0.boot_MU_test_csr.S", "r")




#print(license_test_asm)


# print(lines)
gm_file = gd_c
s_file  =  tmp

OFFSET=0x0
ADDR=0x100000


s_file.write("")
start_csr_test()
s_file.write("   mv x23,x1\n")
s_file.write("   lui x18,0x100\n")
s_file.write("")
s_file.write("")
s_file.write("    li x20, -1\n")
s_file.write("    li x21, 100\n")
s_file.write("    li x22, 0xFF\n")

test_CSRR("csrrw","r")
test_CSRR("csrrc","r")
test_CSRR("csrrs","r")

test_CSRR("csrrw","i")
test_CSRR("csrrc","i")
test_CSRR("csrrs","i")
s_file.write("   mv x1,x23\n")
s_file.write("   li x23,0\n")
end_csr_test()

s_file.close()
tmp = open("../ref/tmp.S", "r")

content = tmp.read()

tmp.close()
os.remove(tmp.name)


s_file  =  test_c_bootloader
lines = s_file.read()
test_c_bootloader.close()

test_c_bootloader  = open("../ref/crt0.boot_MU_test_csr.S", "w")
s_file  =  test_c_bootloader


res = re.sub(r"#### TEST.*?####", "#### TEST\n"+content+"\n####\n", lines, 0, re.DOTALL)
res = re.sub(r"## LICENSE.*?##", "## LICENSE\n"+license_boot+"\n##\n", res, 0, re.DOTALL)


s_file.write(res)

# print(res)

### CSR test -----------------------------------------------------


s_file  = test_c
s_file.write(license_test_asm)
print_main()
s_file.write("   lui x18,0x100\n")
s_file.write("")
s_file.write("")
s_file.write("   jal x1, set_regs\n")
test_illegal()
set_regs()

# s_file.write("fine:")   
# s_file.write("     j fine")   

gd_c.close()
test_c.close()
test_c_bootloader.close()
