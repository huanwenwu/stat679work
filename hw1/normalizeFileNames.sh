# change all file names timetesty_snaq.log to timetest0y_snaq.log
for filename in `ls log/timetest?_*.log`;   # ls "log" folder first     
do mv "$filename" ${filename:0:12}0${filename:12}; #insert a "0" between the 12th and 13th characters of filename
done;

# change all file names timetesty_snaq.out to timetest0y_snaq.out
for filename in `ls out/timetest?_*.out`;
do mv "$filename" ${filename:0:12}0${filename:12};
done;
