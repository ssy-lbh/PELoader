	.file	"main.cpp"
	.globl	__GDT
	.bss
__GDT:
	.space 8
	.globl	__IDT
__IDT:
	.space 8
	.globl	_getchar
	.align 4
_getchar:
	.space 4
	.section .rdata,"dr"
LC0:
	.ascii "DRIVE\0"
LC1:
	.ascii "test\0"
LC2:
	.ascii ">>>\0"
LC3:
	.ascii "\0"
LC4:
	.ascii "cd\0"
LC5:
	.ascii "..\0"
LC6:
	.ascii "This path is not a folder\12\0"
LC7:
	.ascii "Path not found\12\0"
LC8:
	.ascii "type\0"
LC9:
	.ascii "This path is a folder\12\0"
LC10:
	.ascii "Unknown command.\12\0"
	.text
	.globl	__Z6__mainv
	.def	__Z6__mainv;	.scl	2;	.type	32;	.endef
__Z6__mainv:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$312, %esp
	movl	$0, (%esp)
	call	__Z12SetCursorPost
	movl	$0, __ZZ6__mainvE1i
	jmp	L2
L3:
	movl	__ZZ6__mainvE1i, %eax
/APP
 # 99 ".\cpp\main.cpp" 1
	gs movw $0x1700,(%eax)
 # 0 "" 2
/NO_APP
	movl	__ZZ6__mainvE1i, %eax
	addl	$2, %eax
	movl	%eax, __ZZ6__mainvE1i
L2:
	movl	__ZZ6__mainvE1i, %eax
	cmpl	$4159, %eax
	jbe	L3
/APP
 # 107 ".\cpp\main.cpp" 1
	mov $0x36,%al
out %al,$0x43
mov $11932,%ax
out %al,$0x40
mov %ah,%al
out %al,$0x40

 # 0 "" 2
/NO_APP
	movl	$1292, %eax
	movl	$__Z8tickProcv, %edx
	movl	%edx, (%eax)
	movl	$__GDT, %eax
/APP
 # 109 ".\cpp\main.cpp" 1
	sgdt (%eax)
 # 0 "" 2
/NO_APP
	movl	$__IDT, %eax
/APP
 # 110 ".\cpp\main.cpp" 1
	sidt (%eax)
 # 0 "" 2
/NO_APP
	movl	$1280, %eax
	movl	(%eax), %eax
	movl	%eax, _getchar
	movl	$__ZZ6__mainvE4node, 8(%esp)
	movl	$1, 4(%esp)
	movl	$256, (%esp)
	call	__Z8ReadDiskjhPv
	movl	__ZZ6__mainvE4node+252, %eax
	cmpl	$1162627398, %eax
	je	L4
	movl	$0, __ZZ6__mainvE1i
	jmp	L5
L6:
	movl	__ZZ6__mainvE1i, %eax
	sall	$2, %eax
	addl	$__ZZ6__mainvE4node, %eax
	movl	$0, (%eax)
	movl	__ZZ6__mainvE1i, %eax
	addl	$1, %eax
	movl	%eax, __ZZ6__mainvE1i
L5:
	movl	__ZZ6__mainvE1i, %eax
	cmpl	$63, %eax
	jbe	L6
	movl	$LC0, 4(%esp)
	movl	$__ZZ6__mainvE4node, (%esp)
	call	__Z6strcpyPcPKc
	movl	$1, __ZZ6__mainvE4node+244
	movl	$1, __ZZ6__mainvE4node+248
	movl	$1162627398, __ZZ6__mainvE4node+252
	movl	$__ZZ6__mainvE4node, 8(%esp)
	movl	$1, 4(%esp)
	movl	$256, (%esp)
	call	__Z9WriteDiskjhPKv
L4:
	movl	__ZZ6__mainvE3top, %eax
	movl	$256, __ZZ6__mainvE4addr(,%eax,4)
	movl	__ZZ6__mainvE3top, %eax
	leal	1(%eax), %edx
	movl	%edx, __ZZ6__mainvE3top
	sall	$8, %eax
	addl	$__ZZ6__mainvE4name, %eax
	movl	$__ZZ6__mainvE4node, 4(%esp)
	movl	%eax, (%esp)
	call	__Z6strcpyPcPKc
	movl	__ZZ6__mainvE4node+244, %eax
	addl	$1, %eax
	movl	%eax, __ZZ6__mainvE4node+244
	movl	$257, __ZZ6__mainvE4node+32
	movl	$1162627398, -32(%ebp)
	movl	$1, -36(%ebp)
	movl	$LC1, 4(%esp)
	leal	-284(%ebp), %eax
	movl	%eax, (%esp)
	call	__Z6strcpyPcPKc
	movl	$512, -40(%ebp)
	movl	$258, -252(%ebp)
	leal	-284(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$1, 4(%esp)
	movl	$257, (%esp)
	call	__Z9WriteDiskjhPKv
	movl	$__ZL8KeyTable, 8(%esp)
	movl	$1, 4(%esp)
	movl	$258, (%esp)
	call	__Z9WriteDiskjhPKv
	movl	$0, __ZZ6__mainvE1i
	jmp	L7
L8:
	movl	__ZZ6__mainvE1i, %eax
	sall	$8, %eax
	addl	$__ZZ6__mainvE4name, %eax
	movl	%eax, (%esp)
	call	__Z4putsPKc
	movl	$92, (%esp)
	call	__Z7putcharc
	movl	__ZZ6__mainvE1i, %eax
	addl	$1, %eax
	movl	%eax, __ZZ6__mainvE1i
L7:
	movl	__ZZ6__mainvE1i, %edx
	movl	__ZZ6__mainvE3top, %eax
	cmpl	%eax, %edx
	jb	L8
	movl	$LC2, (%esp)
	call	__Z4putsPKc
L48:
	movl	_getchar, %eax
	call	*%eax
	movzbl	%al, %eax
	movzbl	__ZL8KeyTable(%eax), %eax
	movb	%al, -25(%ebp)
	cmpb	$0, -25(%ebp)
	jne	L9
	jmp	L10
L9:
	cmpb	$32, -25(%ebp)
	jne	L11
	movl	$32, (%esp)
	call	__Z7putcharc
	movl	__ZZ6__mainvE4argc, %eax
	sall	$8, %eax
	addl	$__ZZ6__mainvE4argv, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	L12
	jmp	L10
L12:
	movl	__ZZ6__mainvE4argc, %eax
	leal	1(%eax), %edx
	movl	%edx, __ZZ6__mainvE4argc
	movl	__ZZ6__mainvE5index, %edx
	sall	$8, %eax
	addl	%edx, %eax
	addl	$__ZZ6__mainvE4argv, %eax
	movb	$0, (%eax)
	movl	$0, __ZZ6__mainvE5index
	movl	__ZZ6__mainvE4argc, %eax
	sall	$8, %eax
	addl	$__ZZ6__mainvE4argv, %eax
	movb	$0, (%eax)
	jmp	L10
L11:
	cmpb	$10, -25(%ebp)
	jne	L13
	movl	__ZZ6__mainvE4argc, %edx
	movl	__ZZ6__mainvE5index, %eax
	sall	$8, %edx
	addl	%edx, %eax
	addl	$__ZZ6__mainvE4argv, %eax
	movb	$0, (%eax)
	call	__Z10changeLinev
	movl	$LC3, 4(%esp)
	movl	$__ZZ6__mainvE4argv, (%esp)
	call	__Z6strcmpPKcS0_
	testl	%eax, %eax
	sete	%al
	testb	%al, %al
	jne	L14
	movl	$LC4, 4(%esp)
	movl	$__ZZ6__mainvE4argv, (%esp)
	call	__Z6strcmpPKcS0_
	testl	%eax, %eax
	sete	%al
	testb	%al, %al
	je	L15
	movl	$LC5, 4(%esp)
	movl	$__ZZ6__mainvE4argv+256, (%esp)
	call	__Z6strcmpPKcS0_
	testl	%eax, %eax
	sete	%al
	testb	%al, %al
	je	L16
	movl	__ZZ6__mainvE3top, %eax
	cmpl	$1, %eax
	jbe	L17
	movl	__ZZ6__mainvE3top, %eax
	subl	$2, %eax
	movl	__ZZ6__mainvE4addr(,%eax,4), %eax
	movl	$__ZZ6__mainvE4node, 8(%esp)
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	__Z8ReadDiskjhPv
	movl	__ZZ6__mainvE3top, %eax
	subl	$1, %eax
	movl	%eax, __ZZ6__mainvE3top
	jmp	L17
L16:
	movl	$0, -12(%ebp)
	movl	$0, __ZZ6__mainvE1i
	jmp	L18
L26:
	movl	__ZZ6__mainvE4node+244, %edx
	movl	__ZZ6__mainvE1i, %eax
	cmpl	%eax, %edx
	ja	L19
	jmp	L25
L19:
	movl	__ZZ6__mainvE1i, %eax
	addl	$8, %eax
	movl	__ZZ6__mainvE4node(,%eax,4), %eax
	leal	-284(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	__Z8ReadDiskjhPv
	movl	-32(%ebp), %eax
	cmpl	$1162627398, %eax
	jne	L22
	movl	$32, 8(%esp)
	movl	$__ZZ6__mainvE4argv+256, 4(%esp)
	leal	-284(%ebp), %eax
	movl	%eax, (%esp)
	call	__Z7strncmpPKcS0_i
	testl	%eax, %eax
	sete	%al
	testb	%al, %al
	je	L22
	movl	$1, -12(%ebp)
	movl	-36(%ebp), %eax
	cmpl	$1, %eax
	je	L24
	movl	$LC6, (%esp)
	call	__Z4putsPKc
	jmp	L25
L24:
	movl	__ZZ6__mainvE3top, %eax
	movl	__ZZ6__mainvE1i, %edx
	addl	$8, %edx
	movl	__ZZ6__mainvE4node(,%edx,4), %edx
	movl	%edx, __ZZ6__mainvE4addr(,%eax,4)
	movl	__ZZ6__mainvE3top, %eax
	leal	1(%eax), %edx
	movl	%edx, __ZZ6__mainvE3top
	sall	$8, %eax
	leal	__ZZ6__mainvE4name(%eax), %edx
	leal	-284(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	__Z6strcpyPcPKc
	movl	$256, %eax
	movl	%eax, 8(%esp)
	leal	-284(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$__ZZ6__mainvE4node, (%esp)
	call	__Z6memcpyPvPKvi
	nop
	jmp	L25
L22:
	movl	__ZZ6__mainvE1i, %eax
	addl	$1, %eax
	movl	%eax, __ZZ6__mainvE1i
L18:
	movl	__ZZ6__mainvE1i, %eax
	cmpl	$52, %eax
	jbe	L26
L25:
	cmpl	$0, -12(%ebp)
	jne	L17
	movl	$LC7, (%esp)
	call	__Z4putsPKc
L17:
	jmp	L14
L15:
	movl	$LC8, 4(%esp)
	movl	$__ZZ6__mainvE4argv, (%esp)
	call	__Z6strcmpPKcS0_
	testl	%eax, %eax
	sete	%al
	testb	%al, %al
	je	L27
	movl	$0, -16(%ebp)
	movl	$0, __ZZ6__mainvE1i
	jmp	L28
L44:
	movl	__ZZ6__mainvE4node+244, %edx
	movl	__ZZ6__mainvE1i, %eax
	cmpl	%eax, %edx
	ja	L29
	jmp	L43
L29:
	movl	__ZZ6__mainvE1i, %eax
	addl	$8, %eax
	movl	__ZZ6__mainvE4node(,%eax,4), %eax
	leal	-284(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	__Z8ReadDiskjhPv
	movl	-32(%ebp), %eax
	cmpl	$1162627398, %eax
	jne	L32
	movl	$32, 8(%esp)
	movl	$__ZZ6__mainvE4argv+256, 4(%esp)
	leal	-284(%ebp), %eax
	movl	%eax, (%esp)
	call	__Z7strncmpPKcS0_i
	testl	%eax, %eax
	sete	%al
	testb	%al, %al
	je	L33
	movl	$1, -16(%ebp)
	movl	-36(%ebp), %eax
	cmpl	$1, %eax
	jne	L34
	movl	$LC9, (%esp)
	call	__Z4putsPKc
	jmp	L43
L34:
	movl	$0, -20(%ebp)
	jmp	L35
L42:
	movl	-20(%ebp), %eax
	shrl	$9, %eax
	addl	$8, %eax
	movl	-284(%ebp,%eax,4), %eax
	movl	$__ZZ6__mainvE6buffer, 8(%esp)
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	__Z8ReadDiskjhPv
	movl	-40(%ebp), %eax
	subl	-20(%ebp), %eax
	cmpl	$511, %eax
	ja	L36
	movl	$0, -24(%ebp)
	jmp	L37
L38:
	movl	-24(%ebp), %eax
	addl	$__ZZ6__mainvE6buffer, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	addl	$1, -20(%ebp)
L37:
	movl	-40(%ebp), %eax
	subl	-20(%ebp), %eax
	cmpl	-24(%ebp), %eax
	ja	L38
	jmp	L39
L36:
	movl	$0, -24(%ebp)
	jmp	L40
L41:
	movl	-24(%ebp), %eax
	addl	$__ZZ6__mainvE6buffer, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	addl	$1, -24(%ebp)
L40:
	cmpl	$511, -24(%ebp)
	jbe	L41
L39:
	call	__Z10changeLinev
	addl	$512, -20(%ebp)
L35:
	movl	-40(%ebp), %eax
	cmpl	-20(%ebp), %eax
	ja	L42
	nop
	jmp	L43
L33:
L32:
	movl	__ZZ6__mainvE1i, %eax
	addl	$1, %eax
	movl	%eax, __ZZ6__mainvE1i
L28:
	movl	__ZZ6__mainvE1i, %eax
	cmpl	$52, %eax
	jbe	L44
L43:
	cmpl	$0, -16(%ebp)
	jne	L45
	movl	$LC7, (%esp)
	call	__Z4putsPKc
L45:
	jmp	L14
L27:
	movl	$LC10, (%esp)
	call	__Z4putsPKc
L14:
	movl	$0, __ZZ6__mainvE5index
	movl	$0, __ZZ6__mainvE4argc
	movb	$0, __ZZ6__mainvE4argv
	movl	$0, __ZZ6__mainvE1i
	jmp	L46
L47:
	movl	__ZZ6__mainvE1i, %eax
	sall	$8, %eax
	addl	$__ZZ6__mainvE4name, %eax
	movl	%eax, (%esp)
	call	__Z4putsPKc
	movl	$92, (%esp)
	call	__Z7putcharc
	movl	__ZZ6__mainvE1i, %eax
	addl	$1, %eax
	movl	%eax, __ZZ6__mainvE1i
L46:
	movl	__ZZ6__mainvE1i, %edx
	movl	__ZZ6__mainvE3top, %eax
	cmpl	%eax, %edx
	jb	L47
	movl	$LC2, (%esp)
	call	__Z4putsPKc
	jmp	L10
L13:
	movl	__ZZ6__mainvE4argc, %edx
	movl	__ZZ6__mainvE5index, %eax
	sall	$8, %edx
	addl	%edx, %eax
	leal	__ZZ6__mainvE4argv(%eax), %edx
	movzbl	-25(%ebp), %eax
	movb	%al, (%edx)
	movsbl	-25(%ebp), %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	movl	__ZZ6__mainvE5index, %eax
	addl	$1, %eax
	movl	%eax, __ZZ6__mainvE5index
L10:
	jmp	L48
	.globl	__Z8tickProcv
	.def	__Z8tickProcv;	.scl	2;	.type	32;	.endef
__Z8tickProcv:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	call	__Z12GetCursorPosv
	movw	%ax, __ZZ8tickProcvE3pos
	movl	$60, (%esp)
	call	__Z12SetCursorPost
/APP
 # 253 ".\cpp\main.cpp" 1
	mov $4,%al
out %al,$0x70
in $0x71,%al

 # 0 "" 2
/NO_APP
	movb	%al, __ZZ8tickProcvE3num
	movzbl	__ZZ8tickProcvE3num, %eax
	movzbl	%al, %eax
	sarl	$4, %eax
	movzbl	__ZL8HexTable(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	movzbl	__ZZ8tickProcvE3num, %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movzbl	__ZL8HexTable(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	movl	$58, (%esp)
	call	__Z7putcharc
/APP
 # 261 ".\cpp\main.cpp" 1
	mov $2,%al
out %al,$0x70
in $0x71,%al

 # 0 "" 2
/NO_APP
	movb	%al, __ZZ8tickProcvE3num
	movzbl	__ZZ8tickProcvE3num, %eax
	movzbl	%al, %eax
	sarl	$4, %eax
	movzbl	__ZL8HexTable(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	movzbl	__ZZ8tickProcvE3num, %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movzbl	__ZL8HexTable(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	movl	$58, (%esp)
	call	__Z7putcharc
/APP
 # 269 ".\cpp\main.cpp" 1
	mov $0,%al
out %al,$0x70
in $0x71,%al

 # 0 "" 2
/NO_APP
	movb	%al, __ZZ8tickProcvE3num
	movzbl	__ZZ8tickProcvE3num, %eax
	movzbl	%al, %eax
	sarl	$4, %eax
	movzbl	__ZL8HexTable(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	movzbl	__ZZ8tickProcvE3num, %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movzbl	__ZL8HexTable(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	movzwl	__ZZ8tickProcvE3pos, %eax
	movzwl	%ax, %eax
	movl	%eax, (%esp)
	call	__Z12SetCursorPost
	leave
	ret
	.globl	__Z10changeLinev
	.def	__Z10changeLinev;	.scl	2;	.type	32;	.endef
__Z10changeLinev:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	call	__Z12GetCursorPosv
	movzwl	%ax, %eax
	imull	$52429, %eax, %eax
	shrl	$16, %eax
	shrw	$6, %ax
	movzwl	%ax, %eax
	addl	$1, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movw	%ax, -10(%ebp)
	cmpw	$1999, -10(%ebp)
	jbe	L51
	call	__Z10rollScreenv
	subw	$80, -10(%ebp)
L51:
	movzwl	-10(%ebp), %eax
	movl	%eax, (%esp)
	call	__Z12SetCursorPost
	leave
	ret
	.globl	__Z10rollScreenv
	.def	__Z10rollScreenv;	.scl	2;	.type	32;	.endef
__Z10rollScreenv:
	pushl	%ebp
	movl	%esp, %ebp
/APP
 # 290 ".\cpp\main.cpp" 1
	mov $160,%esi
mov $0,%edi
mov $2000,%ecx
rep gs movsw

 # 0 "" 2
/NO_APP
	popl	%ebp
	ret
	.globl	__Z7putcharc
	.def	__Z7putcharc;	.scl	2;	.type	32;	.endef
__Z7putcharc:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$52, %esp
	movl	8(%ebp), %eax
	movb	%al, -28(%ebp)
	cmpb	$0, -28(%ebp)
	jne	L54
	jmp	L53
L54:
	cmpb	$10, -28(%ebp)
	jne	L56
	call	__Z10changeLinev
	jmp	L53
L56:
	call	__Z12GetCursorPosv
	movzwl	%ax, %eax
	movl	%eax, -12(%ebp)
	movzbl	-28(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, %ebx
/APP
 # 301 ".\cpp\main.cpp" 1
	gs movb %al,(,%ebx,2)
 # 0 "" 2
/NO_APP
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	movzwl	%ax, %eax
	movl	%eax, (%esp)
	call	__Z12SetCursorPost
L53:
	addl	$52, %esp
	popl	%ebx
	popl	%ebp
	ret
	.globl	__Z4putsPKc
	.def	__Z4putsPKc;	.scl	2;	.type	32;	.endef
__Z4putsPKc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$0, -12(%ebp)
	jmp	L58
L59:
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	__Z7putcharc
	addl	$1, -12(%ebp)
L58:
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	L59
	leave
	ret
	.globl	__Z4lockPh
	.def	__Z4lockPh;	.scl	2;	.type	32;	.endef
__Z4lockPh:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	%eax, %ebx
/APP
 # 319 ".\cpp\main.cpp" 1
	mov $1,%al
1:lock xchg (%ebx),%al
test %al,%al
jnz 1b

 # 0 "" 2
/NO_APP
	popl	%ebx
	popl	%ebp
	ret
	.globl	__Z6unlockPh
	.def	__Z6unlockPh;	.scl	2;	.type	32;	.endef
__Z6unlockPh:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movb	$0, (%eax)
	popl	%ebp
	ret
	.globl	__Z8ReadDiskjhPv
	.def	__Z8ReadDiskjhPv;	.scl	2;	.type	32;	.endef
__Z8ReadDiskjhPv:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	subl	$4, %esp
	movl	12(%ebp), %eax
	movb	%al, -8(%ebp)
	movzbl	-8(%ebp), %eax
/APP
 # 330 ".\cpp\main.cpp" 1
	mov $0x1f2,%dx
out %al,%dx

 # 0 "" 2
/NO_APP
	movzbl	-8(%ebp), %eax
	sall	$8, %eax
	movl	%eax, %ecx
	movl	8(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, %edi
/APP
 # 355 ".\cpp\main.cpp" 1
	mov $0x1f3,%dx
out %al,%dx
mov $0x1f4,%dx
shr $8,%eax
out %al,%dx
mov $0x1f5,%dx
shr $8,%eax
out %al,%dx
mov $0x1f6,%dx
and $0xf,%al
or $0xe0,%al
out %al,%dx
mov $0x1f7,%dx
mov $0x20,%al
out %al,%dx
1:nop
in %dx,%al
and $0x88,%al
cmp $0x8,%al
jnz 1b
mov $0x1f0,%dx
rep insw

 # 0 "" 2
/NO_APP
	addl	$4, %esp
	popl	%edi
	popl	%ebp
	ret
	.globl	__Z9WriteDiskjhPKv
	.def	__Z9WriteDiskjhPKv;	.scl	2;	.type	32;	.endef
__Z9WriteDiskjhPKv:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	subl	$4, %esp
	movl	12(%ebp), %eax
	movb	%al, -8(%ebp)
	movzbl	-8(%ebp), %eax
/APP
 # 362 ".\cpp\main.cpp" 1
	mov $0x1f2,%dx
out %al,%dx

 # 0 "" 2
/NO_APP
	movzbl	-8(%ebp), %eax
	sall	$8, %eax
	movl	%eax, %ecx
	movl	8(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, %esi
/APP
 # 387 ".\cpp\main.cpp" 1
	mov $0x1f3,%dx
out %al,%dx
mov $0x1f4,%dx
shr $8,%eax
out %al,%dx
mov $0x1f5,%dx
shr $8,%eax
out %al,%dx
mov $0x1f6,%dx
and $0xf,%al
or $0xe0,%al
out %al,%dx
mov $0x1f7,%dx
mov $0x30,%al
out %al,%dx
1:nop
in %dx,%al
and $0x88,%al
cmp $0x8,%al
jnz 1b
mov $0x1f0,%dx
rep outsw

 # 0 "" 2
/NO_APP
	addl	$4, %esp
	popl	%esi
	popl	%ebp
	ret
	.globl	__Z12GetCursorPosv
	.def	__Z12GetCursorPosv;	.scl	2;	.type	32;	.endef
__Z12GetCursorPosv:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
/APP
 # 405 ".\cpp\main.cpp" 1
	mov $0x3d4,%dx
mov $0xf,%al
out %al,%dx
mov $0x3d5,%dx
in %dx,%al
mov %al,%bl
mov $0x3d4,%dx
mov $0xe,%al
out %al,%dx
mov $0x3d5,%dx
in %dx,%al
mov %al,%bh

 # 0 "" 2
/NO_APP
	movl	%ebx, %eax
	movw	%ax, -6(%ebp)
	movzwl	-6(%ebp), %eax
	addl	$16, %esp
	popl	%ebx
	popl	%ebp
	ret
	.globl	__Z12SetCursorPost
	.def	__Z12SetCursorPost;	.scl	2;	.type	32;	.endef
__Z12SetCursorPost:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %eax
	movw	%ax, -8(%ebp)
	movzwl	-8(%ebp), %eax
	movl	%eax, %ebx
/APP
 # 423 ".\cpp\main.cpp" 1
	mov $0x3d4,%dx
mov $0xf,%al
out %al,%dx
mov $0x3d5,%dx
mov %bl,%al
out %al,%dx
mov $0x3d4,%dx
mov $0xe,%al
out %al,%dx
mov $0x3d5,%dx
mov %bh,%al
out %al,%dx

 # 0 "" 2
/NO_APP
	addl	$4, %esp
	popl	%ebx
	popl	%ebp
	ret
	.globl	__Z6strcmpPKcS0_
	.def	__Z6strcmpPKcS0_;	.scl	2;	.type	32;	.endef
__Z6strcmpPKcS0_:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	L68
L74:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jne	L69
	jmp	L79
L69:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	L71
	movl	$1, %eax
	jmp	L73
L71:
	movl	$-1, %eax
	jmp	L73
L79:
	addl	$1, -4(%ebp)
L68:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	L74
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	L75
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	L76
	movl	$1, %eax
	jmp	L73
L76:
	movl	$-1, %eax
	jmp	L73
L75:
	movl	$0, %eax
L73:
	leave
	ret
	.globl	__Z7strncmpPKcS0_i
	.def	__Z7strncmpPKcS0_i;	.scl	2;	.type	32;	.endef
__Z7strncmpPKcS0_i:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	L81
L88:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jne	L82
	jmp	L94
L82:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	L84
	movl	$1, %eax
	jmp	L86
L84:
	movl	$-1, %eax
	jmp	L86
L94:
	addl	$1, -4(%ebp)
L81:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	L87
	movl	-4(%ebp), %eax
	cmpl	16(%ebp), %eax
	jl	L88
L87:
	movl	-4(%ebp), %eax
	cmpl	16(%ebp), %eax
	jl	L89
	movl	$0, %eax
	jmp	L86
L89:
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	L90
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	L91
	movl	$1, %eax
	jmp	L86
L91:
	movl	$-1, %eax
	jmp	L86
L90:
	movl	$0, %eax
L86:
	leave
	ret
	.globl	__Z6strcpyPcPKc
	.def	__Z6strcpyPcPKc;	.scl	2;	.type	32;	.endef
__Z6strcpyPcPKc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	L96
L97:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	addl	$1, -4(%ebp)
L96:
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	L97
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	leave
	ret
	.globl	__Z6memcpyPvPKvi
	.def	__Z6memcpyPvPKvi;	.scl	2;	.type	32;	.endef
__Z6memcpyPvPKvi:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	L99
L100:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	addl	$1, -4(%ebp)
L99:
	movl	-4(%ebp), %eax
	cmpl	16(%ebp), %eax
	jl	L100
	leave
	ret
	.section .rdata,"dr"
	.align 64
__ZL8KeyTable:
	.byte	0
	.byte	0
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	48
	.byte	45
	.byte	61
	.byte	0
	.byte	8
	.byte	113
	.byte	119
	.byte	101
	.byte	114
	.byte	116
	.byte	121
	.byte	117
	.byte	105
	.byte	111
	.byte	112
	.byte	91
	.byte	93
	.byte	10
	.byte	0
	.byte	97
	.byte	115
	.byte	100
	.byte	102
	.byte	103
	.byte	104
	.byte	106
	.byte	107
	.byte	108
	.byte	59
	.byte	39
	.byte	0
	.byte	0
	.byte	92
	.byte	122
	.byte	120
	.byte	99
	.byte	118
	.byte	98
	.byte	110
	.byte	109
	.byte	44
	.byte	46
	.byte	47
	.byte	0
	.byte	42
	.byte	0
	.byte	32
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	55
	.byte	56
	.byte	57
	.byte	45
	.byte	52
	.byte	53
	.byte	54
	.byte	43
	.byte	49
	.byte	50
	.byte	51
	.byte	48
	.byte	46
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.space 160
__ZL8HexTable:
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
.lcomm __ZZ6__mainvE1i,4,4
.lcomm __ZZ6__mainvE4node,256,64
.lcomm __ZZ6__mainvE3top,4,4
.lcomm __ZZ6__mainvE4addr,1024,64
.lcomm __ZZ6__mainvE4name,65536,64
.lcomm __ZZ6__mainvE4argc,4,4
.lcomm __ZZ6__mainvE4argv,65536,64
.lcomm __ZZ6__mainvE5index,4,4
.lcomm __ZZ6__mainvE6buffer,256,64
.lcomm __ZZ8tickProcvE3pos,2,2
.lcomm __ZZ8tickProcvE3num,1,1
	.ident	"GCC: (tdm64-1) 4.9.2"
