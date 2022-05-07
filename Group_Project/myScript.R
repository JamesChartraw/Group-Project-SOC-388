load("Gender_UW_Schools.Rdata")
load("UWO_Gender_degrees.RData")

library(dplyr)
library(ggplot2)
library(stringr)

UWO_Females <- subset(Gender_1973_2021_UW_Schools, select=c(Year, `UW-Oshkosh Female`))

UWO_Males <- subset(Gender_1973_2021_UW_Schools, select=c(Year, `UW-Oshkosh Male`))

UWO_Female_Degrees <- subset(UWO_Gender_Degrees, Gender=="Female", select = c(Year, Gender, `Degrees Conferred`))

UWO_Male_Degrees <- subset(UWO_Gender_Degrees, Gender=="Male", select = c(Year, Gender, `Degrees Conferred`))

## Enrollment by Gender from 1974 to 2021
ggplot(data = UWO_Gender_Degrees, mapping = aes(x = Year, y = UWO_Gender_Degrees$`Degrees Conferred`)) +
  geom_line(aes(group = Gender))

Male_Pop_Degrees <- left_join(UWO_Male_Degrees, UWO_Males)

## Work in Progress! Trying to plot population of males and degrees earned by males by year.
ggplot(data = Male_Pop_Degrees, mapping = aes(x = `UW-Oshkosh Male`, y = `Degrees Conferred`)) +
  geom_point(aes(group = Year))
