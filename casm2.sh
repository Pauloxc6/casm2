#!/usr/bin/env bash

date1=$(date)

#Banner
figlet Compiler
printf "\e[1;97mBY: pauloxc6\n"
printf "\e[1;97mGithub: pauloxc6   |                     ($date1)\n"
printf "\n"

#Error handling
[[ $# -le 0 ]] && printf "\e[1;96mHelp: $0 \e[1;97m<script.asm> \e[1;96m-h\n" && exit 1

#var
arch="x86"
sys="linux"
com="nasm"
gen="asm"
p1=$1

#Removes the widely [.asm,.c,.cpp,.pas] from the script and stores the name in the variable name
name=$(echo $p1 | sed 's/\.asm//' || sed 's/\.c//' || sed 's/\.pas//')
name_ext=$(echo $p1 | cut -d "." -f2)
varch=$(uname -m)

if [[ $name_ext = "asm" ]]; then
	com="nasm"
elif [[ $name_ext = "c" ]]; then
	com="gcc"
elif [[ $name_ext = "pas" ]]; then
	com="fpc"
fi

if [[ $varch = "x86" ]]; then
	arch="x86"
elif [[ $varch = "x86_64" ]]; then
	arch="x86_64"
fi

#Menu Help
while [[ $# -gt 0 ]]
do
	case $1 in

		-h|--help)
			printf "\e[1;93mHelp Menu:\n"
	    	printf "\e[1;96mHelp: $0 \e[1;97m<script.asm> \e[1;93m--arch \e[1;92m[architecture] \e[1;93m--sys \e[1;92m[system] \e[1;93m--com \e[1;92m[compiler] \e[1;93m-d \e[1;92m[disassembler] \e[1;93m[-h|--help]\n"
	    	printf "\e[1;96m[--help]Shows the help of the program\n"
	    	printf "\e[1;96m[-v|-version] Version\n"
	    	printf "\e[1;96m[--arch] Computer architecture \e[1;94m[x86_64] or \e[1;94m[x86]\n"
	    	printf "\e[1;96m[--sys] Operating system \e[1;94m[linux] or \e[1;94m[windowns]\n"
			printf "\e[1;96m[--com] Compiler to be used| \e[1;94m[nasm], \e[1;94m[gcc], \e[1;94m[fpc]\n"
	    	printf "\e[1;96m[-d] Disassembled Coding (Compiled Only)\n"
			printf "\e[1;96m[-g] Generate Coding \e[1;94m[asm], \e[1;94m[c], \e[1;94m[pas]\e[0m\n"
	   		exit 0;;

	 	-v|--version)
	 		printf "\e[1;97mVersion: 2.2\n"
	 		exit 0 ;;
	 	--arch)
	 		arch="$2"
	 		shift ;;

	 	--sys)
	 		sys="$2"
	 		shift ;;

		--com)	com="$2"
			shift ;;

		-g) gen="$2"

			#[[ $# -ge 1 ]] && continue
			#gen coding
			if [[ $gen == "asm" ]];then
				printf "[+]---------------------------------------[+]\n"
				echo -e "section .text\n\tglobal _start\n\n_start:\n\n\tnop\n\t;exit\n\n\tmov eax,1\n\tmov ebx,0\n\tint 0x80"
				printf "[+]---------------------------------------[+]\n"

			elif [[ $gen == "c" ]];then
				printf "[+]---------------------------------------[+]\n"
				echo -e "#include <stdio.h>\n\nint main(int argc, char *argv[]){\n\n\treturn 0;\n\n}"
				printf "[+]---------------------------------------[+]\n"

			elif [[ $gen == "pas" ]];then
				printf "[+]---------------------------------------[+]\n"
				echo -e "program ;\n\nvar\n\t\n\nbegin\n\n\t\n\nend."
				printf "[+]---------------------------------------[+]\n"

			fi
			exit 0 ;;

	 	-d)

	 		if [[ $sys == "linux" ]];then
	 			clear
    				printf "\e[1;94mDisassembler .....\n\e[0m"
        			echo ""
    				objdump -dM intel $name

	 		elif [[ $sys == "windows" ]];then
	 			clear
    				printf "\e[1;94mDisassembler .....\n\e[0m"
        			echo ""
    				objdump -dM intel -M addr16,data16 $name

			fi
	 		exit 0 ;;

	esac
	shift
done

#Compiler
#nasm
if [[ $com == "nasm"  ]];then

	if [[ $arch == "x86_64" ]];then

		if [[ $sys == "linux" ]];then
			nasm -f elf64 -o $name.o $p1
		elif [[ $sys == "windows" ]];then
			nasm -f win64 -o $name.o $p1
		fi
	fi

	if [[ $arch == "x86" ]];then

		if [[ $sys == "linux" ]];then
			nasm -f elf32 -o $name.o $p1

		elif [[ $sys == "windows" ]];then
			nasm -f win32 -o $name.o $p1
		fi
	fi

	#Linux
	if [[ $sys == "linux" ]];then
		if [[ $arch == "x86_64" ]];then

			ld -o $name $name.o
			printf "\e[1;94m[+] Compilando \e[1;97m[$name.asm] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.o\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		elif [[ $arch == "x86" ]]; then

			ld -m elf_i386 -o $name $name.o
			printf "\e[1;94m[+] Compilando \e[1;97m[$name.asm] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.o\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		fi
	fi

	#Windows
	if [[ $sys == "windows" ]];then
		if [[ $arch == "x86_64" ]];then
			ld -o $name $name.obj
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.asm] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.obj\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		elif [[ $arch == "x86" ]];then

			ld -m elf_i386 -o $name $name.obj
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.asm] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.obj\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"
		fi

	fi

fi

#gcc
if [[ $com == "gcc"  ]];then

	if [[ $arch == "x86_64" ]];then

		if [[ $sys == "linux" ]];then
			gcc -o $name $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.c\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		elif [[ $sys == "windows" ]];then
			
			x86_64-w64-mingw32-gcc -o $name.exe $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.c\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		fi
	fi

	if [[ $arch == "x86" ]];then

		if [[ $sys == "linux" ]];then
			gcc -m32 -o $name $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.c\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		elif [[ $sys == "windows" ]];then
			
			i686-w64-mingw32-gcc -m32 -o $name.exe $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.c\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"
		fi
	fi

fi

#fpc
if [[ $com == "fpc" ]];then

	if [[ $arch == "x86_64" ]];then

		if [[ $sys == "linux" ]];then
			fpc -Px86_64 $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.o\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		elif [[ $sys == "windows" ]];then

			fpc -Px86_64 -Twin64 $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mFThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.o\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		fi
	fi

	if [[ $arch == "x86" ]];then

		if [[ $sys == "linux" ]];then
			fpc -Pi386 $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.o\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"

		elif [[ $sys == "windows" ]];then

			fpc -Pi386 $p1
			printf "\e[1;94mF[+] Compilando \e[1;97m[$name.c] \e[1;96m[$sys - $arch - $com] .....\n"
			printf "\n"
			printf "\e[1;93mThe files were created: \n"
			printf "\e[1;94m[-] --> \e[1;97m$name.o\n"
			printf "\e[1;94m[-] --> \e[1;97m$name\n\e[0m"
		fi
	fi

fi

exit 0
