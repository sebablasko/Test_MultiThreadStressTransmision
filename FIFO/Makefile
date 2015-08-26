all: server client

server: server.o
	gcc -o3 server.o -o server -lpthread

rm_server:
	rm server server.o

client: client.o
	gcc -o3 client.o -o client -lpthread

rm_client:
	rm client client.o

clean: rm_client rm_server
