module load amber/20/ompi4-cuda10.2-plm2.6
source /work/xxxx/programs/plumed2-2.8/sourceme.sh 
export CUDA_VISIBLE_DEVICES=0

TOP='ala2.top'
TYPE='OPES'
NAME='ala2.'$TYPE

PREV='00'
CURR='01'

pmemd.cuda_SPFP -O -p ${TOP} -i md.OPES1.in -c ${PREV}*.rst -r ${CURR}-${NAME}.rst -x ${CURR}-${NAME}.crd -o ${CURR}-${NAME}.out -ref ${PREV}*.rst -inf ${CURR}-${NAME}.mdinfo -AllowSmallBox

