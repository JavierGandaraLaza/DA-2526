# -*- coding: utf-8 -*-

# dia_00_cod_03.py
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
        """Determina si la reina de la última fila ocupada
        entra en conflicto (diagonal) con alguna otra.
        """

        k = len(self.posiciones)
        for i in range(k - 1):
            inc_f = k - 1 - i
            inc_c = self.posiciones[k - 1]\
                    - self.posiciones[i]
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
        return aux
        # return '\n' +\
        #     '\n'.join(['·' * self.posiciones[i] + '*' + '·'\
        #                * (self.tam - self.posiciones[i] - 1)\
        #                for i in range(self.tam)]) + '\n'
