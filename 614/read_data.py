#!/usr/bin/env python

from sys import argv
from glob import glob
from xml.dom.minidom import parse
from itertools import izip

assert len(argv) == 2

def read_data(name):
    res = []
    for in_file in glob("*.xml"):
        for i in parse(in_file).getElementsByTagName("Track"):
            for val in str(i.getElementsByTagName(name)[0].firstChild.wholeText).strip().split():
                res.append(float(val))
    return res

file(argv[1], "w").writelines("%s %s\n" % i \
        for i in izip(read_data("phi0"), read_data("cotTheta")))
