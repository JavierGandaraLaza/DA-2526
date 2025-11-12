# -*- coding: utf-8 -*-

# dia_00_cod_19.py
#
# Clase para las soluciones parciales del problema del
# viajante.

import networkx as nx

def carga_datos(fich):
    """Lee del fichero «fich» los datos de entrada, siguiendo
    el siguiente formato:
    ----------------------------
    Santander - Oviedo   207
    Santander - León     293
    Oviedo    - León     118
    ----------------------------

    Devuelve en grafo como un objeto de NetworkX.
    """

    grafo = nx.Graph()
    f = open(fich)
    for l in f:
        l = l.split()
        a = l[0]
        b = l[2]
        t = int(l[3])
        grafo.add_edge(a, b, tiempo=t)
    f.close()

    # Comprobación
    n = grafo.order()
    s = grafo.size()
    if 2 * s == n * (n - 1):
        return grafo
    else:
        raise BaseException('El grafo no es completo.')

# Cada ciclo se genera por duplicado (si hay más de dos nodos).
def ciclos(fich):
    """Genera los ciclos hamiltonianos de un grafo completo."""

    c = Parcial(fich)
    yield from c.ciclos()

# Cada camino se representa mediante una lista de nodos.
#
# Los ciclos orientados se corresponden con permutaciones de
# (len(nodos) - 1) elementos, fijando cierto nodo de
# referencia.
#
# De esta manera, este módulo genera cada ciclo dos veces, a
# partir de una permutación y de su inversa.

class Parcial:

    def __init__(self, fich=None):
        """Genera un camino vacío o, si se cargan los datos del
        grafo, consistente en el primer vértice aislado.
        """

        if fich:
            self.grafo = carga_datos(fich)
            self.lista = list(self.grafo.nodes)[:1]
            self.faltan = list(self.grafo.nodes)[1:]
        else:
            self.grafo = nx.Graph()
            self.lista = list()
            self.faltan = list()

    def es_completa(self):
        return self.longitud() == self.grafo.order() + 1

    def es_camino_completo(self):
        return self.longitud() == self.grafo.order()

    def copia(self):
        aux = self.__class__()
        aux.grafo = self.grafo.copy()
        aux.lista = self.lista.copy()
        aux.faltan = self.faltan.copy()
        return aux

    def coste(self):
        return sum([self.grafo[org][dst]['tiempo']\
                    for org, dst in\
                    zip(self.lista[:-1], self.lista[1:])])

    def __repr__(self):
        return ' → '.join(self.lista)

    def longitud(self):
        return len(self.lista)

    def cierra(self):
        if self.es_completa():
            return self
        else:
            nuevo = self.copia()
            nuevo.lista.append(self.lista[0])
            return nuevo

    def amplía(self):
        k = self.grafo.order() - self.longitud()
        if k == -1:
            # circuito completo
            pass
        elif k == 0:
            yield self.cierra()
        else:
            for x in self.faltan:
                nuevo = self.copia()
                nuevo.lista.append(x)
                nuevo.faltan.remove(x)
                if k <= 2:
                    # una única compleción posible
                    yield from nuevo.amplía()
                else:
                    yield nuevo

    def ciclos(self):
        """Generador de los ciclos que contienen a self."""

        if self.es_completa():
            yield self
        else:
            for ap in self.amplía():
                yield from ap.ciclos()






