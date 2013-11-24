#!/usr/bin/env python

import sys
import os

def main(path):
    for dirname, dirnames, filenames in os.walk(path):
        # print path to all subdirectories first.
        for subdirname in dirnames:
            print os.path.join(dirname, subdirname)

        # print path to all filenames.
        for filename in filenames:
            print os.path.join(dirname, filename)

         # Advanced usage:
         # editing the 'dirnames' list will stop os.walk() from recursing into there.
         if '.git' in dirnames:
             # don't go into any .git directories.
             dirnames.remove('.git')


if __name__ == '__main__':
    if len(sys.argv) > 1:
        main(sys.argv[1])
    else:
        print 'no arguments provided'
