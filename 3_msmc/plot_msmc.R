PLOT msmc for individuals

setwd("/Users/AnnaBO/Documents/grey_whale_WGS/msmc")

# u <- 4.8e-10 #sub/bp/year
# taken from Alter et al. 2007

# from Rice et al 1971 and Heppell et al 2000
# 15.5 to 22.28 years 
gen <- 15.5+((22.28-15.5)/2)

mu <- 4.8e-10 *gen #sub/bp/gen
# taken from Alter et al. 2007

####### plot Ne through time #######
# the 3 data files
w112 <-read.table("112.final.txt", header=TRUE)
w213 <-read.table("213.final.txt", header=TRUE)
egw <- read.table("EGW.final.txt", header=TRUE)

# header explanation
# time_index left_time_boundary right_time_boundary lambda_00
# first column denotes a simple index of all time segments
# second and third indicate the scaled start and end time for each time interval
# Fourth column contains the scaled coalescence rate estimate in that interval

# make the Ne plot
pdf("msmc Ne plot IND.pdf", width=8, height=5)

plot(w112$left_time_boundary/mu*gen, (1/w112$lambda)/mu, log="x",ylim=c(0,40000), xaxt='n',
     type="n", xlim=c(10000, 1000000), xlab="Years before present", ylab="Effective population size")
axis(1, at=seq(1E4, 1E6, len=21), labels=c("10^4", rep(NA,9), "10^5", rep(NA,9), "10^6"))
lines(w112$left_time_boundary/mu*gen, (1/w112$lambda)/mu, type="s", col="cornflowerblue", lwd=2)
lines(w213$left_time_boundary/mu*gen, (1/w213$lambda)/mu, type="s", col="blue", lwd=2)
lines(egw$left_time_boundary/mu*gen, (1/egw$lambda)/mu, type="s", col="red", lwd=2)
legend("bottomright",legend=c("WGW1", "WGW2", "EGW"), col=c("cornflowerblue", "blue", "red"), lwd=2, lty=c(1,1,1,1))

dev.off()

# END
