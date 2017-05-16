subroutine transf(pola,polo,inla,inlo,outla,outlo)
!****** Transform of spherical coordinates according to a new pole
!***** INPUT AND OUTPUT DATA IN SPHERICAL COORDINATES, in RAD!!
real pi
real pola,polo,inla,inlo,outla,outlo
real delta_o,cos_outla,sin_outla,sin_outlo,cos_outlo
pi=3.14159265
delta_o=polo-inlo

cos_outla=cos(inla)*cos(pola)+sin(inla)*sin(pola)*cos(delta_o)
outla=acos(cos_outla)
!sin_outla=sqrt(1.0-cos_outla*cos_outla) ! it is always postive
!outla=sin_outla/cos_outla
!outla=atan(outla)
!if(outla.lt.0)then
!   outla=outla+pi ! it is in (0,pi)
!endif

!sin_outlo=sin(inla)*sin(delta_o)/sin_outla
!sin_outlo=sin(inla)*sin(delta_o)/sin(outla)
!cos_outlo=(cos(inla)-cos(pola)*cos_outla)/sin(pola)/sin_outla
cos_outlo=(cos(inla)-cos(pola)*cos_outla)/sin(pola)/sin(outla)
!outlo=atan(sin_outlo/cos_outlo)
outlo=acos(cos_outlo) !outlo is in (0,pi)
!if(cos_outlo.lt.0.and.sin_outlo.lt.0)outlo=outlo-pi
!if(cos_outlo.lt.0.and.sin_outlo.gt.0)outlo=outlo+pi
if(inlo>polo.and.inlo-polo<pi.or.polo>inlo.and.polo-inlo>pi)outlo=-outlo
!if(outlo<-pi)outlo=outlo+2*pi

!if(inlo<polo.and.polo-<pi)outlo=pi-outlo
return
end subroutine
