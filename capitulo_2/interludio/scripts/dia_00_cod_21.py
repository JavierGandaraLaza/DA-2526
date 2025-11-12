#! /usr/bin/env python3

# dia_00_cod_21.py
#
# Resuelve el problema del viajante mediante búsqueda
# exhaustiva.

import dia_00_cod_20 as dt
# import dia_00_cod_19 as dt

def ordenados(fich):
    lista = [(cic, cic.coste())\
             for cic in dt.ciclos(fich)]

    # Ordena la lista.

    lista.sort(key=lambda tupla: tupla[1])

    # Presenta los resultados.

    m = len(str(lista[-1][1]))
    f = open('ordenados.txt', 'w')
    for cic, t in lista:
        f.write(str(cic) + ':\t{0:>{1}d}\n'.format(t, m))
    f.close()
    cic, t = lista[0]
    print(cic, '\t', t, 'minutos')

if __name__ == '__main__':
    ordenados('dia_00_cod_15.txt')
