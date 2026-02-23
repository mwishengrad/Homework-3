install.packages(c("ggplot2", "dplyr"))
library(ggplot2)
library(dplyr)


dat.CO2 <- read.csv("/cloud/project/activity03/annual-co-emissions-by-region.csv")

colnames(dat.CO2)[4] <- "CO2"

dat.CO2$Entity <- as.factor(dat.CO2$Entity)

US <- dat.CO2 %>%
  filter(Entity == "United States")

plot(US$Year, US$CO2,
     type = "b", 
     pch = 19,
     xlab = "Year",
     ylab = "Fossil Fuel emissions(billions of tons CO2)",
     yaxt = "n")

axis(2, seq(0,6000000000, by=2000000000),
     seq(0,6, by = 2),
     las = 2)

ggplot(US, aes(x = Year, y=CO2)) +
  geom_point()+
  geom_line()+
  labs(x="Year", y="US fossil fuel CO2 emissions (tons CO2)" )+
  theme_classic()

NorthA <- dat.CO2 %>%
  filter(Entity == "United States" | 
           Entity == "Mexico" | 
           Entity == "Canada")

ggplot(NorthA,
       aes(x=Year, y=CO2, color=Entity))+
  geom_point()+
  geom_line()+
  scale_color_manual(values = c("red", "royalblue","darkgoldenrod"))+
  theme_classic()

#BEGINING OF PROMPTS

install.packages(c("lubridate"))
library(lubridate)

tempAnon <- read.csv("/cloud/project/activity03/climate-change.csv")

#PROMPT 1

tempAnon$date <- ymd(tempAnon$Day)

northAnon <- tempAnon %>%
  filter(Entity == "Northern Hemisphere")
southAnon <- tempAnon %>%
  filter(Entity == "Southern Hemisphere")

plot(northAnon$date, northAnon$temperature_anomaly,
     type = "b",
     pch = 19,
     xlab = "Year",
     ylab = "Temperature Anomaly (degrees C)",
     ylim = c(-2,2))

points(southAnon$date, southAnon$temperature_anomaly,
       type = "b",
       pch = 19,
       col = "darkgoldenrod")

legend("topleft",
       c("Northern Hemisphere", "Southern Hemisphere"),
       col = c("black", "darkgoldenrod"),
       pch = 19, bty = "n")

tempAnon$Entity <- as.factor(tempAnon$Entity)

hemi <- tempAnon %>%
  filter(Entity == "Northern Hemisphere"| Entity == "Southern Hemisphere")

ggplot(hemi,
       aes(x = date, y= temperature_anomaly, color=Entity))+
  geom_point()+
  geom_line()+
  scale_color_manual(values = c("black","darkgoldenrod"))+
  theme_classic()

#Prompt 2

totalCO2 <- dat.CO2 %>%
  filter(Entity =="United States" | Entity == "Canada" | Entity == "Mexico") %>%
  group_by(Entity) %>%
  summarise(total = sum(CO2))

ggplot(totalCO2,
       aes(x = Entity, y= total, colour = Entity, fill = Entity))+
  geom_col()+
  labs(x="Country", y="Total all time emissions")+
  theme_classic()

#BEGINING OF HOMEWORK

#QUESTION 1
