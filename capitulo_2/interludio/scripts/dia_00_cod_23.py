#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# dia_00_cod_23.py
#
# Resuelve el problema del viajante mediante la técnica de
# «branch & bound», empleando una acotación ingenua.

import importlib

pcl = importlib.import_module('dia_00_cod_24')
infinito = float('inf')

def bb():
    return lanza(pcl.Parcial_ct('dia_00_cod_15.txt'))

def lanza(p, mj=None, t_mj=infinito):
    fondo = p.es_completa()
    if fondo or t_mj < infinito:
        ct = p.cota()
        mejora = ct < t_mj
    else:
        # Es innecesario calcular la cota.
        ct = '—'
        mejora = True
    escribe_línea(p, ct, t_mj, fondo, mejora)
    if mejora:
        if fondo:
            mj = p
            t_mj = ct
        else:
            for ap in p.amplía():
                mj, t_mj = lanza(ap, mj, t_mj)
    return mj, t_mj

def escribe_número(x):
    return '∞' if x == infinito else str(x)

def escribe_línea(p, ct, t_mj, completa=False, mejora=False):
    récord = '[' + escribe_número(t_mj) + ']'
    código = '↓' if completa else ' '
    código += '✗' if not mejora else '✓'\
              if completa else '…'
    print('{0:>6s} {1:>6s}'.\
          format(récord, escribe_número(ct)),
          código, p)

if __name__ == '__main__':
    print(bb())
