energy = "energy.csv"
waterTemperature = "waterTemperature.csv"

data_time=[]
energy_produced=[]
lines_e=[]
with open(energy,'r') as e:
    lines = e.readlines()
    for line in lines:  # get rid of the empty lines
        if line =="\n":
            continue
        else:
            lines_e.append(line)

    for i in range(1,len(lines_e)-1): # start from 1, because we don't want the first line
        time=lines_e[i].split()[0]
        wh=lines_e[i].split(',')
        data_time.append(time)  # append value to data_time list
        energy_produced.append(float(wh[1].strip())/1000) # remove "\n" first and get the wh/1000 values


for i in range(len(data_time)-1):  # check whether the data_time is ordered
    if data_time[i] <= data_time[i+1]:
        continue
    else:
        print ("Not Ordered!")
        exit()  # if not ordered, print message and exit

data_time_t=[]
water_temp=[]
num=[]
lines_w=[]
with open(waterTemperature,'r') as w:
    lines = w.readlines()
    for line in lines:
        if line =="\n":  # the same purpose as before
            continue
        else:
            lines_w.append(line)

    for i in range(2,len(lines_w)):
        temp=lines_w[i].split()[2]
        temp2=temp.split(',')[1]
        water_temp.append(temp2)
        tim=lines_w[i].split(',')[1]
        data_time_t.append(tim)
        num.append(lines_w[i].split(',')[0])

for i in range(len(data_time_t)-1):   # check whether the time value in waterTemperature.csv are ordered
    if data_time_t[i] <= data_time_t[i+1] or data_time_t[i][9:11]=="12":
        continue
    else:
        print ("Not Ordered!")
        exit()

match_energy=[]
for i in range(len(num)-1):
    mon_t=data_time_t[i][0:2]
    day_t=data_time_t[i][3:5]
    timedata= "2016"+"-"+mon_t+"-"+day_t  # get the data in the format as the time values in energy.csv file
    timedata2=data_time.index(timedata)+1
    if data_time_t[i][0:2]<data_time_t[i+1][0:2] or data_time_t[i][3:5]<data_time_t[i+1][3:5]: # find the last record of the day
        match_energy.append(str(energy_produced[timedata2]))
    else:
        match_energy.append("")
match_energy.append("")

with open('merged_data.csv','w') as f:
    f.write("Plot Title: 10679014 jackson July29\n")
    f.write("#"+","+"Date Time GMT-05:00"+","+"K-Type"+","+"Wh/1000"+"\n")
    for i in range(len(num)):
        f.write(num[i]+","+data_time_t[i]+","+water_temp[i]+","+match_energy[i]+"\n")
