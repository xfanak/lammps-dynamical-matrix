# lammps-dynamical-matrix
Use lammps to obtain dynamical matrix, and the corresponding fortran post-processing codes.

The KSPACE, MOLECULE, and USER-PHONON, and other necessary packages must be enabled when compling lammps. 

Part of the input files are supplied here, the obtained DM can be processed using the FORTRAN code. 

To compile the FORTRAN code:
gfortran -O3 phon.f90 -llapack -o DM.x

The resulted eigenvalues are in unit of 1/fs, i. e. 1e15 Hz. 
