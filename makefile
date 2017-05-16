FC=gfortran
subjects=dot_dens.o transf.o newpol.o check.o 
all: dot_dens
dot_dens: $(subjects)
	$(FC) $(subjects) -o dot_dens
%.o:%.f90
	$(FC) $< -c
clean:
	-rm $(subjects)
