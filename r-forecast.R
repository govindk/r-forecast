install.packages("forecast")
library("forecast")
# data from - http://future.aae.wisc.edu/data/monthly_values/by_area/317?area=US&gtype=bar&yoy=true
# cleaned up and stored as .csv
icecream = read.csv("D:\\Projects\\tlc\\Data\\icecream-sales.csv")
icecream

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
fit_h = HoltWinters(icecream.ts,beta=FALSE, gamma=FALSE)
forecast(fit_h, 3)
plot(forecast(fit_h, 3))

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