#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# dia_00_cod_05.py
#
# Problema de búsqueda

from dia_00_cod_03 import Parcial  #_03, _10, _11

def tregua(n):
    p = Parcial(n)
    return desciende(p)

# Se presupone que noy hay conflictos en el parámetro p.
def desciende(p):
    if p.completa():
        return p
    else:
        for pa in p.amplía():
            if not pa.conflicto():
                aux = desciende(pa)
                if aux:
                    return aux

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
