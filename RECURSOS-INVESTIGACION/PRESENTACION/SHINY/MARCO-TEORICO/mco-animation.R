# Charge libraries:
library(ggplot2)
library(gganimate)

dat <- cars
dat$nd <- 1:nrow(cars)

x <- ggplot(dat, aes(x=dist, y=speed)) + 
    geom_point() +
    geom_abline(intercept = 1, aes(slope=nd)) + 
    transition_time(nd)


anim2 <- ggplot(airquality, aes(Day, Temp)) +
    geom_point(aes(colour = factor(Month))) +
    transition_time(Day, range = c(10L, 20L))
