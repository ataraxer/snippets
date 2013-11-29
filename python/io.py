#!/usr/bin/env python

import sys
import time


def status_line(length):
    for i in range(length):
        sys.stdout.write('\r[%s%s]' % ('='*i, ' '*(length-i-1)))
        sys.stdout.flush()
        time.sleep(0.05)
    print ''


def prompt():
    return raw_input('>>> ')

