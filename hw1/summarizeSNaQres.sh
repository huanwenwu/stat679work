# produce a table in csv format, with 1 row per analysis and 3 columns

echo 'analysis'  'h'  'CPUtime'  #print the names of variables
for filename in `ls out/*.*` ;   #ls "out" folder first
do analysis=`echo "${filename}" | cut -d / -f 2| cut -d . -f 1 `; # cut strings
h=`grep "hmax" log/${analysis}.log | head -n 1| cut -d " " -f 4| cut -d , -f 1`;
CPUtime=`grep "Elapsed time" $filename | cut -d " " -f 4`; # grep first and pipe to cut strings
echo $analysis $h $CPUtime
done;
