#!/bin/sh
ps=$2
tscale=`gmt gmtinfo -T1/2 dens.dat`
gmt makecpt -Cseis -I $tscale >hot.cpt
gmt xyz2grd -Ghot.grd -I6 dens.dat -Rd 
gmt grdsample -I1/1 hot.grd -Ghot1.grd
#gmt grdimage hot.grd -Rd -JG150/0/18c -Ba45f15g6/a45f15g6WSNE -Chot.cpt -K -P -fig >$ps.ps
gmt grdimage hot1.grd -Rd -JQ6i -Ba30f30g30/a30f30g30WSNE -Chot.cpt -K -P -fig -Y2i>$ps.ps
lo=`gawk '{print $2;}' PARAM`
la=`gawk '{print $5;}' PARAM`
#gmt pscoast -Rd -JQ7i -Ba${la}f${la}g$la/a${lo}f${lo}g${lo} -Ggrey -W0.1p -K -P -Y2i>$ps.ps
#gmt pscoast -Rd -JG80/0/18c -Ba${la}f${la}g$la/a${lo}f${lo}g${lo} -Ggrey -W0.1p -K -P -Y2i>$ps.ps
#gmt pscoast -Rd -JG150/0/18c -B -Ggrey -W0.1p -K -O>>$ps.ps
gmt pscoast -Rd -J -B -W0.1p -K -O>>$ps.ps
#gawk '$3!=0{print $1,$2,"15 0 4 BL",$3}' dens.dat | gmt pstext -Rd -J -B -Gred -O -K >>$ps.ps
#gawk '{if($3==0)print $1,$2,"10 0 4 BL",$3}' dens.dat | pstext -Rd -J -B -Gblack -O -K >>$ps.ps
#gawk '{print $2,$1}' R25.txt | gmt psxy -Rd -J -B -Sc0.2i -Gred -O -K >>$ps.ps
#gawk '{print $4,$3}' R25.txt | gmt psxy -Rd -J -B -Sc0.2i -Gred -O -K >>$ps.ps
#gmt psxy -Rd -J -B -W1p,red -O -K >>$ps.ps<<eof
#`gawk 'NR==1{print $2,$1}' R25.txt`
#`gawk 'NR==1{print $4,$3}' R25.txt`
#eof
#gmt psxy -Rd -J -B -W1p,red -O -K >>$ps.ps<<eof
#`gawk 'NR==2{print $2,$1}' R25.txt`
#`gawk 'NR==2{print $4,$3}' R25.txt`
#eof
	#echo 122.825569 48.9198761 | gmt psxy -Rd -J -B -Sc0.1i -Gblack -O >>$ps.ps
#echo -57.1744347 -48.9198761 | gmt psxy -Rd -J -B -Sc0.1i -Gblack -O -K >>$ps.ps
#echo 70.5744629      -48.9198761 | gmt psxy -Rd -J -B -Sc0.1i -Gblack -O -K >>$ps.ps
awk '{print $4,$3}' $1 | gmt psxy -Rd -J -B -St0.1i -Gblack -O -K >>$ps.ps
awk '{print $7,$6}' $1 | gmt psxy -Rd -J -B -Ss0.1i -Gblack -O -K >>$ps.ps
gmt psscale -Rd -J -D3i/4.5i/6i/0.4h -Chot.cpt -B1000 -E -O >>$ps.ps
##gmt psxy -Rd -J -B -W1p,red -O -K >>$ps.ps<<eof
#-57.1744347 -48.9198761
#`gawk '{print $2,$1}' R25.txt`
#eof
#gmt psxy -Rd -J -B -W1p,red -O -K >>$ps.ps<<eof
#`gawk '{print $4,$3}' R25.txt`
#-57.1744347 -48.9198761
#eof
