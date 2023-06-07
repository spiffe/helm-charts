#!/usr/bin/env python3

import os
import sys
from dict_deep import deep_set
import ruamel.yaml

y = ruamel.yaml.YAML()
y.indent(mapping=2, sequence=4, offset=2)
y.preserve_quotes = True

d = y.load(open(os.environ['VALUES']))

tagquery = os.environ['QUERY'] + '.tag'

deep_set(d, tagquery, os.environ['LATEST_VERSION']);

y.dump(d, sys.stdout)
