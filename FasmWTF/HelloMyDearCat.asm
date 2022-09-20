format PE64 NX GUI  6.0
entry start

macro import_directory_table [lib] {
forward
        dd rva IAT__#lib
        dd 0
        dd 0
        dd rva NAME__#lib 
        dd rva IAT__#lib

common
        dd 5 dup(0)

forward
        NAME__#lib db `lib, ".DLL", 0
}

macro import_functions libname, [funcnames] {
forward
      if $ & 1
         db 0
      end if
      IMPORTNAME__#funcnames dw 0
                             db `funcnames, 0
common
        IAT__#libname:
forward
        funcnames dq rva IMPORTNAME__#funcnames

common
        dq 0
}


macro call64_putreg param*, reg*
{
        if ~ (reg eqtype rax)
           display "target must be a register"
           err
        end if
        if ~ param eq reg
            mov reg, param
        end if
}

macro call64 fn*, [arg]
{
common
        local nargs, arg_idx, stack_space

        if nargs <= 4
           stack_space = 5 * 8
        else if nargs & 1
           stack_space = nargs * 8
        else
           stack_space = (nargs + 1) * 8
        end if

        if stack_space
           sub rsp, stack_space
        end if

        arg_idx = 0

forward
        match ,arg
        \{
        \}
        match any,arg
        \{
           arg_idx = arg_idx + 1
           if arg_idx = 1
               call64_putreg arg, rcx
           else if arg_idx = 2
               call64_putreg arg, rdx
           else if arg_idx = 3
               call64_putreg arg, r8
           else if arg_idx = 4
               call64_putreg arg, r9
           else
               mov qword [rsp + (arg_idx-1)*8], arg
           end if

        \}
common
        nargs = arg_idx
        call fn
        if stack_space
           add rsp, stack_space
        end if
}

section '.text' code readable executable
        HelloStr db "Hello my dear cat", 0
        CatStr   db "Meow ><", 0
start:
        call64 [MessageBoxA], 0, HelloStr, CatStr, 0
        call64 [ExitProcess], 0

section '.idata' import readable writeable
        import_directory_table  KERNEL32,       USER32
        import_functions        KERNEL32,       ExitProcess
        import_functions        USER32,         MessageBoxA