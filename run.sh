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
./run.sh 1000 3 1 2 4
echo "Done!"
cd ..

echo ""
echo "Prueba UNIX"
cd UNIX
./run.sh 1000 3 1 2 4
echo "Done!"
cd ..

echo ""
echo "Prueba FIFO"
cd FIFO
./run.sh 1000 3 1 2 4
echo "Done!"
cd ..

echo ""
echo "Prueba DEV_NULL"
cd DEV_NULL
./run.sh 1000 3 1 2 4
echo "Done!"
cd ..

echo ""
echo "Prueba DEV_URANDOM"
cd DEV_URANDOM
./run.sh 1000 3 1 2 4
echo "Done!"
cd ..

echo ""
echo "Prueba TCP"
cd TCP
./run.sh 1000 3 1 2 4
#echo "postprocessing..."
#python ../post_processing_perf.py
#mv perfTests.csv ../RESULTS/perfTestsTCP.csv
echo "Done!"
cd ..

END=$(date +%s)
DIFF=$(( $END - $START ))

echo "El total de pruebas duro: $DIFF segundos"