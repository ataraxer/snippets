#!/usr/bin/env python

import sys
import time

class Colors:
    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)

    @staticmethod
    def all():
        return range(8)


def _term_has_color(stream):
    if not hasattr(stream, 'isatty'):
        return False
    if not stream.isatty():
        return False
    try:
        import curses
        curses.setupterm()
        return curses.tigetnum('colors') > 2
    except:
        return False


def colorize(text, color=Colors.WHITE):
    if _term_has_color(sys.stdout):
        sequence = "\x1b[1;%dm" % (30+color) + text + "\x1b[0m"
        return sequence
    else:
        return text

