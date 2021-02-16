typedef void VOID;
typedef char CHAR;
typedef unsigned char BYTE;
typedef unsigned short WORD;
typedef unsigned int DWORD;

typedef unsigned int DWORD_PTR;

typedef VOID* LPVOID;
typedef BYTE* LPBYTE;
typedef WORD* LPWORD;
typedef DWORD* LPDWORD;

typedef char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int64_t;

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

#define DESC_G_4K 0x00800000
#define DESC_D_32 0x00400000
#define DESC_L 0x00200000
#define DESC_AVL 0x00100000
#define DESC_P 0x00008000
#define DESC_DPL_0 0x00000000
#define DESC_DPL_1 0x00002000
#define DESC_DPL_2 0x00004000
#define DESC_DPL_3 0x00006000
#define DESC_TYPE_SYSTEM 0x00000000
#define DESC_TYPE_CODE 0x00001800
#define DESC_TYPE_DATA 0x00001000
#define DESC_CODE_CONFIRMING 0x00000400
#define DESC_CODE_READABLE 0x00000200
#define DESC_CODE_ACCESSED 0x00000100
#define DESC_DATA_EXTEND_DIR 0x00000400
#define DESC_DATA_WRITABLE 0x00000200
#define DESC_DATA_ACCESSED 0x00000100

#define INTR_TYPE_INT16 0x0600
#define INTR_TYPE_TRAP16 0x0700
#define INTR_TYPE_INT32 0x0E00
#define INTR_TYPE_TRAP32 0x0F00
#define INTR_TYPE_TASK32 0x0500

#define SEG_RPL0 0x0000
#define SEG_RPL1 0x0001
#define SEG_RPL2 0x0002
#define SEG_RPL3 0x0003

#define SEG_TI_GDT 0x0000
#define SEG_TI_LDT 0x0004

#define NULL (0)

typedef BYTE MUTEX;

typedef char* va_list;
#define va_start(ap,v) (ap=(char*)&v)
#define va_end(ap) (ap=NULL)
#define va_arg(ap,t) *((t*)(ap+=4))

struct __table{
    WORD Limit;
    DWORD_PTR Base;
}__attribute__((packed)) _GDT,_IDT;

void putchar(char ch);
void lock(MUTEX* mutex);
void unlock(MUTEX* mutex);
void ReadDisk(DWORD LBAAddr, BYTE Number, void* lpBuf);
void WriteDisk(DWORD LBAAddr, BYTE Number, const void* lpBuf);
WORD GetCursorPos();
void SetCursorPos(WORD pos);
int strcmp(const char* str1, const char* str2);
int strncmp(const char* str1, const char* str2, int len);
void rollScreen();
void changeLine();
void puts(const char* str);
void tickProc();
void strcpy(char* dest, const char* src);
void memcpy(void* dest, const void* src, int len);
BYTE inb(WORD port);
WORD inw(WORD port);
DWORD indw(WORD port);
void outb(WORD port, BYTE data);
void outw(WORD port, WORD data);
void outdw(WORD port, DWORD data);
int sprintf(char *buf, const char *format, ...);

char(*getchar)();

const char KeyTable[0x100]={
    0,0,'1','2','3','4','5','6','7','8','9','0','-','=',0,'\b',
    'q','w','e','r','t','y','u','i','o','p','[',']','\n',0,'a','s',
    'd','f','g','h','j','k','l',';','\'',0,0,'\\','z','x','c','v',
    'b','n','m',',','.','/',0,'*',0,' ',0,0,0,0,0,0,
    0,0,0,0,0,0,0,'7','8','9','-','4','5','6','+','1',
    '2','3','0','.',0,0,0,0,0,0,0,0,0,0,0,0
};
const char HexTable[0x10]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

#define FILE_TYPE_DEFAULT 0x00000000
#define FILE_TYPE_FOLDER 0x00000001

#define FILE_INODE_MAGIC 0x454C4946

typedef struct{
    CHAR FileName[0x20];
    DWORD Addr[0x35];
    DWORD Length;
    DWORD Type;
    DWORD Magic;
}inode;

//注:这里代码是保护模式就开始运行的
//如果你想更好地管理内存,比如分页什么的
//代码自己写,详见Intel开发手册
int __main(){
    SetCursorPos(0);
    for(DWORD_PTR i=0xB8000;i<0xB9040;i+=4)
        *(DWORD*)i=0x17001700;
    puts("Hello World!\n");
    outb(0x43, 0x36);//00(counter 0 port 0x40)11x(square wave)11(8l8h)0(bin)
    outw(0x40, 11932);//1.1932MHz
    *(DWORD_PTR*)0x50C=(DWORD_PTR)tickProc;
    asm("sgdt (%%eax)"::"a"(&_GDT));
    asm("sidt (%%eax)"::"a"(&_IDT));
    getchar=((char(*)())(*(DWORD_PTR*)0x500));
    while(1)
        putchar(KeyTable[(BYTE)getchar()]);
}

void tickProc(){
    static BYTE num;
    static WORD pos;
    pos=GetCursorPos();
    SetCursorPos(60);
    for(DWORD i=0;i<3;i++){
        outb(0x70, 4-i*2);
        num=inb(0x71);
        putchar(HexTable[num>>4]);
        putchar(HexTable[num&0xf]);
        if(i<2)
           putchar(':'); 
    }
    SetCursorPos(pos);
}

void changeLine(){
    WORD pos=(DWORD)GetCursorPos()/80*80+80;
    if(pos>=2000){
        rollScreen();
        pos-=80;
    }
    SetCursorPos(pos);
}

void rollScreen(){
    asm(
        "mov $0,%esi\n"
        "mov $1000,%ecx\n"
        "1:"
        "gs mov 160(%esi),%eax\n"
        "gs mov %eax,(%esi)\n"
        "add $4,%esi\n"
        "loop 1b\n"
    );
}

void putchar(char ch){
    if(ch=='\000')
        return;
    if(ch=='\n'){
        changeLine();
        return;
    }
    DWORD index=GetCursorPos();
    asm("gs movb %%al,(,%%ebx,2)"::"a"(ch),"b"(index));
    index++;
    SetCursorPos((WORD)index);
}

void puts(const char* str){
    uint32_t i;
    uint16_t pos=GetCursorPos();
    for(i=0;str[i];i++){
        if(str[i]=='\n'){
            changeLine();
            pos=GetCursorPos();
            continue;
        }
        asm("gs movb %%al,(,%%ebx,2)"::"a"(str[i]),"b"((uint32_t)pos));
        pos++;
    }
    SetCursorPos(pos);
}

void lock(MUTEX* mutex){
    asm(
        "mov $1,%%al\n"
        "1:"
        "lock xchg (%%ebx),%%al\n"
        "test %%al,%%al\n"
        "jnz 1b\n"
    ::"b"(mutex));
}

void unlock(MUTEX* mutex){
    *mutex=0;
}

void ReadDisk(DWORD LBAAddr, BYTE Number, void* lpBuf){
    asm(
        "mov $0x1f2,%%dx\n"
        "out %%al,%%dx\n"
    ::"a"(Number));
    asm(
        "mov $0x1f3,%%dx\n"
        "out %%al,%%dx\n"
        "mov $0x1f4,%%dx\n"
        "shr $8,%%eax\n"
        "out %%al,%%dx\n"
        "mov $0x1f5,%%dx\n"
        "shr $8,%%eax\n"
        "out %%al,%%dx\n"
        "mov $0x1f6,%%dx\n"
        "and $0xf,%%al\n"
        "or $0xe0,%%al\n"
        "out %%al,%%dx\n"
        "mov $0x1f7,%%dx\n"
        "mov $0x20,%%al\n"
        "out %%al,%%dx\n"
        "1:"
        "nop\n"
        "in %%dx,%%al\n"
        "and $0x88,%%al\n"
        "cmp $0x8,%%al\n"
        "jnz 1b\n"
        "mov $0x1f0,%%dx\n"
        "rep insw\n"
    ::"a"(LBAAddr),"c"(0x100*(WORD)Number),"D"(lpBuf));
}

void WriteDisk(DWORD LBAAddr, BYTE Number, const void* lpBuf){
    asm(
        "mov $0x1f2,%%dx\n"
        "out %%al,%%dx\n"
    ::"a"(Number));
    asm(
        "mov $0x1f3,%%dx\n"
        "out %%al,%%dx\n"
        "mov $0x1f4,%%dx\n"
        "shr $8,%%eax\n"
        "out %%al,%%dx\n"
        "mov $0x1f5,%%dx\n"
        "shr $8,%%eax\n"
        "out %%al,%%dx\n"
        "mov $0x1f6,%%dx\n"
        "and $0xf,%%al\n"
        "or $0xe0,%%al\n"
        "out %%al,%%dx\n"
        "mov $0x1f7,%%dx\n"
        "mov $0x30,%%al\n"
        "out %%al,%%dx\n"
        "1:"
        "nop\n"
        "in %%dx,%%al\n"
        "and $0x88,%%al\n"
        "cmp $0x8,%%al\n"
        "jnz 1b\n"
        "mov $0x1f0,%%dx\n"
        "rep outsw\n"
    ::"a"(LBAAddr),"c"(0x100*(WORD)Number),"S"(lpBuf));
}

WORD GetCursorPos(){
    WORD ret;
    asm(
        "mov $0x3d4,%%dx\n"
        "mov $0xf,%%al\n"
        "out %%al,%%dx\n"
        "mov $0x3d5,%%dx\n"
        "in %%dx,%%al\n"
        "mov %%al,%%bl\n"
        "mov $0x3d4,%%dx\n"
        "mov $0xe,%%al\n"
        "out %%al,%%dx\n"
        "mov $0x3d5,%%dx\n"
        "in %%dx,%%al\n"
        "mov %%al,%%bh\n"
    :"=b"(ret));
    return ret;
}

void SetCursorPos(WORD pos){
    asm(
        "mov $0x3d4,%%dx\n"
        "mov $0xf,%%al\n"
        "out %%al,%%dx\n"
        "mov $0x3d5,%%dx\n"
        "mov %%bl,%%al\n"
        "out %%al,%%dx\n"
        "mov $0x3d4,%%dx\n"
        "mov $0xe,%%al\n"
        "out %%al,%%dx\n"
        "mov $0x3d5,%%dx\n"
        "mov %%bh,%%al\n"
        "out %%al,%%dx\n"
    ::"b"(pos));
}

int strcmp(const char* str1, const char* str2){
    int i;
    for(i=0;str1[i];i++)
        if(str1[i]==str2[i])
            continue;
        else
            return str1[i]>str2[i]?1:-1;
    return str2[i]==0?0:(str1[i]>str2[i]?1:-1);
}

int strncmp(const char* str1, const char* str2, int len){
    int i;
    for(i=0;str1[i]&&i<len;i++)
        if(str1[i]==str2[i])
            continue;
        else
            return str1[i]>str2[i]?1:-1;
    if(i>=len)
        return 0;
    return str2[i]==0?0:(str1[i]>str2[i]?1:-1);
}

void strcpy(char* dest, const char* src){
    int i;
    for(i=0;src[i];i++)
        dest[i]=src[i];
    dest[i]='\000';
}

void memcpy(void* dest, const void* src, int len){
    int i;
    for(i=0;i<len;i++)
        ((char*)dest)[i]=((const char*)src)[i];
}

BYTE inb(WORD port){
    BYTE ret;
    asm(
        "in %%dx,%%al"
    :"=a"(ret):"d"(port));
    return ret;
}

WORD inw(WORD port){
    WORD ret;
    asm(
        "in %%dx,%%ax"
    :"=a"(ret):"d"(port));
    return ret;
}

DWORD indw(WORD port){
    DWORD ret;
    asm(
        "in %%dx,%%eax"
    :"=a"(ret):"d"(port));
    return ret;
}

void outb(WORD port, BYTE data){
    asm(
        "out %%al,%%dx"
    ::"a"(data),"d"(port));
}

void outw(WORD port, WORD data){
    asm(
        "out %%ax,%%dx"
    ::"a"(data),"d"(port));
}

void outdw(WORD port, DWORD data){
    asm(
        "out %%eax,%%dx"
    ::"a"(data),"d"(port));
}

void halt(){
    asm("hlt");
}

int strlen(const char* str){
    int i;
    for(i=0;str[i];i++);
    return i;
}

static void itoa(uint32_t value, char **buf_ptr_addr, uint8_t base) {
  uint32_t m = value % base;
  uint32_t i = value / base;
  if (i) { // recursion
    itoa(i, buf_ptr_addr, base);
  }
  if (m < 10) {
    *((*buf_ptr_addr)++) = m + '0'; //'0'~'9'
  } else {
    *((*buf_ptr_addr)++) = m - 10 + 'A'; //'A'~'F'
  }
}

uint32_t vsprintf(char *str, const char *format, va_list ap) {
  char *buf_ptr = str;
  const char *index_ptr = format;
  char index_char = *index_ptr;
  int32_t arg_int;
  char *arg_str;
  while (index_char) {
    if (index_char != '%') {
      *(buf_ptr++) = index_char;
      index_char = *(++index_ptr);
      continue;
    }
    index_char = *(++index_ptr); // get symbols of %
    switch (index_char) {
    case 's':
      arg_str = va_arg(ap, char *);
      strcpy(buf_ptr, arg_str);
      buf_ptr += strlen(arg_str);
      index_char = *(++index_ptr);
      break;

    case 'c':
      *(buf_ptr++) = va_arg(ap, char);
      index_char = *(++index_ptr);
      break;

    case 'd':
      arg_int = va_arg(ap, int);
      // negative
      if (arg_int < 0) {
        arg_int = 0 - arg_int;
        *buf_ptr++ = '-';
      }
      itoa(arg_int, &buf_ptr, 10);
      index_char = *(++index_ptr);
      break;
    case 'x':
      arg_int = va_arg(ap, int);
      itoa(arg_int, &buf_ptr, 16);
      index_char = *(++index_ptr); // skip %x
      break;
    default:
      break;
    }
  }
  return strlen(str);
}

int sprintf(char *buf, const char *format, ...) {
  va_list args;
  uint32_t retval;
  va_start(args, format);
  retval = vsprintf(buf, format, args);
  va_end(args);
  return retval;
}
