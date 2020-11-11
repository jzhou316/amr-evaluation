#!/bin/bash

set -e
set -o pipefail

if [[ -z $1 ]]; then
    parsed_data="../transition-amr-parser/EXP/exp_graphmp-swaparc-ptrlast_o5_roberta-large-top24_act-pos-grh_vmask1_shiftpos1_ptr-lay6-h1_grh-lay123-h2-allprev_1in1out_cam-layall-h2-abuf_tis-embtop-comadd-bp1/models_e
p120_seed42/beam10/test_checkpoint_wiki-smatch_top5-avg.wiki.amr"
else
    parsed_data=$1
fi

set -o nounset

gold_data="../transition-amr-parser/amr_corpus/amr2.0/wiki/test.txt"
ndigits=3
restarts=4

bash evaluation.sh $parsed_data $gold_data $ndigits $restarts 2>&1 | tee results.txt

saveback="${parsed_data%.*}"".finegrained"
cp results.txt $saveback
