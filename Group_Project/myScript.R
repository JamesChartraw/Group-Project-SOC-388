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

## Create degrees conferred per year per gender
UWO_Degrees_Enrollment <- merge(UWO_Gender_Degrees,UWO_Males, by = 'Year')
UWO_Degrees_Enrollment <- merge(UWO_Degrees_Enrollment, UWO_Females, by = 'Year')

#UWO enrollment by Gender
ggplot(data = UWO_Degrees_Enrollment,aes(x=`Year`)) +
  geom_line(aes(y=`UW-Oshkosh Male`, color = "Male"), size = 2) +
  geom_line(aes(y=`UW-Oshkosh Female`, color = "Female"), size = 2) +
  ggtitle("UWO enrollment by Gender") +
  ylab("Number of enrollments") +
  theme_bw() +
  theme(legend.title = element_blank() , plot.title = element_text(size = 22))

#UWO Degrees Conferred by Gender
ggplot(data = UWO_Degrees_Enrollment, aes(x=`Year`, group = Gender)) +
  geom_line(aes(y=`Degrees Conferred`, color = Gender),size=2) +
  scale_x_continuous(name = "Year") +
  ggtitle("Degrees Conferred by Gender") +
  theme(legend.title = element_blank(), plot.title = element_text(size = 22)) +
  theme_bw()
  
