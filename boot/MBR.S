%include "boot.inc"

[bits 16]
section MBR vstart=0x7c00
START:
    cli
    mov ax,cs
    mov ds,ax
    mov ss,ax
    xor sp,sp
    mov bp,sp
    sti
    cld
    call readdisk_m16
    jmp LOADER_BASE_ADDR
readdisk_m16:
    mov dx,0x1f2
    mov al,LOADER_SECTOR_NUMBER
    out dx,al
    mov eax,LOADER_START_SECTOR
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
    xor ax,ax
    mov es,ax
    mov cx,LOADER_SECTOR_NUMBER * 0x100
    mov di,LOADER_BASE_ADDR
    mov dx,0x1f0
    rep insw
    ret
    times 510-($-$$) db 0
    dw 0xaa55