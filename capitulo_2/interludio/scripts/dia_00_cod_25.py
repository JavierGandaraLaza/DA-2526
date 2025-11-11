# -*- coding: utf-8 -*-

# dia_00_cod_25.py

import networkx as nx

import dia_00_cod_19 as base
# import dia_00_cod_20 as base

def suma_costes(aristas):
    return sum([a[2]['tiempo'] for a in aristas])

class Parcial_ct(base.Parcial):

    def mínimo(self, v, S):
        return min([self.grafo[v][x]['tiempo'] for x in S])

    def mst(self, S):
        sub = self.grafo.subgraph(S)
        aux = list(nx.minimum_spanning_edges(sub,
                                             weight='tiempo'))
        return aux

    def cota(self):
        resto = [x for x in self.grafo.nodes\
                 if x not in self.lista]
        if resto:
            aux1 = self.mínimo(self.lista[0], resto)
            aux2 = suma_costes(self.mst(resto))
            aux3 = self.mínimo(self.lista[-1], resto)
            return aux1 + aux2 + aux3 + self.coste()
        else:
            aux = self.cierra()
            return aux.coste()
