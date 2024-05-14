# ================ IMPORT PACKAGES ==================

import sys
import matplotlib.pyplot as plt


# ================ PROCESS BEDGRAPH FILE AND CREATE HISTOGRAM ================

def main(in_file, out_file):
    with open(in_file, 'r') as bedgraph:
        scores = []
        for line in bedgraph:
            score = float(line.split()[3])
            scores.append(score)
            

    plt.hist(scores, bins=50, color='blue', alpha=0.7)
    plt.xlabel('PhyloP Score')
    plt.ylabel('Frequency')
    plt.title('PhyloP Scores')
    plt.grid(True)
    plt.show()


if __name__ == "__main__":
    in_file = sys.argv[1]
    out_file = sys.argv[2]
    main(in_file, out_file)
