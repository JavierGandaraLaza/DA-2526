#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# dia_00_cod_04.py
#
# Problema de enumeración

from dia_00_cod_03 import Parcial # _03, _10, _11

def tregua(n):
    sols = list()
    p = Parcial(n)
    desciende(p, sols)
    return sols

# Se presupone que noy hay conflictos en el parámetro p.
def desciende(p, sols):
    if p.completa():
        sols.append(p)
    else:
        for pa in p.amplía():
            if not pa.conflicto():
                desciende(pa, sols)

if __name__ == '__main__':
    import sys
    if len(sys.argv) > 1:
        import time
        try:
            n = int(sys.argv[1])
        except:
            raise
        t0 = time.clock()
        aux = tregua(n)
        t = time.clock() - t0
        print(aux)
        print('Tiempo de procesador: %g' % t)
