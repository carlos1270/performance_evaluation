# Arquivo utilizado para extrair as métricas do YCSB e compactar em um CSV. 

def write_line(result, line):
    if (line is not None) and len(line.split(',')) == 3:
        result += ";" + str(float(line.split(",")[2]))
    return result

def preparing_file(database, type_file):
    result = ""
    if type_file == 'run':
        result = "Rodadas;RunTime(ms)[OVERALL];Throughput(ops/sec)[OVERALL];Count[TOTAL_GCS_G1_Young_Generation];Time(ms)[TOTAL_GC_TIME_G1_Young_Generation];Time(%)[TOTAL_GC_TIME_%_G1_Young_Generation];Count[TOTAL_GCS_G1_Old_Generation];Time(ms)[TOTAL_GC_TIME_G1_Old_Generation];Time(%)[TOTAL_GC_TIME_%_G1_Old_Generation];Count[TOTAL_GCs];Time(ms)[TOTAL_GC_TIME];Time(%)[TOTAL_GC_TIME_%];Operations[READ];AverageLatency(us)[READ];MinLatency(us)[READ];MaxLatency(us)[READ];95thPercentileLatency(us)[READ];99thPercentileLatency(us)[READ];Return=OK[READ];Operations[CLEANUP];AverageLatency(us)[CLEANUP];MinLatency(us)[CLEANUP];MaxLatency(us)[CLEANUP];95thPercentileLatency(us)[CLEANUP];99thPercentileLatency(us)[CLEANUP];Operations[UPDATE];AverageLatency(us)[UPDATE];MinLatency(us)[UPDATE];MaxLatency(us)[UPDATE];95thPercentileLatency(us)[UPDATE];99thPercentileLatency(us)[UPDATE];Return=OK[UPDATE]\n"
    elif type_file == 'load':
        result = "Rodadas;RunTime(ms)[OVERALL];Throughput(ops/sec)[OVERALL];Count[TOTAL_GCS_G1_Young_Generation];Time(ms)[TOTAL_GC_TIME_G1_Young_Generation];Time(%)[TOTAL_GC_TIME_%_G1_Young_Generation];Count[TOTAL_GCS_G1_Old_Generation];Time(ms)[TOTAL_GC_TIME_G1_Old_Generation];Time(%)[TOTAL_GC_TIME_%_G1_Old_Generation];Count[TOTAL_GCs];Time(ms)[TOTAL_GC_TIME];Time(%)[TOTAL_GC_TIME_%];Operations[CLEANUP];AverageLatency(us)[CLEANUP];MinLatency(us)[CLEANUP];MaxLatency(us)[CLEANUP];95thPercentileLatency(us)[CLEANUP];99thPercentileLatency(us)[CLEANUP];Operations[INSERT];AverageLatency(us)[INSERT];MinLatency(us)[INSERT];MaxLatency(us)[INSERT];95thPercentileLatency(us)[INSERT];99thPercentileLatency(us)[INSERT];Return=OK[INSERT];Return=ERROR[INSERT];Operations[INSERT-FAILED];AverageLatency(us)[INSERT-FAILED];MinLatency(us)[INSERT-FAILED];MaxLatency(us)[INSERT-FAILED];95thPercentileLatency(us)[INSERT-FAILED];99thPercentileLatency(us)[INSERT-FAILED]\n"

    file = open(f"./logs/teste_prometheus/{database}/{type_file}_a_0_1000000_100_1000.dat")
    result += str(f"a_0") 
    for line in file:
        result = write_line(result, line)
    result += "\n"
    file.close
    
    for i in range(0, 5):
        file = open(f"./logs/teste_prometheus/{database}/{type_file}_f_{i}_1000000_100_1000.dat")
        result += str(f"f_{i}") 
        for line in file:
            result = write_line(result, line)
        result += "\n"
        file.close

    return result

# Exemplo
database = "mongo"
data_db_load = preparing_file(database, 'load')
data_db_run = preparing_file(database, 'run')


file = open(f"./logs/result_load_{database}.csv", 'w')
file.write(data_db_load)
file.close

file = open(f"./logs/result_run_{database}.csv", 'w')
file.write(data_db_run)
file.close