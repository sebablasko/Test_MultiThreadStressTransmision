#!/bin/bash
#Se requiere la variable res_dir
res_dir=../RESULTS
#Recuperar parametros
packages=$1
shift 1
repetitions=$1
shift 1
threads=$@

echo "Compilando..."
make all
echo "Done"

echo "Ejecutando Prueba UNIX..."
for num_threads in $threads
do
	echo ""
	echo "Evaluando "$num_threads" Threads"
	linea="$num_threads,";
	for ((i=1 ; $i<=$repetitions ; i++))
	{
		echo "		Repeticion numero "$i

		if [ "$(whoami)" == "root" ]; then
			mkdir perf
			perf record -- ./server $packages $num_threads > aux &
		else
			./server $packages $num_threads > aux &
		fi

		pid=$!
		sleep 1
		./client $(($packages*10)) > /dev/null &
		./client $(($packages*10)) > /dev/null &
		./client $(($packages*10)) > /dev/null &
		./client $(($packages*10)) > /dev/null &
		pid2=$!
		sleep 1
		wait $pid
		wait $pid2
		linea="$linea$(cat aux)"
		rm aux

		if [ "$(whoami)" == "root" ]; then
				perf_file="perf/{"$num_threads"}perf_"$i".data"
				output_perf_file="perf/{"$num_threads"}perf_"$i".txt"
				perf report > $output_perf_file
				mv perf.data $perf_file
		fi		
	}
	output_csv_file=$res_dir"/UNIX_times.csv"
	echo "$linea" >> $output_csv_file
done
make clean
if [ "$(whoami)" == "root" ]; then
	python ../perfPostProcessing.py
	output_perf_summary=$res_dir"/perfSummary_unix.csv"
	mv perfTests.csv $output_perf_summary
fi
echo "Done"