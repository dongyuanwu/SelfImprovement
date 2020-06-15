"""
    Read a FASTA File.
"""

try:
    f = open("myfile.fasta")
except IOError:
    print("File myfile.fasta does not exist!")

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

close(f)