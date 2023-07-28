# Variaveis importantes
log=logs/metricas.log

cont=1
disk=sda2
placa=enp

# Cabecalho
echo Cont MenUsed MenFree MenShared SwapUsed SwapFree DiskBlockKB DiskUsed DiskUsedPerc CpuUsr CpuSys CpuIOWait CpuSoft CpuIdle NetBytesReceived NetPackagesReceived NetErrsReceived NetBytesTransmitid NetPackagesTransmitid NetErrsTransmitid Data Hora > $log
echo Cont MenUsed MenFree MenShared SwapUsed SwapFree DiskBlockKB DiskUsed DiskUsedPerc CpuUsr CpuSys CpuIOWait CpuSoft CpuIdle NetBytesReceived NetPackagesReceived NetErrsReceived NetBytesTransmitid NetPackagesTransmitid NetErrsTransmitid Data Hora

while [ True ]
do

men=`free | grep Mem | awk '{print $3, $4, $5}'`
swap=`free | grep Swap | awk '{print $3, $4}'`
disco=`df | grep $disk | awk '{print $2, $3, $5}'`
mpstat=`mpstat | grep all | awk '{print $3, $5, $6, $8, $12}'`
net_1=`cat /proc/net/dev | grep $placa | awk '{print $2, $3, $4, $10, $11, $12}'`

sleep 1

net_2=`cat /proc/net/dev | grep $placa | awk '{print $2, $3, $4, $10, $11, $12}'`

net_br_1=`echo $net_1 | awk '{print $1}'`
net_br_2=`echo $net_2 | awk '{print $1}'`
net_br=`expr $net_br_2 - $net_br_1` 

net_pr_1=`echo $net_1 | awk '{print $2}'`
net_pr_2=`echo $net_2 | awk '{print $2}'`
net_pr=`expr $net_pr_2 - $net_pr_1`

net_er_1=`echo $net_1 | awk '{print $3}'`
net_er_2=`echo $net_2 | awk '{print $3}'`
net_er=`expr $net_er_2 - $net_er_1`

net_bt_1=`echo $net_1 | awk '{print $4}'`
net_bt_2=`echo $net_2 | awk '{print $4}'`
net_bt=`expr $net_bt_2 - $net_bt_1` 

net_pt_1=`echo $net_1 | awk '{print $5}'`
net_pt_2=`echo $net_2 | awk '{print $5}'`
net_pt=`expr $net_pt_2 - $net_pt_1`

net_et_1=`echo $net_1 | awk '{print $6}'`
net_et_2=`echo $net_2 | awk '{print $6}'`
net_et=`expr $net_et_2 - $net_et_1`

data=`date '+%d/%m/%y %H:%M:%S'`

echo $cont $men $swap $disco $mpstat $net_br $net_pr $net_er $net_bt $net_pt $net_et $data >> $log
echo $cont $men $swap $disco $mpstat $net_br $net_pr $net_er $net_bt $net_pt $net_et $data

#Frequencia de amostragem
sleep 2

cont=`expr $cont + 1`

done
