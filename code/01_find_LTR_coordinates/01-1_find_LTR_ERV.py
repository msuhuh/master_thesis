'''
This script uses RepeatMasker output files in order to return a bed-file with only the coordinates of LTR/ERV regions.
The following data is included in the bed-file: chromosome, start position, end position, repeat classification, strand orientation.
Written by Minna Sayehban
E-mail: minna.sayehban.1224@student.uu.se
Last modified: 2024-03-27  
'''


# ================ IMPORT PACKAGES ==================
import sys


# ================ PROCESS INPUT FILE AND CREATE OUTPUT FILE ================
def main(in_path, out_path):
    with open(in_path, 'r') as in_file:
        with open(out_path, 'w') as out_file:
            for row in in_file:
                row = row.strip().split()
                if len(row) == 0:
                    pass
                elif row[0].isdigit():
                    if 'LTR' in row[10]:
                        chromo = row[4]
                        start = row[5]
                        end = row[6]
                        classification = row[10]
                        strand = row[8]
                        out_file.write(f'{chromo}\t{start}\t{end}\t{classification}\t{strand}\n')


# ================= CALL SCRIPT ====================
if __name__ == "__main__":
    in_path = sys.argv[1]
    out_path = sys.argv[2]
    main(in_path, out_path)

