!gfortran -O3 -mcmodel=medium phon.f90 -llapack -o phon.x
!ifort -O3 -mkl phon.f90
Program phon
implicit none
integer, parameter :: natom = 500
integer, parameter :: N = natom*3
integer,parameter :: lwork = 51000
character(len=*), parameter :: fname1 = "dynmat.dat"
real(kind=8),allocatable :: matrix(:,:),mat(:,:),work(:)
real(kind=8),allocatable :: row(:,:)
integer :: i,j,info
real(kind=8) :: eig(N),E(N-1),tau(N-1),dummy(1)

allocate(matrix(N,N))
allocate(mat(N,N))
allocate(row(natom,3))
allocate(work(lwork))
open(1, file = fname1)
do i = 1,N
   do j = 1,natom
      read(1,*) row(j,1), row(j,2), row(j,3)
   enddo
   matrix(i,:) = reshape(transpose(row),[N])
enddo
close(1)
mat = (matrix + transpose(matrix))/2 ! make the DM symmetric
!call DSYTRD('U',N,mat,N,eig,E,tau,work,lwork,info)
!call dgeev('N','N',N,mat,N,eig,eig1,mat1,N,mat2,N,work,lwork,info)
call DSYEV('N','U',N,mat,N,eig,work,lwork,info)
write(*,*) info,work(1)
open(3,file='eigvalues.dat')
do i = 1,N
   write(3,*) eig(i)
enddo
close(3)
end program
