# Váriaveis importantes

#rodada
cont=0
#frequência de amostragem em segundos
freq=1200
#ip host do DB
host="192.168.0.105"
#porta do DB
port="8003"

#quantidade de registros enviados ao total
recordcount=1000000
#quantidade de usuarios simulados
threads=100
#quantidade de registros por usuario
target=1000



#execução
echo `expr $cont + 1`
./bin/ycsb load cassandra-cql -P workloads/workloada -threads $threads -target $target -p hosts=$host -p port=$port -p recordcount=$recordcount -s > `expr "/logs/cassandra/load_a_"$cont"_"$recordcount"_"$threads"_"$target".dat"`
sleep 10
./bin/ycsb run cassandra-cql -P workloads/workloada -threads $threads -target $target -p hosts=$host -p port=$port -p recordcount=$recordcount -s > `expr "/logs/cassandra/run_a_"$cont"_"$recordcount"_"$threads"_"$target".dat"`

while [ True ]
do

./bin/ycsb load cassandra-cql -P workloads/workloadf -threads $threads -target $target -p hosts=$host -p port=$port -p recordcount=$recordcount -s > `expr "/logs/cassandra/load_f_"$cont"_"$recordcount"_"$threads"_"$target".dat"`
sleep 10
./bin/ycsb run cassandra-cql -P workloads/workloadf -threads $threads -target $target -p hosts=$host -p port=$port -p recordcount=$recordcount -s > `expr "/logs/cassandra/run_f_"$cont"_"$recordcount"_"$threads"_"$target".dat"`

sleep $freq

cont=`expr $cont + 1`
echo $cont

done