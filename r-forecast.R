install.packages("forecast")
library("forecast")
# data from - http://future.aae.wisc.edu/data/monthly_values/by_area/317?area=US&gtype=bar&yoy=true
# cleaned up and stored as .csv
icecream = read.csv("D:\\Projects\\tlc\\Data\\icecream-sales.csv")
head(icecream)

# how does data look
summary(icecream)
boxplot(icecream)
barplot(icecream$sales)
means = aggregate(icecream$sales, by=list(icecream$sales), FUN=mean) 
barplot(means$x, names.arg=means$Group.1) 
# most informative gives you the spread
hist(icecream$sales)
rug(jitter(icecream$sales)) 
lines(density(icecream$sales), col="blue", lwd=1) 




# very easy in r to create time series with own frequency
icecream.ts = ts(icecream,frequency=12,start=c(2008,1))
head(icecream.ts)

#seasonal decomposition
monthplot(icecream.ts)
seasonplot(icecream.ts)

plot (icecream.ts)
# and just like that
icecream.fs = forecast(icecream.ts)

icecream.fs

icecream.fs$method

plot(icecream.fs)

# you like HoltWinters?
fit_h = HoltWinters(icecream.ts)
forecast(fit_h, 12)
plot(forecast(fit_h, 12))

# hindsight
l = lag(icecream.ts, 12)
plot(l)

# ARIMA ? 
fit_a = arima(icecream.ts)

plot(forecast(fit_a, 5))

# auto.ARIMA ? 
fit_auto = auto.arima(icecream.ts)

plot(forecast(fit_auto, 12))

# exponential ? 
fit_exp = ets(icecream.ts)

plot(forecast(fit_exp, 12))

# bats  ? 
fit_bats = bats(icecream.ts)

plot(forecast(fit_bats, 12))

