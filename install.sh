#!/usr/bin/env bash

if [[ "$(id -u)" -ne 0 ]];then
    printf "\e[1;77mPlease, run this program as root!\n\e[0m"
    exit 1
fi

#===========================================================
printf "\e[1;97m[+] Update\n\e[0m"

apt update && apt upgrade -y && apt dist-upgrade -y

#===========================================================
printf "\e[1;97m[+] Install nasm\n\e[0m"
apt install nasm -y

printf "\e[1;97m[+] Install gcc\n\e[0m"
apt install gcc -y

printf "\e[1;97m[+] Install fpc\n\e[0m"
apt install fpc -y

printf "\e[1;97m[+] Install figlet\n\e[0m"
apt install figlet -y

printf "\e[1;97m[+] Install objdump\n\e[0m"
apt install binutils -y

printf "\e[1;97m[+] Install gcc-mingw-w64-x86-64\n\e[0m"
apt install gcc-mingw-w64-x86-64

printf "\e[1;97m[+] Install gcc-mingw-w64-i686\n\e[0m"
apt install gcc-mingw-w64-i686
#===========================================================
exit 0
