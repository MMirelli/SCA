import os
import csv

""" This script "trims" all raw traces in /data/raw/DPAv2/public_db/part0


It deletes the DPAv2 traces header (lines starting by #), and it saves 
the result in /data/processed/DPAv2/public_db/part0. 

This script is already multiplatform compatible; tested with the following
OSs:
	* Windows 10

--------
TODO: test it on Linux
--------
TODO: make a function out of it!
--------
"""

sepr = os.sep
up_dir = ".." + sepr
home_path = up_dir * 3
# relative path to traces
data_path = home_path + "data" + sepr

raw_traces_path = (data_path + "raw" + sepr + "DPAv2" +
                   sepr + "public_db"  + sepr + "part0"  + sepr)

processed_traces_path = (data_path + "processed"  + sepr + "DPAv2" +
                         sepr + "public_db" + sepr + "part0"  + sepr)

i = 0

print("Processing traces \n")

for filename in os.listdir(raw_traces_path):

      i += 1
      t = open(processed_traces_path + "tr" + str(i) + ".csv", "wb")
      writer = csv.writer(t)

      for row in csv.reader(open(raw_traces_path + filename, 'r')):
            if row[0][0]!='#':
                  writer.writerow(row)
      
      t.close()

print("Exiting, find traces in " + processed_traces_path) 
