FROM ubuntu:latest

WORKDIR /home

RUN apt-get update && apt-get install -y gcc gcc-multilib g++
RUN apt-get install -y nano gdb    

COPY test_asm.s .
COPY p_asm.s .
COPY p_c.c .
COPY p_cpp.cpp .

RUN gcc -m32 -fno-pie -static test_asm.s -o test -g
RUN gcc -static p_c.c -o p_c -g
RUN g++ -static p_cpp.cpp -o p_cpp -g
RUN gcc -m32 -fno-pie -static p_asm.s -o p_asm -g
