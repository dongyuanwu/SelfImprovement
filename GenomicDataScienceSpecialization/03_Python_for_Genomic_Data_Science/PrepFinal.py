"""
    Write a Python program that takes as input a file containing DNA sequences in multi-FASTA format,
    and computes the answers to the following questions. You can choose to write one program with multiple
    functions to answer these questions, or you can write several programs to address them.
    We will provide a multi-FASTA file for you, and you will run your program to answer the exam questions.
"""

f = open("dna.example.fasta")
seqs = {}
for line in f:
    # let's discard the newline at the end (if any)
    line = line.rstrip()
    # distinguish header from sequence
    if line[0] == '>': # or line.startswith('>')
        words = line.split()
        name = words[0][1:]
        seqs[name] = ''
    else: # sequence, not header
        seqs[name] = seqs[name] + line

f.close()

# (1) How many records are in the file?

len(seqs)


# (2) What are the lengths of the sequences in the file?
#     What is the longest sequence and what is the shortest sequence?
#     Is there more than one longest or shortest sequence? What are their identifiers?

eachlength = {}
for key, value in seqs.items():
    eachlength[key] = len(value) # lengths of the seqs

max(eachlength.values()) # max value
max(eachlength, key=eachlength.get) # max value's key

min(eachlength.values()) # min value
min(eachlength, key=eachlength.get) # min value's key


# (3) An open reading frame (ORF) is the part of a reading frame that has the potential to encode a protein.
#     It starts with a start codon (ATG), and ends with a stop codon (TAA, TAG or TGA).
#     For instance, ATGAAATAG is an ORF of length 9.
#     Given an input reading frame on the forward strand (1, 2, or 3) your program should be able to
#     identify all ORFs present in each sequence of the FASTA file, and answer the following questions:
#     What is the length of the longest ORF in the file?
#     What is the identifier of the sequence containing the longest ORF?
#     For a given sequence identifier, what is the longest ORF contained in the sequence represented by that identifier?
#     What is the starting position of the longest ORF in the sequence that contains it?
#     The position should indicate the character number in the sequence.

def start_codon_found(dna, frame):
    """
        This function checks if given dna sequence has an in frame start codon and return its position.
    """
    start_codon_posi = -1
    startcodon = 'atg'
    for i in range(frame, len(dna), 3):
        codon = dna[i:i+3].lower()
        if codon in startcodon:
            start_codon_posi = i
#            print('A start codon (ATG) was found!')
            break
    return start_codon_posi

def stop_codon_found(dna, frame):
    """
        This function checks if given dna sequence has an in frame stop codon and return its position.
    """
    stop_codon_posi = -1
    stopcodon = ['tga', 'tag', 'taa']
    for i in range(frame, len(dna), 3):
        codon = dna[i:i+3].lower()
        if codon in stopcodon:
            stop_codon_posi = i+3-1
#            print('A stop codon (TAA, TAG or TGA) was found!')
            break
    return stop_codon_posi

def ORF_found(dna, frame):
    """
        This function checks if given dna sequence is an ORF.
    """
    orflength = 0
    flag = True
    flag1 = 0
    stop_codon = -1
    while flag is True:
        if flag1 == 0:
            skipposi = frame+stop_codon+1
        else:
            skipposi = stop_codon+1
        start_codon = start_codon_found(dna, skipposi)
        if start_codon == -1:
            flag = False
        else:
            stop_codon = stop_codon_found(dna, start_codon)
            if stop_codon == -1:
                flag = False
            else:
                if orflength < (stop_codon - start_codon + 1):
                    orflength = stop_codon - start_codon + 1
        flag1 = 1
    return orflength


eachlength = {}
for key, value in seqs.items():
    eachlength[key] = ORF_found(value, 0)

max(eachlength.values())  # max value
max(eachlength, key=eachlength.get)  # max value's key

givenid = 'gi|142022655|gb|EQ086233.1|43'
frame0 = ORF_found(seqs[givenid], 0)
frame1 = ORF_found(seqs[givenid], 1)
frame2 = ORF_found(seqs[givenid], 2)

# (4) A repeat is a substring of a DNA sequence that occurs in multiple copies (more than one) somewhere in the sequence.
#     Although repeats can occur on both the forward and reverse strands of the DNA sequence,
#     we will only consider repeats on the forward strand here. Also we will allow repeats to overlap themselves.
#     For example, the sequence ACACA contains two copies of the sequence ACA - once at position 1 (index 0 in Python),
#     and once at position 3. Given a length n, your program should be able to identify all repeats of length n in all
#     sequences in the FASTA file. Your program should also determine how many times each repeat occurs in the file,
#     and which is the most frequent repeat of a given length.

def strcount(seq, string):
    """
        This function counts a specific string from a sequence, including repeats.
    """
    strlen = len(string)
    seqlen = len(seq)
    counts = {string:0}
    for i in range(0, seqlen-strlen+1, 1):
        if string in seq[i:(i+strlen)]:
            counts[string] = counts[string] + 1
    return counts

def count_subseq_n(seq, n):
    count_dic = {}
    seqlen = len(seq)
    for i in range(0, seqlen-n+1, 1):
        if seq[i:(i+n)] not in count_dic.keys():
            count_dic.update(strcount(seq, seq[i:(i+n)]))
    return count_dic

oldList = []
for value in seqs.values():
    oldList.append(count_subseq_n(value, 7))

newList = {}

newList = oldList[0]

for i in range(1, len(oldList), 1):
    for key in oldList[i].keys():
        if key in newList.keys():
            newList[key] = newList[key] + oldList[i][key]
        else:
            newList.update({key:oldList[i][key]})

