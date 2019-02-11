#!/usr/bin/python

import sys, getopt

def pu():
     print 'usage: %s -i <inputfile>' % sys.argv[0]

def main(argv):
    inputfile = ''
    try:
        opts, args = getopt.getopt(argv,"hi:",["ifile="])
    except getopt.GetoptError:
        pu()
        sys.exit(2)
    for opt, arg in opts:
        if opt == "-h":
            pu()
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile=arg
    if opts == []:
            pu() 
            exit(2)
    print "Parsing", inputfile
    try: 
        f = open(inputfile)
    except:
        print "Error opening file" 
        sys.exit(2)
    f.seek(0)
    str = f.read()
    smbscans = str.split("\n***")
    for scan in smbscans: 
        if "VULNERABLE" in scan:
            print scan.split("***")[1]
            vulninfo = scan.split("VULNERABLE")[1:]
            for i in range(1,len(vulninfo)/2+1): 
                print vulninfo[i*2-2].replace("State","").replace(":","").replace("|","   |")
                print vulninfo[i*2-1].split("Nmap")[0][1:].replace("IDs:  ","").replace("|","   |")


if __name__ == "__main__":
    main(sys.argv[1:])

