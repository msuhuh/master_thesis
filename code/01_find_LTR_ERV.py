# ================ IMPORT PACKAGES ==================

import sys
import csv


# ================ PROCESS INPUT FILE AND CREATE OUTPUT FILE ================

def main(in_path, out_path):

    with open(in_path, 'r') as in_file:
        with open(out_path, 'w') as out_file:
            out_file = csv.writer(out_file)
            out_file.writerow(['Start', 'End', 'Classification', 'Strand'])
            
            for row in in_file:
                row = row.strip().split()
                if len(row) == 0:
                    pass
                elif row[0].isdigit():
                    if 'LTR' in row[10]:
                        start = row[5]
                        end = row[6]
                        classification = row[10]
                        strand = row[8]
                        
                        out_file.writerow([start, end, classification, strand])
                    
                    

if __name__ == "__main__":
    in_path = sys.argv[1]
    out_path = sys.argv[2]
    main(in_path, out_path)

                    
    
    
    
    
