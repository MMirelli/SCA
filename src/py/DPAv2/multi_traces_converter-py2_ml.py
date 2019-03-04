import math
import os
import csv
import sys

""" This script "trims" all raw traces in /data/raw/DPAv2/public_db


It deletes the DPAv2 traces header (lines starting by #), and it saves 
the result in /data/processed/DPAv2/public_db. 

This script is already multiplatform compatible; tested with the following
OSs:
	* Windows 10

--------
TODO: make a function out of it!
--------
"""

sepr = os.sep
up_dir = ".." + sepr
home_path = up_dir * 3
# relative path to traces
data_path = home_path + "data" + sepr

raw_traces_path = (data_path + sepr + "raw" + sepr + "DPAv2" + #check two sepr why?????
                   sepr + "public_db"  + sepr)

raw_csv = raw_traces_path + "*.csv"

processed_traces_path = (data_path + "ml" + sepr)

print("Processing traces \n")

c = 0
dir_l = os.listdir(raw_traces_path)
for filename in dir_l:
      c += 1
      t = open(processed_traces_path + filename, "wb")
      writer = csv.writer(t)

      for row in csv.reader(open(raw_traces_path + filename, 'r')):
            if row[0][0]!='#':
                  writer.writerow(row)

      t.close()

      
      perc = c/(len(dir_l)/100)
      s = '['+ perc*'#' + ' '*(100-perc) + '] ' + str(perc)+('% ') + "Processed: " + str(c)
      sys.stdout.write('\r'+s)
      
print("Exiting, find traces in " + processed_traces_path) 
