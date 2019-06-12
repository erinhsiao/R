library(readr)
library(threejs)
library(flipChartBasics)

meteorites <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-11/meteorites.csv")

current=as.numeric(format(Sys.Date(),"%Y"))
meteorites$history = current-as.numeric(meteorites$year)

df=meteorites[,c("lat","long","mass","history")]

colors=as.numeric(cut(df$history,breaks=quantile(df$history,probs=seq(0,1,0.1),include.lowest=TRUE,na.rm=TRUE)))
palette=ChartColors(10,"Strong colors",reverse=TRUE)
colors=palette[colors]
earth = "http://eoimages.gsfc.nasa.gov/images/imagerecords/73000/73909/world.topo.bathy.200412.3x5400x2700.jpg"

#Alternative: add names of continents on map and save it as a new file
#earth = "world2.jpg"

globejs(img=earth,s
  lat=df$lat,
  long=df$long,
  val=2*log(df$mass),
  color=colors,
  pointsize=0.5,
  atmosphere=TRUE)