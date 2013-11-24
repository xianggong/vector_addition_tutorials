program main
 
    ! Size of vectors
    integer :: n = 100000
 
    ! Input vectors
    real(8),dimension(:),allocatable :: a
    real(8),dimension(:),allocatable :: b
    ! Output vector
    real(8),dimension(:),allocatable :: c
 
    integer :: i
    real(8) :: sum
 
    ! Allocate memory for each vector
    allocate(a(n))
    allocate(b(n))
    allocate(c(n))
 
    ! Initialize content of input vectors, vector a[i] = sin(i)^2 vector b[i] = cos(i)^2
    do i=1,n
        a(i) = sin(i*1D0)*sin(i*1D0)
        b(i) = cos(i*1D0)*cos(i*1D0)
    enddo
 
    ! Sum component wise and save result into vector c, perform reduction sum on c
 
    !$acc kernels !copyin(a(1:n),b(1:n)), copyout(c(1:n))
    do i=1,n
        c(i) = a(i) + b(i)
        sum = sum +  c(i)
    enddo
    !$acc end kernels
 
    ! Divide the sum by n, the final result should be 1.0 within error
    sum = sum/n
    print *, 'final result: ', sum
 
    ! Release memory
    deallocate(a)
    deallocate(b)
    deallocate(c)
 
end program
