#!/bin/bash
START=$(date +%s)
echo $START

res_dir=RESULTS
mkdir $res_dir

MAX_PACKS=1000000
repetitions=60
total_num_threads="1 2 4 8 16 24 32 48 64 128"

echo ""
echo "Iniciando pruebas..."

# ./run.sh {TOTAL_PAQUETES} {TOTAL_REPETICIONES} {[LISTA CANTIDAD THREADS]}

# echo ""
# echo "Prueba DEV_NULL"
# cd DEV_NULL
# ./run.sh $MAX_PACKS $repetitions $total_num_threads
# echo "Done!"
# cd ..

# echo ""
# echo "Prueba DEV_URANDOM"
# cd DEV_URANDOM
# ./run.sh $MAX_PACKS $repetitions $total_num_threads
# echo "Done!"
# cd ..

echo ""
echo "Prueba UDP"
cd UDP
./run.sh $MAX_PACKS $repetitions $total_num_threads
echo "Done!"
cd ..

# echo ""
# echo "Prueba UNIX"
# cd UNIX
# ./run.sh $MAX_PACKS $repetitions $total_num_threads
# echo "Done!"
# cd ..

# echo ""
# echo "Prueba TCP"
# cd TCP
# ./run.sh $MAX_PACKS $repetitions $total_num_threads
# echo "Done!"
# cd ..

# echo ""
# echo "Prueba FIFO"
# cd FIFO
# ./run.sh $MAX_PACKS $repetitions $total_num_threads
# echo "Done!"
# cd ..


END=$(date +%s)
DIFF=$(( $END - $START ))

echo "El total de pruebas duro: $DIFF segundos"




echo "Uniendo datos..."
cd RESULTS
echo "" > Resultados_Stress.csv
for filename in *_times.csv; do
	echo $filename >> Resultados_Stress.csv
	cat $filename >> Resultados_Stress.csv
	echo "" >> Resultados_Stress.csv
done
echo "Done!"
cd ..
