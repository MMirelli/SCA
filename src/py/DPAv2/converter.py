# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import numpy as np
import os
import csv

 
arr = []

def csv_dict_reader(file_obj):
    reader = csv.DictReader(file_obj, delimiter='\n')
    for line in reader:
        if line["# Format : WORD"][0] != '#':
          arr.append(float(line["# Format : WORD"]))

cur_path = "D:/csv/csv"
out_path = "D:/traces/traces"

for file in os.listdir(cur_path):
    if file.endswith(".csv"):
        if __name__ == "__main__":
            with open(cur_path +'/' + file) as f_obj:
                csv_dict_reader(f_obj)
                fileNameTxt =  out_path+'/' + file[:-4] +'.txt'               
                np.savetxt(fileNameTxt, arr, fmt = '%d')     
                arr = []
                arrFromFile = np.loadtxt(fileNameTxt)
                np.save(fileNameTxt[:-4],arrFromFile)
                arrFromFile = []
                os.remove(fileNameTxt)
       
     