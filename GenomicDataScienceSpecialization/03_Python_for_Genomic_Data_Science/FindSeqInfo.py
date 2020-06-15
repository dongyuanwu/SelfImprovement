"""
    This code could find out where the DNA sequence came from and got more information for it.
"""

from Bio.Blast import NCBIWWW
from Bio.Blast import NCBIXML

# Load the sequence file
# fasta_string = open("myseq.fa").read()
fasta_string = "TGGGCCTCATATTTATCCTATATACCATGTTCGTATGGTGGCGCGATGTTCTACGTGAATCCACGTTCGAAGGACATCATACCAAAGTCGTACAATTAGGACC" \
               "TCGATATGGTTTTATTCTGTTTATCGTATCGGAGGTTATGTTCTTTTTTGCTCTTTTTCGGGCTTCTTCTCATTCTTCTTTGGCACCTACGGTAGAG"

# Running BLAST over the Internet
result_handle = NCBIWWW.qblast("blastn", "nt", fasta_string)

# The BLAST Record
blast_record = NCBIXML.read(result_handle)

# Parsing BLAST Output
len(blast_record.alignments)
E_VALUE_THRESH = 0.01
for alignment in blast_record.alignments:
    for hsp in alignment.hsps:
        if hsp.expect < E_VALUE_THRESH:
            print('****Alignment****')
            print('sequence:', alignment.title)
            print('length', alignment.length)
            print('e value', hsp.expect)
            print(hsp.query)
            print(hsp.match)
            print(hsp.sbjct)