module load amber/20/ompi4-cuda10.2-plm2.6
source /work/xxxx/programs/plumed2-2.8/sourceme.sh 
unset CUDA_VISIBLE_DEVICES

mpirun -mca orte_base_help_aggregate 0 -n 2 pmemd.cuda_SPFP.MPI -ng 2 -groupfile 01-groupfile

