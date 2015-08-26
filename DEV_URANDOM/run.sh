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

echo "Ejecutando Prueba DEV_URANDOM..."
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
			perf record -- ./dev_urandom --packets $packages --threads $num_threads > aux &
		else
			./dev_urandom --packets $packages --threads $num_threads > aux &
		fi

		pid=$!
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
	output_csv_file=$res_dir"/DEV_URANDOM_times.csv"
	echo "$linea" >> $output_csv_file
done
make clean
if [ "$(whoami)" == "root" ]; then
	python ../perfPostProcessing.py
	output_perf_summary=$res_dir"/perfSummary_devurandom.csv"
	mv perfTests.csv $output_perf_summary
fi
echo "Done"
