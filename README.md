# Multilevel-Change-Detection

This code is an implementation of the change detection algorithm from the manuscript

Julio Enrique Castrillon. Change Detection: A functional analysis perspective.  Arxiv (2020)
 
Please cite this manuscript if you use this code for your research.

The details of the two examples that can be found in the manuscript.

To initialize the code:

1. In matlab make sure you are in the source directory
2. Type "paths" to create all the necessary paths for the code.

The examples in the paper can be run with the following m files:


3. testKL1D.m: (Example 2 & 3) Implementation of change detection of one dimensional
              Karhunen Loeve (KL) expansions of a stochastic process.

4. testSHKL.m: (Example 4) Implementation of change detection of Spherical Fractional Browninan Motion
             on spherical domain.
             
Although these examples are restricted on 1D and spherical domains, the code is 
flexible and easily extendable to more complex topologies. 
