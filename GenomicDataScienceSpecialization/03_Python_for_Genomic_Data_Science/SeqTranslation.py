"""
    Translate the DNA sequence to a protein sequence.
"""
from Bio.Seq import Seq
from Bio.Alphabet import IUPAC

seq_string = "TGGGCCTCATATTTATCCTATATACCATGTTCGTATGGTGGCGCGATGTTCTACGTGAATCCACGTTCGAAGGACATCATACCAAAGTCGTAC" \
             "AATTAGGACCTCGATATGGTTTTATTCTGTTTATCGTATCGGAGGTTATGTTCTTTTTTGCTCTTTTTCGGGCTTCTTCTCATTCTTCTTTGGCAC" \
             "CTACGGTAGAG"
coding_dna = Seq(seq_string, IUPAC.unambiguous_dna)
coding_dna.translate()