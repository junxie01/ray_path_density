subroutine check(j,k,stla,stlo,evla,evlo,pola,polo,n,flag)
! the stla stlo evla evlo have unit in DEG
! the pola polo have unit in rad
! minor arc, n=1; major arc, n=2;
! check if the line cross the tiny grid
! flag=1 if cross, otherwise flag=0
real stla,stlo,evla,evlo
real stla1,stlo1,evla1,evlo1
!!output data
real sta,sto,eva,evo
real a1,a2,a3,a4
real b1,b2,b3,b4
real d1,d2,d3,d4
!real e1,e2,e3,e4
!!output data
real x0,y0,dx,dy
real x1,x2,y1,y2
real pola,polo
real pola1,polo1
real a,pi
integer j,k,flag
integer mx,my,n
common/para/ x0,y0,dx,dy,mx,my
pi=3.14159265
a=pi/180.0
x1=(j-1)*dx+x0
x2=(j)*dx+x0
y1=(k-1)*dy+y0
y2=(k)*dy+y0
!change into unit rad
x1=(90-x1)*a
x2=(90-x2)*a
y1=y1*a
y2=y2*a
!write(*,*)evla,evlo,stla,stlo
!write(*,*)evla,evlo,stla,stlo,pola,polo
call transf(pola,polo,x1,y1,a1,b1)
call transf(pola,polo,x1,y2,a2,b2)
call transf(pola,polo,x2,y2,a3,b3)
call transf(pola,polo,x2,y1,a4,b4)
a1=90-a1/a
b1=b1/a
a2=90-a2/a
b2=b2/a
a3=90-a3/a
b3=b3/a
a4=90-a4/a
b4=b4/a
sta=90-stla/a
sto=stlo/a
eva=90-evla/a
evo=evlo/a

if(b1<0)b1=b1+360
if(b2<0)b2=b2+360
if(b3<0)b3=b3+360
if(b4<0)b4=b4+360
if(evo<0)evo=evo+360
if(sto<0)sto=sto+360

!write(*,*)b1,b2,b3,b4,evo,sto
d1=(b1-evo)*(b1-sto)
d2=(b2-evo)*(b2-sto)
d3=(b3-evo)*(b3-sto)
d4=(b4-evo)*(b4-sto)
!write(*,'(2i5,6f15.5)')j,k,min(a1,a2,a3,a4),max(a1,a2,a3,a4),d1,d2,d3,d4
!,sta,eva
!write(*,*)sta,eva

!e1=d1*d2
!e2=d2*d3
!e3=d3*d4
!e4=d4*d1
if(min(a1,a2,a3,a4)<min(sta,eva).and.max(a1,a2,a3,a4)>max(sta,eva))then
!if(e1<0.or.e2<0.or.e3<0.or.e4<0)then
   if(n==1)then
      if(abs(evo-sto)<180)then
         if(d1<0.and.d2<0.or.d1<0.and.d4<0.or.d2<0.and.d3<0.or.d3<0.and.d4<0)then
!      if(d1<0.or.d2<0.or.d3<0.or.d4<0)then
!         if(e1>0.or.e2>0.or.e3>0.or.e4>0)then
            flag=1
            return
!         endif
          else  
            flag=0
            return
          endif
      else
         if(d1>0.and.d2>0.or.d2>0.and.d3>0.or.d3>0.and.d4>0.or.d1>0.and.d4>0)then
            flag=1
            return
         else
            flag=0
            return
         endif
      endif
   else if(n==2)then
      if(abs(evo-sto)<180)then
         if(d1>0.and.d2>0.or.d2>0.and.d3>0.or.d3>0.and.d4>0.or.d1>0.and.d4>0)then
            flag=1
            return
         else
            flag=0
            return
         endif
      else
         if(d1<0.and.d2<0.or.d1<0.and.d4<0.or.d2<0.and.d3<0.or.d3<0.and.d4<0)then
!      if(d1<0.or.d2<0.or.d3<0.or.d4<0)then
!         if(e1>0.or.e2>0.or.e3>0.or.e4>0)then
            flag=1
            return
!         endif
          else  
            flag=0
            return
          endif
      endif
   endif
else
   flag=0
   return
endif
end subroutine
