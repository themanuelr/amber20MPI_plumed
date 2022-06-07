#!/bin/bash
#PBS -l select=1:ncpus=8:mpiprocs=2:ngpus=2
#PBS -l walltime=00:10:00
#PBS -j oe
#PBS -N a1-01
#PBS -q debug
#

cd $PBS_O_WORKDIR
module load amber/20/ompi4-cuda10.2-plm2.6
source /work/vrizzi/programs/plumed2-2.8/sourceme.sh 
unset CUDA_VISIBLE_DEVICES
export PLUMED_NUM_THREADS=8

TYPE='OPES'
TOP_A='ala2.top'
NAME_A='ala2.'$TYPE

PREV='00'
CURR='01'

MDIN='md.OPES1.in'
RNAME_A='ala2'

cp master_groupfile ${CURR}-groupfile
sed -i "s/TOP_A/${TOP_A}/g" ${CURR}-groupfile
sed -i "s/MDIN/${MDIN}/g" ${CURR}-groupfile
sed -i "s/RNAME_A/${RNAME_A}/g" ${CURR}-groupfile
sed -i "s/NAME_A/${NAME_A}/g" ${CURR}-groupfile
sed -i "s/PREV/${PREV}/g" ${CURR}-groupfile
sed -i "s/CURR/${CURR}/g" ${CURR}-groupfile

mpirun -mca orte_base_help_aggregate 0 -n 2 pmemd.cuda_SPFP.MPI -ng 2 -groupfile ${CURR}-groupfile

#mv bck.last.compressed_Kernels.data ${CURR}-bck.last.compressed_Kernels.data
cp compressed_Kernels.data ${CURR}-compressed_Kernels.data 

#for i in `seq -w 228 229`; do
#        printf -v PREV "%02g" $(( 10#$i-1 ))
#        printf -v CURR "%02g" $(( 10#$i ))
#        mpirun -n 2 pmemd.cuda_SPFP.MPI -O -p ${TOP} -i md.in -c ${PREV}*.rst -r ${CURR}-${NAME}.rst -x ${CURR}-${NAME}.crd -o ${CURR}-${NAME}.out -ref ${PREV}*.rst -inf ${CURR}-${NAME}.mdinfo
#done

