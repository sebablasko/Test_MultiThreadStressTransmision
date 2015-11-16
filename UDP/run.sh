#!/bin/bash
#Se requiere la variable res_dir
res_dir=../RESULTS

#Recuperar parametros
packages=$1
shift 1
repetitions=$1
shift 1
threads=$@

total_clients=4
num_port=1920

echo "Compilando..."
make all
echo "Done"

echo "Ejecutando Prueba UDP..."
for num_threads in $threads
do
	echo ""
	echo "Evaluando "$num_threads" Threads"
	linea="$num_threads,";
	for ((i=1 ; $i<=$repetitions ; i++))
	{
		echo "		Repeticion "$i

		if [ "$(whoami)" == "root" ]; then
			mkdir perf
			perf record -- ./serverTesis --packets $packages --threads $num_threads --port $num_port > aux &
		else
			./serverTesis --packets $packages --threads $num_threads --port $num_port > aux &
		fi

		pid=$!
		sleep 1

		for ((j=1 ; $j<=$total_clients ; j++))
		{
			./clientTesis --packets $(($packages*10)) --ip 127.0.0.1 --port $num_port > /dev/null &
		}

		sleep 1
		wait $pid
		linea="$linea$(cat aux)"
		rm aux

		if [ "$(whoami)" == "root" ]; then
				perf_file="perf/{"$num_threads"}perf_"$i".data"
				output_perf_file="perf/{"$num_threads"}perf_"$i".txt"
				perf report > $output_perf_file
				mv perf.data $perf_file
		fi
	}
	output_csv_file=$res_dir"/UDP_times.csv"
	echo "$linea" >> $output_csv_file
done
make clean
if [ "$(whoami)" == "root" ]; then
	python ../perfPostProcessing.py
	output_perf_summary=$res_dir"/perfSummary_udp.csv"
	mv perfTests.csv $output_perf_summary
fi
echo "Done"
