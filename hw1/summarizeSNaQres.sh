echo analysis,h,CPUtime 

for filename in `ls out/*.*`; do name=${filename%.*};echo "${name##*/}"; done;

for filename in `ls out/*.*`; do grep "Elapsed time" $filename




