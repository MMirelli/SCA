#!/bin/bash
echo Insert each time one of the alternative using the same syntax
echo processed, figs or raw?
read fold_1
fold_1=$fold_1"/"
echo DPAv2 or DPAv4.2?
read fold_2
if [ "$fold_2" == "DPAv2" ]
then
   echo public_db or template_db?
   read fold_3
   fold_3+="/"
fi
fold_2+="/"
echo How many subfolder part* do you need?
echo Answer with an integer.
read n
declare -i i=0
while [[ "$i" -le "$n" ]]
do
       
    case "${fold_1::-1}" in
	"processed")
	    what="raw traces from /data/raw/"$fold_2$fold_3"part""$i"", once *processed*, will"
	    ;;
        "figs")
	    what="figs and videos of processed traces in data/processed/"$fold_2$fold_3"part"$i" will"
	    ;;
	"raw")
	    what="raw traces of ${fold_2::-1} ${fold_3::-1} part"$i" should"
	    ;;
    esac
    template="All ""$what"" be saved here."

    new_fold="./data/"$fold_1$fold_2$fold_3"part$i"
    
    mkdir -p $new_fold
    echo $template > $new_fold/README.md

    git_ign="./.gitignore"
    echo ${new_fold:2}"/*" >> $git_ign
    echo -e !${new_fold:2}"/README.md\n" >> $git_ign

    echo "Writing in "$git_ign
    
    echo -e "Making dirs $new_fold \nand writing $new_fold_ex/README.md\n"
    let "i+=1"
done

case "${fold_1::-1}" in
    "processed")
	what=" *processed* traces"
	;;
    "figs")
	what="figs and videos of processed traces in data/processed/*"
	;;
    "raw")
	what="traces from [DPAv2](http://www.dpacontest.org/v2/index.php) and [DPAv4.2](http://www.dpacontest.org/v4/42_doc.php) contest"
	;;
esac


template="This dir is meant to collect all "$what"."
echo $template > "./data/"$fold_1"/README.md"
echo "Writing ./data/"$fold_1"/README.md"
echo
echo Your dirs have been generated.
