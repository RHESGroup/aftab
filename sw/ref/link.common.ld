/* **************************************************************************************
*  Filename: link.common.ld  #
*  Project:  CNL_RISC-V
*  Version:  1.0
*  Date:     01 July, 2021  #
*
* Copyright (C) 2022 CINI Cybersecurity National Laboratory and University of Teheran
*
* This source file may be used and distributed without
* restriction provided that this copyright statement is not
* removed from the file and that any derivative work contains
* the original copyright notice and the associated disclaimer.
*
* This source file is free software; you can redistribute it
* and/or modify it under the terms of the GNU Lesser General
* Public License as published by the Free Software Foundation;
* either version 3.0 of the License, or (at your option) any
* later version.
*
* This source is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied
* warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
* PURPOSE. See the GNU Lesser General Public License for more
* details.
*
* You should have received a copy of the GNU Lesser General
* Public License along with this source; if not, download it
* from https://www.gnu.org/licenses/lgpl-3.0.txt
*
* **************************************************************************************
*
*  File content description:
*  Linker script for the AFTAB software system  #
*
* **************************************************************************************
*/

SEARCH_DIR(.)
__DYNAMIC  =  0;

MEMORY
{
    /*tuned segments dimension to allow simulations, modified Gianluca Roascio 1/07/2021*/
    instrram    : ORIGIN = 0x00000000, LENGTH = 0x1000 /* 4 K */
    dataram     : ORIGIN = 0x00100000, LENGTH = 0x600 /* 1.5 K*/
    stack       : ORIGIN = 0x00100600, LENGTH = 0xA00 /*2.5 K*/
}

/* Stack information variables */
_min_stack     = 0x500;   
_stack_len     = LENGTH(stack);
_stack_start   = ORIGIN(stack) + LENGTH(stack);

/* We have to align each sector to word boundaries as our current s19->slm
 * conversion scripts are not able to handle non-word aligned sections. */

SECTIONS
{
    .vectors :
    {
        . = ALIGN(4);
        KEEP(*(.vectors))
    } > instrram

    .text : {
        . = ALIGN(4);
        _stext = .;
        *(.text)
        _etext  =  .;
        __CTOR_LIST__ = .;
        LONG((__CTOR_END__ - __CTOR_LIST__) / 4 - 2)
        *(.ctors)
        LONG(0)
        __CTOR_END__ = .;
        __DTOR_LIST__ = .;
        LONG((__DTOR_END__ - __DTOR_LIST__) / 4 - 2)
        *(.dtors)
        LONG(0)
        __DTOR_END__ = .;
        *(.lit)
        *(.shdata)
        _endtext = .;
    }  > instrram

    /*--------------------------------------------------------------------*/
    /* Global constructor/destructor segement                             */
    /*--------------------------------------------------------------------*/

    .preinit_array     :
    {
      PROVIDE_HIDDEN (__preinit_array_start = .);
      KEEP (*(.preinit_array))
      PROVIDE_HIDDEN (__preinit_array_end = .);
    } > dataram

    .init_array     :
    {
      PROVIDE_HIDDEN (__init_array_start = .);
      KEEP (*(SORT(.init_array.*)))
      KEEP (*(.init_array ))
      PROVIDE_HIDDEN (__init_array_end = .);
    } > dataram

    .fini_array     :
    {
      PROVIDE_HIDDEN (__fini_array_start = .);
      KEEP (*(SORT(.fini_array.*)))
      KEEP (*(.fini_array ))
      PROVIDE_HIDDEN (__fini_array_end = .);
    } > dataram

    .rodata : {
        . = ALIGN(4);
        *(.rodata);
        *(.rodata.*)
    } > dataram

    .shbss :
    {
        . = ALIGN(4);
        *(.shbss)
    } > dataram

    .data : {
        . = ALIGN(4);
        sdata  =  .;
        _sdata  =  .;
        *(.data);
        *(.data.*)
        edata  =  .;
        _edata  =  .;
    } > dataram

    .bss :
    {
        . = ALIGN(4);
        _bss_start = .;
        *(.bss)
        *(.bss.*)
        *(.sbss)
        *(.sbss.*)
        *(COMMON)
        _bss_end = .;
    } > dataram

    /* ensure there is enough room for stack */
    .stack (NOLOAD): {
        . = ALIGN(4);
        . = . + _min_stack ;
        . = ALIGN(4);
        stack = . ;
        _stack = . ;
    } > stack

    .stab  0 (NOLOAD) :
    {
        [ .stab ]
    }

    .stabstr  0 (NOLOAD) :
    {
        [ .stabstr ]
    }

    .bss :
    {
        . = ALIGN(4);
        _end = .;
    } > dataram
}

