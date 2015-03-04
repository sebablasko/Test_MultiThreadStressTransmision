# Test_StressTransmision
Evaluación de estrés de distintas estructuras en la transmisión de una determinanda cantidad de paquetes de 10 byes cada uno.

Se evalúa el acceso concurrente a:

- Dispositivos Virtuales
	- DEV_NULL
	- DEV_URANDOM
- FIFO
- UNIX Sockets
	- UDP
- Internet Sockets
	- TCP
	- UDP

Para poder construir un call-graph a partir de los registros perf, se debe modificar las rutinas "run" de cada carpeta de estructura evaluada para agregar el parametro "-g" en el record de perf

