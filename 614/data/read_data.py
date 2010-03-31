#!/usr/bin/env python

from sys import stdout, argv
from glob import glob
from os.path import join
from xml.dom.minidom import parse
from itertools import izip

assert(len(argv) == 2)

def read_data(name):
    res = []
    data_dir = argv[1]
    for in_file in glob(join(data_dir, "*.xml")):
        for i in parse(in_file).getElementsByTagName("Track"):
            for val in str(i.getElementsByTagName(name)[0].firstChild.wholeText).strip().split():
                res.append(float(val))
    return res

stdout.writelines("%s %s\n" % i \
        for i in izip(read_data("phi0"), read_data("cotTheta")))
