#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# dia_00_cod_07.py
#
# Espacio de búsqueda de tamaño n! (matrices permutación)

class Parcial:
    """Clase para almacenar una configuaración parcial de
    varias reinas en un tablero de ajedrez.

    Hay una reina en cada una de las primeras filas del
    tablero.
    """

    def __init__(self, n):
        # Esta lista almacena la columna que ocupa la reina de
        # cada fila.
        self.posiciones = list()
        self.tam = n

    def completa(self):
        """Determina si la configuración tiene tantas reinas
        como filas y columnas el tablero.
        """

        return self.tam == len(self.posiciones)

    def conflicto(self):
        """Determina si alguna pareja de reinas comparte
        diagonal.
        """

        k = len(self.posiciones)
        for i in range(k):
            for j in range(i):
                inc_f = i - j
                inc_c = self.posiciones[i]\
                        - self.posiciones[j]
                if inc_f == abs(inc_c):
                    return True
        return False

    def coloca(self, col):
        """Construye una configuración ampliada."""

        p = Parcial(self.tam)
        if len(self.posiciones) < self.tam:
            p.posiciones = self.posiciones.copy()
            p.posiciones.append(col)
            return p

    def amplía(self):
        """Generador de las posibles ampliaciones.

        Se añade una reina en la primera fila libre,
        ocupando una columna libre.
        """
        for col in range(self.tam):
            if col in self.posiciones:
                continue
            yield self.coloca(col)

    # def __repr__(self):
    #     return str(self.posiciones)

    def __repr__(self):
        aux = '\n'
        for i in range(self.tam):
            aux += '·' * self.posiciones[i] + '*'\
                   + '·' * (self.tam - self.posiciones[i] - 1)\
                   + '\n'
        # aux += '\n'
        return aux

    @staticmethod
    def opciones(n):
        """Generador de las configuraciones completas."""

        vacía = Parcial(n)
        yield from vacía.derivadas()

    def derivadas(self):
        """Generador de las configuraciones completas que
        contienen self.
        """

        if self.completa():
            yield self
        else:
            for ampliada in self.amplía():
                yield from ampliada.derivadas()
