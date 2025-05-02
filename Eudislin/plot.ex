include std/ffi.e

include dislin.e

scrmod("revers")
metafl("cons")
disini()
pagera()
complx()

frame(3)
axspos(400,1850)
axslen(2400,1400)

name("Longitude","x")
name("Latitude","y")
titlin("World Coastlines and Lakes",3)

labels("map","xy")
grafmp(-180.0,180.0,-180.0,90.0,-90.0,90.0,-90.0,30.0)

gridmp(1,1)
color("green")
world()
color("fore")

height(50)
title()
disfin()
­29.0