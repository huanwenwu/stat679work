for var in `ls out/timetest?_*.out`;
do mv "$var" out/`echo "$var" |awk -F 'st' '{print "timetest0" $2}'`;
done;
for var in `ls log/timetest?_*.log`;
do mv "$var" log/`echo "$var" |awk -F 'st' '{print "timetest0" $2}'`;
done;


