%include "boot.inc"

[bits 16]
section Loader vstart=LOADER_BASE_ADDR
START:
    mov ax,cs
    mov ds,ax
    mov ss,ax
    in al,92h
    or al,00000010b
    out 92h,al
    lgdt [gdt_ptr]
    mov eax,[idt_start]
    mov edx,[idt_start+4]
    mov bx,idt_start+8
    mov cx,0x80
    .init_loop:
        mov [bx],eax
        mov [bx+4],edx
        add bx,8
        loop .init_loop
    mov word [idt_start+64],int_0x08
    mov word [idt_start+72],int_0x09
    lidt [idt_ptr]
    mov eax,cr0
    or eax,1
    mov cr0,eax
    jmp word 0x0008:protected_mode

[bits 32]
protected_mode:
    mov ax,0x0010
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov esp,0x80000
    mov ebp,esp
    mov ax,0x0018
    mov gs,ax
    mov dword [0x500],getchar
    mov dword [0x504],gdt_ptr
    mov dword [0x508],idt_ptr
    mov dword [0x50C],0
    call readdisk_m32
    ;载入PE程序
    mov ebx,COFF_BASE_ADDR
    cmp word [ebx],0x5a4d
    jnz Error
    mov eax,[ebx+60]
    add ebx,eax
    cmp dword [ebx],0x00004550
    jnz Error
    cmp word [ebx+20],0xE0
    jnz Error
    push dword [ebx+40]
    mov edx,[ebx+52]
    xor ecx,ecx
    mov cx,[ebx+6]
    jcxz Error
    add ebx,0xF8
    xor esi,esi
    .load_seg:
        push ecx
        mov edi,[ebx+12]
        mov ecx,[ebx+16]
        mov esi,[ebx+20]
        add esi,COFF_BASE_ADDR
        shr ecx,2
        add edi,edx
        rep movsd
        pop ecx
        add ebx,40
        loop .load_seg
    pop eax
    add eax,edx
    mov esp,edx
    mov ebp,esp
    finit ;要用浮点数运算就加上去
    call eax
    mov eax,cr0
    and al,0xfe
    mov cr0,eax
    jmp dword 0xffff:0
Error:
    not byte [gs:0x01]
    hlt
    jmp Error
int_all:
    iret
int_0x08:
    pushad
    ;not byte [gs:0x07]
    mov eax,[0x50C]
    test eax,eax
    jz .L1
    call eax
    .L1:
    mov al,0x20
    out 0x20,al
    popad
    iret
int_0x09:
    pushad
    in al,0x60
    mov [getchar.ch],al
    mov al,0x20
    out 0x20,al
    popad
    iret
readdisk_m32:
    mov dx,0x1f2
    mov al,COFF_SECTOR_NUMBER
    out dx,al
    mov eax,COFF_START_SECTOR
    mov dx,0x1f3
    out dx,al
    mov dx,0x1f4
    mov cl,8
    shr eax,cl
    out dx,al
    mov dx,0x1f5
    shr eax,cl
    out dx,al
    mov dx,0x1f6
    shr eax,cl
    and al,0xf
    or al,0xe0
    out dx,al
    mov dx,0x1f7
    mov al,0x20
    out dx,al
    .wait_loop:
        nop
        in al,dx
        and al,0x88
        cmp al,0x8
        jnz .wait_loop
    mov ax,ds
    mov es,ax
    mov ecx,COFF_SECTOR_NUMBER * 0x80
    mov edi,COFF_BASE_ADDR
    mov dx,0x1f0
    rep insd
    ret
getchar:
    xor al,al
    cmp byte [.ch],0
    jz .L0
    xchg al,[.ch]
    ret
    .L0:
    hlt
    xchg al,[.ch]
    test al,al
    jz .L0
    ret
    .ch:db 0

gdt_ptr:
    dw gdt_end - gdt_start - 1
    dd gdt_start
gdt_start:
    dd 0
    dd 0
    dd (0x0000 << 16) | 0x1000
    dd (0x00 << 24) | DESC_G_4K | DESC_D_32 | DESC_P | (0x0 << 16) | DESC_DPL_0 | DESC_TYPE_CODE | DESC_CODE_READABLE | 0x00
    dd (0x0000 << 16) | 0x1000
    dd (0x00 << 24) | DESC_G_4K | DESC_D_32 | DESC_P | (0x0 << 16) | DESC_DPL_0 | DESC_TYPE_DATA | DESC_DATA_WRITABLE | 0x00
    dd (0x8000 << 16) | 0x1040
    dd (0x00 << 24) | DESC_D_32 | DESC_P | (0x0 << 16) | DESC_DPL_0 | DESC_TYPE_DATA | DESC_DATA_WRITABLE | 0x0B
gdt_end:

idt_ptr:
    dw idt_end - idt_start - 1
    dd idt_start
idt_start:
    dw int_all
    dw 0x0008
    dd (0x0000 << 16) | DESC_P | DESC_DPL_0 | INTR_TYPE_INT32
    times 0x400 db 0
idt_end:
