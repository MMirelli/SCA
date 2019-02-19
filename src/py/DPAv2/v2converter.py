import csv

home_path = "../../../"
# relative path to traces
traces_path = home_path + 'data/traces/DPAv2/public_db/DPA_contest2_public_base_diff_vcc_a128_2009_12_23/'
# name of the file containing the trace
raw_trace = "wave_aist-aes-agilent_2009-12-30_22-53-19_n=1_k=0000000000000003243f6a8885a308d3_m=bf7158809cf4f3c762e7160f38b4da56_c=ff869d789be05b4b673662de27dd1bcd.csv"

path_to_csv = home_path + "data/csvs/DPAv2/"
#with open(path_to_csv + 'tr.csv', 'wb') as outfile:
#    writer = csv.writer(outfile)
writer = csv.writer(open(path_to_csv + 'tr.csv', 'wb'))
for row in csv.reader(open(traces_path+raw_trace, 'r')):
      if row[0][0]!='#':
            writer.writerow(row)
      
