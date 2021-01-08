# Multilevel-Change-Detection

This code is an implementation of the change detection algorithm from the manuscript

Julio Enrique Castrillon. Change Detection: A functional analysis perspective.  Arxiv (2020)
https://arxiv.org/abs/2012.09141 
 
 
 
Please cite this manuscript if you use this code for your research.

Note that in this code I use several other matlab packages from various authors. I am thankful 
for the "Space Partitioning Trees" matlab code provided by Nakul Verma

http://cseweb.ucsd.edu/~naverma/SpatialTrees/index.html

Learning the structure of manifolds using random projections.
Y. Freund, S. Dasgupta, M. Kabra and N. Verma.
In Neural Information Processing Systems (NIPS), 2007.


--------------------------------------------------------------------------------------------------


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
