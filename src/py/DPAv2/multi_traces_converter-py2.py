import os
import csv

home_path = "../../../"
# relative path to traces
data_path = home_path + "data/"

traces_path = data_path + "traces/DPAv2/public_db/part0/" # TODO modify
path_to_csv = data_path + "csvs/DPAv2/part0/"            #

i = 0

print("Processing traces \n")

for filename in os.listdir(traces_path):

      i += 1
      t = open(path_to_csv + "tr" + str(i) + ".csv", "wb")
      writer = csv.writer(t)

      for row in csv.reader(open(traces_path + filename, 'r')):
            if row[0][0]!='#':
                  writer.writerow(row)
      
      t.close()

print("Exiting, find traces in ../../../data/csvs/DPAv2/part0")
