# Arquivo utilizado para extrair as métricas do YCSB e compactar em um CSV. 

def compare_and_add(result, line, current_round):
    content = line.split(',')
    if len(content) == 3:
        if f"{content[1]}{content[0]}" in result:
            result[f"{content[1]}{content[0]}"].append(f"{current_round}#{float(content[2])}")
        else:
            result[f"{content[1]}{content[0]}"] = [f"{current_round}#{float(content[2])}"]
    
    return result

def preparing_file(database, type_file, sufix):
    result = {}

    file = open(f"./logs/teste_prometheus/{database}/{type_file}_a_0_{sufix}")
    current_round = "a_0"
    result["Rodada"] = [current_round]
    for line in file:
        result = compare_and_add(result, line, current_round)
    file.close
    
    for i in range(0, 5):
        file = open(f"./logs/teste_prometheus/{database}/{type_file}_f_{i}_{sufix}")
        current_round = f"f_{i}"
        result["Rodada"].append(current_round)
        for line in file:
            result = compare_and_add(result, line, current_round)
        file.close

    return result

def join(listing, sep):
    r = ''
    for i in range(len(listing)):
        r += f"{listing[i]}{sep}"
    
    return r

def write_file(filepath, data):
    file = open(filepath, 'w')
    result = join(list(data.keys()), ";") + "\n"
    file.write(result)

    content = ''
    for current_round in data["Rodada"]:
        for column in data:
            if column != "Rodada":
                check_content = False
                for dado in data[column]:
                    if dado.split("#")[0] == current_round:
                        content += f"{float(dado.split('#')[1])};"
                        check_content = True

                if not check_content:
                    content += "0.0;"
            else:
                content += f"{current_round};"

        content += "\n"

    file.write(content)
    file.close()

# Exemplo
database = "mongo"
sufix = "1000000_100_1000.dat"
data_db_load = preparing_file(database, 'load', sufix)
data_db_run = preparing_file(database, 'run', sufix)

write_file(f"./logs/result_load_{database}.csv", data_db_load)
write_file(f"./logs/result_run_{database}.csv", data_db_run)