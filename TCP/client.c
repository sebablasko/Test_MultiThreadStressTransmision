#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include "../../ssocket/ssocket.h"

//Definiciones
#define BUF_SIZE 512
#define FIRST_PORT "1820"

//Variables
struct timeval dateInicio, dateFin;
char buf[BUF_SIZE];
char* IP_DEST;
int mostrarInfo = 0;
int MAX_PACKS = 1;
double segundos;

main(int argc, char **argv) {
	if(argc < 3){
		fprintf(stderr, "Syntax Error: Esperado: ./client MAX_PACKS IP_DEST\n");
		exit(1);
	}

	//Recuperar total de paquetes a enviar
	MAX_PACKS = atoi(argv[1]);

	//Recuperar IP destino
	IP_DEST = argv[2];

	/* Llenar de datos el buffer a enviar */
	int i;
	for(i = 0; i < BUF_SIZE; i++)
		buf[i] = 'a'+i;

	/* Abrir socket */
	int socket_fd;
	socket_fd = tcp_connect(IP_DEST, FIRST_PORT);
	if(socket_fd < 0){
		fprintf(stderr, "Error al hacer connect del socket TCP");
		exit(1);
	}

	//Medir Fin
	gettimeofday(&dateInicio, NULL);

	for(i = 0; i < MAX_PACKS; i++){
		if(write(socket_fd, buf, BUF_SIZE) != BUF_SIZE) {
			break;
		}
	}

	gettimeofday(&dateFin, NULL);

	close(socket_fd);

	segundos=(dateFin.tv_sec*1.0+dateFin.tv_usec/1000000.)-(dateInicio.tv_sec*1.0+dateInicio.tv_usec/1000000.);
	if(mostrarInfo){
		printf("Tiempo Total = %g\n", segundos);
		printf("QPS = %g\n", MAX_PACKS*1.0/segundos);
	}else{
		printf("%g \n", segundos);
	}
	exit(0);
}
