import os
import csv
from tabulate import tabulate

def removeHeadersFromCSV(full_path):
    with open(full_path, "r") as f:
        lines = f.readlines()

    with open(full_path, "w") as f:
        f.writelines(lines[2:])

    return lines[0:2], lines[2:]


def insertHeadersToCSV(headers, result_full_path):
    with open(result_full_path, "r") as f:
        lines = f.readlines()

    with open(result_full_path, "w") as f:
        for index, head in enumerate(headers):
            lines.insert(index, head)
        f.writelines(lines)


if __name__ == '__main__':
    cartella = "gpu_node"
    for module in ["openmpi", "intel"]:
        directory = cartella + "/results/" + module

        for filename in os.listdir(directory):
            full_path = os.path.join(directory, filename)

            headers, lines = removeHeadersFromCSV(
                full_path)

            rows = []
            with open(full_path, "r") as file:
                csvreader = csv.reader(file)
                titles = next(csvreader)
                for row in csvreader:
                    rows.append(row)

                res = tabulate(rows, titles, numalign="right")
                tabular_full_path = os.path.join(
                    cartella + "/results/tabular/" + module, filename[:-2]+"txt")

                with open(tabular_full_path, "w+") as file:
                    file.writelines(headers)
                    file.writelines(res)

                insertHeadersToCSV(headers, full_path)
                
                
                
                
