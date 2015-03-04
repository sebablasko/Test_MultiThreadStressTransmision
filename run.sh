#!/bin/bash
START=$(date +%s)
res_dir=RESULTS

mkdir $res_dir

echo ""
echo "Iniciando pruebas..."

# ./run.sh {TOTAL_PAQUETES} {TOTAL_REPETICIONES} {[LISTA CANTIDAD THREADS]}

echo ""
echo "Prueba UDP"
cd UDP
./run.sh 1000000 1 4
echo "Done!"
cd ..

echo ""
echo "Prueba UNIX"
cd UNIX
./run.sh 1000000 1 4
echo "Done!"
cd ..

echo ""
echo "Prueba FIFO"
cd FIFO
./run.sh 1000000 1 4
echo "Done!"
cd ..

echo ""
echo "Prueba DEV_NULL"
cd DEV_NULL
./run.sh 1000000 1 4
echo "Done!"
cd ..

echo ""
echo "Prueba DEV_URANDOM"
cd DEV_URANDOM
./run.sh 1000000 1 4
echo "Done!"
cd ..

echo ""
echo "Prueba TCP"
cd TCP
./run.sh 1000000 1 4
echo "Done!"
cd ..

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