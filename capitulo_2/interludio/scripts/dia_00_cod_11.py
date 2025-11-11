#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# dia_00_cod_11.py
#
# Espacio de búsqueda de tamaño binomial(n², n)

class Parcial:
    """Clase para almacenar una configuaración parcial de
    varias reinas en un tablero de ajedrez.

    Sin restricciones a priori en las posiciones.
    """

    def __init__(self, n):
        # Esta lista almacena las coordenadas de cada reina.
        self.posiciones = list()
        self.tam = n

    def completa(self):
        """Determina si la configuración tiene tantas reinas
        como filas y columnas el tablero.
        """

        return self.tam == len(self.posiciones)

    def conflicto(self):
        """Determina si última reina colocada entra en
        conflicto (fila, columna o diagonal) con alguna otra.
        """
        k = len(self.posiciones)
        if not self.posiciones:
            return False
        x1, y1 = self.posiciones[-1]
        for x2, y2 in self.posiciones[:-1]:
            inc_f = x1 - x2
            if inc_f == 0:
                return True          # misma fila
            inc_c = y1 - y2
            if inc_c == 0:
                return True          # misma columna
            if inc_f == abs(inc_c):
                return True          # misma diagonal
        return False

    def coloca(self, f, c):
        """Construye una configuración ampliada."""

        p = Parcial(self.tam)
        if len(self.posiciones) < self.tam:
            p.posiciones = self.posiciones.copy()
            p.posiciones.append((f, c))
            return p

    def amplía(self):
        """Generador de las posibles ampliaciones.

        Todas las reinas están en filas anteriores o en la
        misma fila pero en columnas previas a la que se
        añade.
        """
        if len(self.posiciones) == 0:
            x, y = 0, -1
        else:
            x, y = self.posiciones[-1]
        for c in range(y + 1, self.tam):
            yield self.coloca(x, c)
        for f in range(x + 1, self.tam):
            for c in range(self.tam):
                yield self.coloca(f, c)

    # def __repr__(self):
    #     return str(self.posiciones)

    def __repr__(self):
        aux = '\n'
        iterador = iter(self.posiciones)
        x, y = next(iterador, (False, False))
        for f in range(self.tam):
            for c in range(self.tam):
                if (x, y) == (f, c):
                    aux += '*'
                    x, y = next(iterador, (False, False))
                else:
                    aux += '·'
            aux += '\n'
        return aux
