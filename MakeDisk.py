import sys

if len(sys.argv) < 2:
    exit(1)

tar = open(sys.argv[1], "wb")
tar.write(b"\0" * 0x100000)

if tar.seekable() == False:
    exit(1)

index = 2

while len(sys.argv) >= index + 2:
    start = int(sys.argv[index]) * 0x200
    with open(sys.argv[index + 1], "rb") as f:
        buf = f.read()
        tar.seek(start)
        tar.write(buf)
    index += 2
