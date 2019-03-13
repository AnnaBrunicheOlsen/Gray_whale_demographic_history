library("plyr")
library("reshape2")
library("ggplot2")

#########################
#### Bootstrap files ####
#########################

#read all 112 bootstrap result files
bootstrap.112 <- lapply(Sys.glob("out.112_bootstrap_*.txt"), read.delim)
length(bootstrap.112)
names(bootstrap.112) <- paste("112_bootstrap", seq(1, 20, 1), sep="")
names(bootstrap.112)
#convert list to data frame
bootstrap.112.df <- ldply(bootstrap.112, data.frame)
head(bootstrap.112.df)

#read all 213 bootstrap result files
bootstrap.213 <- lapply(Sys.glob("out.213_bootstrap_*.txt"), read.delim)
length(bootstrap.213)
names(bootstrap.213) <- paste("213_bootstrap", seq(1, 20, 1), sep="")
bootstrap.213.df <- ldply(bootstrap.213, data.frame)
head(bootstrap.213.df)

#read all EGW bootstrap result files
bootstrap.EGW <- lapply(Sys.glob("out.EGW_bootstrap_*.txt"), read.delim)
length(bootstrap.EGW)
names(bootstrap.EGW) <- paste("EGW_bootstrap", seq(1, 20, 1), sep="")
bootstrap.EGW.df <- ldply(bootstrap.EGW, data.frame)
head(bootstrap.EGW.df)

#########################
#### Direct estimate ####
#########################

# read the 112 direct estimate result file
direct.112 <- read.delim("out.112.final.txt")
#keep the header same as the previous dataframe for a convenience of rbind
direct.112[".id"] <- rep("direct.112", length(direct.112$time))
head(direct.112)
#reorder the columns
direct.112 <- direct.112[, c(3, 1, 2)]
head(direct.112)

# read the 213 direct estimate result file
direct.213 <- read.delim("out.213.final.txt")
direct.213[".id"] <- rep("direct.213", length(direct.213$time))
direct.213 <- direct.213[, c(3, 1, 2)]
head(direct.213)

# read the EGW direct estimate result file
direct.EGW <- read.delim("out.EGW.final.txt")
direct.EGW[".id"] <- rep("direct.EGW", length(direct.EGW$time))
direct.EGW <- direct.EGW[, c(3, 1, 2)]
head(direct.EGW)

##############
#### Plot ####
##############

#add a new column for all the data frames in order for the color assignment
bootstrap.112.df["group"] <- "WGW1 bootstrapping estimate"
bootstrap.213.df["group"] <- "WGW2 bootstrapping estimate"
bootstrap.EGW.df["group"] <- "EGW bootstrapping estimate"
direct.112["group"] <- "WGW1 direct estimate"
direct.213["group"] <- "WGW2 direct estimate"
direct.EGW["group"] <- "EGW direct estimate"

#combine into a big dataframe
df <- rbind(bootstrap.112.df, bootstrap.213.df, bootstrap.EGW.df, direct.112, direct.213, direct.EGW)

##try to find out ggplot2 default color assignment
#gg_color_hue <- function(n) {
#  hues = seq(15, 375, length=n+1)
#  hcl(h=hues, l=65, c=100)[1:n]
#}
#cols <- gg_color_hue(2)
#cols

#try to feed the same color scheme for maize and teosinte as those used in the Tim's figures
ggplot(data=df, aes(x=time, y=Ne, group=.id, color=group)) + geom_line() + scale_x_log10() + scale_y_log10() + xlab("years (u=3e-8, generation=1)") + ylab("effective population size") + theme_bw() + scale_color_manual(name="", values=c("maize direct estimate"="black", "maize bootstrapping estimate"="#F8766D", "teosinte direct estimate"="black", "teosinte bootstrapping estimate"="#3300FF")) + theme(legend.position=c(0.8, 0.9))
ggsave("TIL.BKN.boostrapping.msmc.pdf")
savehistory("msmc.bootstrapping.figures.R")
