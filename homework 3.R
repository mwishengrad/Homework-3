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

tempAnom <- read.csv("/cloud/project/activity03/climate-change.csv")

#PROMPT 1

tempAnom$date <- ymd(tempAnom$Day)

northAnom <- tempAnom %>%
  filter(Entity == "Northern Hemisphere")
southAnom <- tempAnom %>%
  filter(Entity == "Southern Hemisphere")

plot(northAnom$date, northAnom$temperature_anomaly,
     type = "b",
     pch = 19,
     xlab = "Year",
     ylab = "Temperature Anomaly (degrees C)",
     ylim = c(-2,2))

points(southAnom$date, southAnom$temperature_anomaly,
       type = "b",
       pch = 19,
       col = "darkgoldenrod")

legend("topleft",
       c("Northern Hemisphere", "Southern Hemisphere"),
       col = c("black", "darkgoldenrod"),
       pch = 19, bty = "n")

tempAnom$Entity <- as.factor(tempAnom$Entity)

hemi <- tempAnom %>%
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

country <- dat.CO2 %>%
  filter(Entity == "United States" | 
           Entity =="Japan" | 
           Entity == "India" | 
           Entity == "Russia" | 
           Entity == "Germany"
            )%>%
  filter(Year > 1850)
  
ggplot(country,
       aes(x=CO2/1000000000, y=Year, color=Entity))+
  geom_point(size = 1)+
  theme_classic()+
  labs(x ="Fossil Fuel Emissions(billions of tons CO2)", y = "Year")



#QUESTION 2

worldCO2 <- dat.CO2 %>%
  filter(Entity == "World") %>%
  filter(Year >= 1880)

worldTemp <- tempAnom %>%
  filter(Entity == "World")


#Looked scale functions on ggplot website as way to change x axis values

ggplot(worldTemp,
       aes(x = date, y= temperature_anomaly))+
  geom_point(color = "midnightblue", size = 1.5)+
  scale_x_date(breaks = c(as.Date("1880/1/1"),
                          as.Date("1900/1/1"),
                          as.Date("1920/1/1"),
                          as.Date("1940/1/1"),
                          as.Date("1960/1/1"),
                          as.Date("1980/1/1"),
                          as.Date("2000/1/1"),
                          as.Date("2020/1/1")), 
               date_labels = "%Y")+
  theme_classic()+
  labs(x = "Year", y= "Temperature Annomaly")


ggplot(worldCO2,
       aes(x = Year, y= CO2/1000000000))+
  geom_point(color = "maroon", size = 1.5)+
  geom_line(color = "maroon")+
  scale_x_continuous(breaks = seq(1880,2020,20))+
  theme_classic()+
  labs(y="Fossil Fuel Emissions (billions of tons CO2)")


#QUESTION 3

livingPlanet <- read.csv("/cloud/project/living-planet-index-by-region/living-planet-index-by-region.csv")


livingPlanet <- livingPlanet %>%
  filter(Entity != "Freshwater", Entity != "World")

ggplot(livingPlanet,
       aes(x = Year, y=Living.Planet.Index, color = Entity))+
  geom_point(size = 0.5)+
  geom_line()+
  labs(y= "Avg. Wildlife Pop. Decline (1970 = 100%)", color = "")+
  scale_y_continuous(breaks = seq(0,140,20))+
  theme_classic()
