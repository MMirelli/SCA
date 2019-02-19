def main():
    filename = '/home/maks/Studying/Uni/SCA/DPAv4.2/traces/k00/DPACV42_000000.trc'
    out = open('../../csvs/output.csv', 'w')
    rawdata = open(filename)
    print('Extracting samples...')
    #out.write('time,samples\n')
    count = 0
    c = 0
    t = 1/float(1024)
    for byte in rawdata.read():
        count += 1
        if count > 357 and count < 0.05*1704403:
            sample = ord(byte) - 128 # because it is signed pls double check
            out.write('%f,%d\n' % (t*count, sample))
    print('Done')
main()
