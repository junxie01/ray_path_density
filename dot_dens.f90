program dot_dens
parameter(nd=100,np=1000000)
integer dens(nd,nd),r(np)
real stla(np),stlo(np),evla(np),evlo(np)
real sla(nd),x0,y0,dx,dy
real x,y,pola,polo,tmp
real c,d,e,f ! new coordinates of the path points
character(len=80):: fname,input,string
integer ierr,ios,mx,my,flag
integer i,j,n,npath,isla,islo,iela,ielo
logical ext
common/para/ x0,y0,dx,dy,mx,my
a=3.14159265/180.
n=iargc()
if(n.ne.1)then
  write(*,*)'Usage: density path_file'
  return
endif
call getarg(1,input)
inquire(file=input,exist=ext)
if(.not.ext)then
      ierr = -1
      write(*,*)'Path_file not exist.'
      call exit(-1)
endif
open(4,file=input)
npath=0
loop:do
      read(4,'(a)',iostat=ios) string
      if (ios < 0) exit loop
      npath=npath+1
      enddo loop
if(npath==0)then
      write(*,*)'No ray path found!'
      return
endif
write(*,'(i8," path found!")')npath
rewind(4)
do i=1,npath
      read(4,*)stla(i),stlo(i),evla(i),evlo(i),r(i)
enddo
close(4)
inquire(file='PARAM',exist=ext)
if(.not.ext)then
      write(*,*)'PARAM file not found'
      call exit(-1) 
endif
open(27,file='PARAM')
      read(27,*)x0,dx,mx,y0,dy,my
     ! x is lantitude, y is longtitude
close(27)
!write(*,*)x0,dx,mx,y0,dy,my
dens=0
do i=1,npath
           isla=(stla(i)-x0)/dx+1
           islo=(stlo(i)-y0)/dy+1
           iela=(evla(i)-x0)/dx+1
           ielo=(evlo(i)-y0)/dy+1
           if(stla(i)>evla(i))then
                  tmp=stla(i)
                  stla(i)=evla(i)
                  evla(i)=tmp
                  tmp=stlo(i)
                  stlo(i)=evlo(i)
                  evlo(i)=tmp
           endif
!   write(*,*)'The coordinates of the path are:'
!   write(*,*)stla(i),stlo(i),evla(i),evlo(i)
           call newpol(stla(i),stlo(i),evla(i),evlo(i),pola,polo)
           call transf(pola,polo,(90-stla(i))*a,stlo(i)*a,c,d)
           call transf(pola,polo,(90-evla(i))*a,evlo(i)*a,e,f)
!   write(*,*)'The new coordinates are:'
!   write(*,*)90-c/a,d/a,90-e/a,f/a
!   e=pola/a
!   f=pola/a+180
!   if(f>180)f=f-360
!   write(*,*)'The new polar is ',e,90-pola/a
!   write(*,*)'The anti polar is ',f,pola/a-90
!   dens(isla,islo)=dens(isla,islo)+1
!   dens(iela,ielo)=dens(iela,ielo)+1
          do j=1,mx ! loop over lantitude
                     do k=1,my ! loop voer longtitude
!         call check(j,k,stla(i),stlo(i),evla(i),evlo(i),pola,polo,r(i),flag)
                               call check(j,k,c,d,e,f,pola,polo,r(i),flag)
                               if(flag==1)then
                                          dens(j,k)=dens(j,k)+1 
                               endif
                     enddo 
          enddo
enddo     !end loop over path
open(12,file='dens.dat')
do i=1,mx
   do j=1,my
      !write(12,*)(j)*dy+y0,(i)*dx+x0,dens(i,j)
      write(12,*)(j-1)*dy+y0,(i-1)*dx+x0,dens(i,j)
   enddo
enddo
close(12)
end program
