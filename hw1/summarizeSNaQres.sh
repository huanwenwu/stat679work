#----Exercise 1 & 2
#produce a table in csv format, with 1 row per analysis and 3 columns

# echo 'analysis,h,CPUtime' >> hw1.csv  #print the names of variables
# for filename in `ls out/*.*` ;   #ls "out" folder first
# do analysis=`echo "${filename}" | cut -d / -f 2| cut -d . -f 1 `; # cut strings
#   h=`grep "hmax" log/${analysis}.log | head -n 1| cut -d " " -f 4| cut -d , -f 1`;
#   CPUtime=`grep "Elapsed time" $filename | cut -d " " -f 4`; # grep first and pipe to cut strings
#   echo "$analysis,$h,$CPUtime" >> hw1.csv
# done;

#----Exercise 3

echo "analysis","h","CPUtime","Nruns","Nfail","fabs","frel","xabs","xrel","seed","under3460","under3450","under3440" >> hw1.csv
for filename in `ls log/*.*` ;
do
  analysis=`basename -s ".log" ${filename}`;  #use "basename" to get the rootname
  h=`grep "hmax" $filename | head -n 1|sed -E 's/.*hmax = ([0-9]+),/\1/' `;  #grep lines with "hmax",choose the 1st line,and replace it with the part between "hmax = " and ","
  CPUtime=`grep "Elapsed time" out/${analysis}.out | sed -E 's/.*Elapsed time: ([^ ]+) .*/\1/' `;  #replace the selected line with the part between "Elapsed time: " and the following space " "
  Nruns=`grep "FINISHED SNaQ for run" $filename| sed -E 's/.*FINISHED SNaQ for run ([^,]+), .*/\1/'| tail -n 1`;  #get the part between “FINISHED SNaQ for run ” and the following ","
  Nfail=`grep "max number of failed proposals" $filename| sed -E 's/.*max number of failed proposals = ([^,]+), .*/\1/'`;  #get the part between "failed proposals = " and the first following ","
  fabs=`grep "ftolAbs" $filename|sed -E 's/.*ftolAbs=([^,]+),/\1/' `;  #get the part between "ftolAbs=" and the first following ","
  frel=`grep "ftolRel" $filename|sed -E 's/.*tolerance parameters: ftolRel=([^,]+),.*/\1/'`;  #get the part between "ftolRel=" and the first following ","
  xabs=`grep "xtolAbs" $filename| sed -E 's/.*xtolAbs=([^,]+),.*/\1/'`;  #get the part between "xtolAbs=" and the first following ","
  xrel=`grep "xtolRel" $filename| sed -E 's/.*xtolRel=([^,]+)./\1/'`;  #get the part between "xtolRel=" and the first following ","
  seed=`grep "seed:" $filename|head -n 1| sed -E 's/.*seed: ([0-9]+) .*/\1/'`;  #choose the line with seed for the first runs in it, and get the part between "seed: " and " ."

  loglik=`grep "loglik of best" $filename|sed -E 's/.*loglik of best ([^.]+).[0-9]+/\1/'`;  # get all scores in the file--choose lines and get the part between "loglik of best " and the "." (actually, the integer part of the score)
  under3460=0  #set initial value
  under3450=0
  under3440=0
  for num in $loglik;
  do
    if [ $num -lt 3440 ]  #if score less than 3440
    then
      ((under3440++))  # add 1 to under3440
      ((under3450++))  # add 1 to under3450
      ((under3460++))  # add 1 to under3460
    elif [ $num -lt 3450 ]  #else if score less than 3450
    then
      ((under3450++))
      ((under3460++))
    elif [ $num -lt 3460 ]  #else if score less than 3460
    then
      ((under3460++))
    fi
  done;  #the second for loop done
  echo $analysis,$h,$CPUtime,$Nruns,$Nfail,$fabs,$frel,$xabs,$xrel,$seed,$under3460,$under3450,$under3440 >> hw1.csv;
done;  #the first for loop done
