program main
parameter(nd=1000)
integer dens(nd,nd)
real laA, loA,laB,loB,pi,rad
real a0,newa,newo,tmp
integer i,j
pi=3.141592653
rad=pi/180.0
dens=0
open(4,file=input)
do i=1,npath
   read(4,*)laA,loA,laB,loB,r
enddo
close(4)
open(27,file='PARAM')
read(27,*)x0,dx,mx,y0,dy,my
close(27)
laA=laA*rad
laB=laB*rad
loA=loA*rad
loB=loB*rad
if(laA.gt.laB)then
   tmp=laA
   laA=laB
   laB=tmp
   tmp=loA
   loA=loB
   loB=tmp
endif
a0=atan((tan(laA)*sin(lob)-tan(lab)*sin(loa))/(tan(laa)*cos(lob)-tan(lab)*cos(loa)))
i=(laA/rad-x0)/dx
j=(loa/rad-y0)/dy
dens(i,j)=1
newa=laA/rad+dy/rad
newo=loA/rad+dx/rad
end program
