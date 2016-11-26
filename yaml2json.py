#!/usr/bin/env python

import json
import sys
import yaml

if len(sys.argv) != 2:
    print "Usage: {} <filename>".format(sys.argv[0])
    sys.exit(1)

infile = sys.argv[1]

stream = file(infile, 'r')
yaml_data = yaml.load(stream)
print json.dumps(yaml_data, indent=4, separators=(',', ': '))
