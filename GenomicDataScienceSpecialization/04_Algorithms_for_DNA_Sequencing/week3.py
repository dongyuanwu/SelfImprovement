
from itertools import permutations

def readGenome(filename):
    genome = ''
    with open(filename, 'r') as f:
        for line in f:
            # ignore header line with genome information
            if not line[0] == '>':
                genome += line.rstrip()
    return genome


def editDistance(p, t):
    # Create distance matrix
    D = []
    for i in range(len(p)+1):
        D.append([0]*(len(t)+1))
    # Initialize first row and column of matrix
    for i in range(len(p)+1):
        D[i][0] = i
    for i in range(len(t)+1):
        D[0][i] = 0
    # Fill in the rest of the matrix
    for i in range(1, len(p)+1):
        for j in range(1, len(t)+1):
            distHor = D[i][j-1] + 1
            distVer = D[i-1][j] + 1
            if p[i-1] == t[j-1]:
                distDiag = D[i-1][j-1]
            else:
                distDiag = D[i-1][j-1] + 1
            D[i][j] = min(distHor, distVer, distDiag)

    return min(D[-1])


# test
p = 'GCGTATGC'
t = 'TATTGGCTATACGGTT'
editDistance(p, t)


def overlap(a, b, min_length=3):
    """ Return length of longest suffix of 'a' matching
        a prefix of 'b' that is at least 'min_length'
        characters long.  If no such overlap exists,
        return 0. """
    start = 0  # start all the way at the left
    while True:
        start = a.find(b[:min_length], start)  # look for b's prefix in a
        if start == -1:  # no more occurrences to right
            return 0
        # found occurrence; check for full suffix/prefix match
        if b.startswith(a[start:]):
            return len(a)-start
        start += 1  # move just past previous match


def naive_overlap_map(reads, k):
    olaps = {}
    for a,b in permutations(reads, 2):
        olen = overlap(a, b, min_length=k)
        if olen > 0:
            olaps[(a, b)] = olen
    return olaps

def readFastq(filename):
    """
        a function that parses the read and quality strings from a FASTQ file containing sequencing reads
    """
    sequences = []
    qualities = []
    with open(filename) as fh:
        while True:
            fh.readline()  # skip name line
            seq = fh.readline().rstrip()  # read base sequence
            fh.readline()  # skip placeholder line
            qual = fh.readline().rstrip() # base quality line
            if len(seq) == 0:
                break
            sequences.append(seq)
            qualities.append(qual)
    return sequences, qualities



def overlap_all_pairs(reads, k):
    index_dic = {}
    for read in reads:
        for i in range(len(read) - k + 1):
            if read[i:(i + k)] not in index_dic:
                index_dic[read[i:(i + k)]] = set([read])
            else:
                index_dic[read[i:(i + k)]].add(read)

    olaps = {}
    for read1 in reads:
        suffix = read1[-k:]
        edge = set([])
        read_sets = index_dic[suffix]
        for read2 in read_sets:
            if read1 != read2:
                olen = overlap(read1, read2, min_length=k)
                if olen > 0:
                    edge.add(read2)
                    olaps[read1] = edge

    return olaps
