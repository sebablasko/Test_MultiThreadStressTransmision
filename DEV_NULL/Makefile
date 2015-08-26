all: devnull

devnull: dev_null.o
	gcc -g -o3 dev_null.o -o dev_null -lpthread

rm_devnull:
	rm dev_null dev_null.o

clean: rm_devnull
