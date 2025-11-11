#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# dia_00_cod_01.py
#
# Reinas en tregua: problema de búsqueda
#
# Búsqueda exhaustiva

from dia_00_cod_07 import Parcial

def tregua(n):
    for p in Parcial.opciones(n):
        if not p.conflicto():
          return p

if __name__ == '__main__':
    import sys
    if len(sys.argv) > 1:
        import time
        try:
            n = int(sys.argv[1])
        except:
            raise
        t0 = time.time()
        aux = tregua(n)
        t = time.time() - t0
        print(aux)
        print('Tiempo de procesador: %g' % t)


