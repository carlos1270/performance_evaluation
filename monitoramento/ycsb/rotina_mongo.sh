# Váriaveis importantes

cont=0
#frequência de amostragem em segundos
freq=1200
#ip host do DB
host="192.168.0.105"
#porta do DB
port="30001"

#quantidade de registros enviados ao total
recordcount=1000000
#quantidade de usuarios simulados
threads=100
#quantidade de registros por usuario
target=1000

echo `expr $cont + 1`
./bin/ycsb load mongodb -P workloads/workloada -threads $threads -target $target -p mongodb.url="mongodb://"$host":"$port"/ycsb?w=0" -p recordcount=$recordcount -s > `expr "/logs/mongo/load_a_"$cont"_"$recordcount"_"$threads"_"$target".dat"`
sleep 10
./bin/ycsb run mongodb -P workloads/workloada -threads $threads -target $target -p mongodb.url="mongodb://"$host":"$port"/ycsb?w=0" -p recordcount=$recordcount -s > `expr "/logs/mongo/run_a_"$cont"_"$recordcount"_"$threads"_"$target".dat"`

while [ True ]
do

./bin/ycsb load mongodb -P workloads/workloadf -threads $threads -target $target -p mongodb.url="mongodb://"$host":"$port"/ycsb?w=1" -p recordcount=$recordcount -p mongodb.upsert=true -s > `expr "/logs/mongo/load_f_"$cont"_"$recordcount"_"$threads"_"$target".dat"`
sleep 10
./bin/ycsb run mongodb -P workloads/workloadf -threads $threads -target $target -p mongodb.url="mongodb://"$host":"$port"/ycsb?w=1" -p recordcount=$recordcount -p mongodb.upsert=true -s > `expr "/logs/mongo/run_f_"$cont"_"$recordcount"_"$threads"_"$target".dat"`

sleep $freq

cont=`expr $cont + 1`
echo $cont

done