subroutine newpol(sta1,sto1,sta2,sto2,pola,polo)
!***** INPUT in GEOGRAPHICAL COORDINATES in DEG!!
!***** OUTPUT in rad!!
!***** This new polar (pola,polo) is close to the north polar
!***** sta1 should be smaller than sta2
real sta1,sto1,sta2,sto2,pola,polo
real pi,a,delta_ab,ab,a1,o1,a2,o2
real cos_pab,sin_pab,tan_pab,cos_paps,sin_paps,tan_paps
real cos_AB,sin_AB,cos_pola,sin_pola,cos_apps,sin_apps,apps,tan_apps
integer INDEX
pi=3.14159265
a=pi/180.
! change in to rad.
! suppose the dot 1 is A, dot 2 is B , the Polar is P, the new Polar is P' (ps)
a1=(90-sta1)*a
a2=(90-sta2)*a
o1=sto1*a
o2=sto2*a
delta_ab=o2-o1
! find the cos_AB  and sin_AB
cos_AB=cos(a2)*cos(a1)+sin(a2)*sin(a1)*cos(delta_ab)
sin_AB=sqrt(1.0-cos_AB*cos_AB) !ab belongs to (0,pi) so sin_ab should be postive
!find the angle <PAB
cos_pab=(cos(a2)-cos(a1)*cos_AB)/sin(a1)/sin_AB
sin_pab=sin(a2)*sin(delta_ab)/sin_AB ! should be always large than 0
!tan_nab=sin(rsta2)*sin(delta_ab)*sin(rsta1)/(cos(rsta2)-cos(rsta1)*cos_ab)
tan_pab=sin_pab/cos_pab

cos_pola=sin(a1)*sin_pab !? -> check_mark
!cos(pps)=cos(psa)*cos(a1)+sin(psa)*sin(a1)*cos(paps)=sin(a1)*sin(pab)
pola=acos(cos_pola) ! pola is in (0,pi)
sin_pola=sin(pola)

cos_apps=-cos(a1)*cos_pola/sin(a1)/sin_pola
apps=acos(cos_apps)! apps is in (0,pi)
!cos(psa)=cos(pps)*cos(pa)+sin(pps)*sin(pa)*cos(pspa)=0
!sin_apps=cos_pab/sin_pola
!sin(apps)=sin(paps)/sin(pps)
!tan_apps=sin_apps/cos_apps
!apps=pi+atan(tan_apps) !apps has to be (0,pi)
!if(o1>o2.and.o1-o2<=pi.or.o2>o1.and.o2-o1>pi)then
   polo=o1+apps
   if(polo>pi)then
      polo=polo-2*pi
   endif 
!else
call transf(pola,polo,a2,o2,a_tmp,o_tmp)
if(a_tmp.ne.0)then
   polo=o1-apps
   if(polo<-pi)then
      polo=2*pi+polo
   endif
endif
!endif

!write(*,*)'a_tmp=',a_tmp
!   if(polo.gt.0)then
!      polo=polo-pi
!   else
!      polo=polo+pi
!   endif
!endif
!pola=90-pola/a
!polo=polo/a
return
end subroutine
