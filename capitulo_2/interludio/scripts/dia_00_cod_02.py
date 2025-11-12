#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# dia_00_cod_02.py
#
# Reinas en tregua: problema de enumeración
#
# Búsqueda exhaustiva

from dia_00_cod_07 import Parcial

def tregua(n):
    # sols = list()
    # for p in Parcial.opciones(n):
    #     if not p.conflicto():
    #       sols.append(p)

    sols = [p for p in Parcial.opciones(n)\
          if not p.conflicto()]

    return sols

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
