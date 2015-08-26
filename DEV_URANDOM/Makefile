all: devurandom

devurandom: dev_urandom.o
	gcc -g -o3 dev_urandom.o -o dev_urandom -lpthread

rm_devurandom:
	rm dev_urandom dev_urandom.o

clean: rm_devurandom
